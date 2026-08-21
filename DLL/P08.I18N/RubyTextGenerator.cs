using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.UI;

[DisallowMultipleComponent]
public class RubyTextGenerator : MonoBehaviour, IMeshModifier
{
	private List<RubyData> rubyDataList = new List<RubyData>();

	private List<GameObject> rubyGoList = new List<GameObject>();

	private Text textComponent;

	private string lastTextContent = string.Empty;

	private void Awake()
	{
		textComponent = GetComponent<Text>();
		textComponent.RegisterDirtyVerticesCallback(OnTextChange);
	}

	private void OnTextChange()
	{
		string text = textComponent.text;
		string text2 = RemoveRubyTag(text);
		if (!lastTextContent.Equals(text2))
		{
			UpdateRubyData(text);
			lastTextContent = text2;
		}
		if (rubyDataList.Count == 0)
		{
			ResetRubyGo();
		}
		textComponent.text = text2;
	}

	public void ResetRubyGo()
	{
		for (int i = 0; i < rubyGoList.Count; i++)
		{
			rubyGoList[i].SetActive(value: false);
		}
	}

	public void ModifyMesh(Mesh mesh)
	{
		using VertexHelper vertexHelper = new VertexHelper(mesh);
		ModifyMesh(vertexHelper);
		vertexHelper.FillMesh(mesh);
	}

	public void ModifyMesh(VertexHelper toFill)
	{
		if (rubyDataList.Count > 0)
		{
			FillRubyData(toFill);
			textComponent.StartCoroutine(GenerateRubyTextCoroutine());
		}
	}

	public void FillRubyData(VertexHelper toFill)
	{
		for (int i = 0; i < rubyDataList.Count; i++)
		{
			RubyData rubyData = rubyDataList[i];
			int startIndex = rubyData.startIndex;
			int endIndex = rubyData.endIndex;
			float num = 0f;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = float.MinValue;
			Color color = Color.white;
			UIVertex vertex = default(UIVertex);
			UIVertex vertex2 = default(UIVertex);
			for (int j = startIndex; j <= endIndex; j++)
			{
				toFill.PopulateUIVertex(ref vertex, j * 4);
				toFill.PopulateUIVertex(ref vertex2, j * 4 + 1);
				num2 += vertex2.position.x - vertex.position.x;
				num4 = ((num4 < vertex.position.y) ? vertex.position.y : num4);
				if (j == startIndex)
				{
					num = vertex.position.x;
					color = vertex.color;
				}
				if (j == endIndex)
				{
					color.a = (int)vertex.color.a;
				}
			}
			num3 = num + num2 / 2f;
			rubyData.totalWidth = num2;
			rubyData.posX = num3;
			rubyData.posY = num4;
			rubyData.color = color;
			rubyData.isFilled = true;
		}
	}

	public void UpdateRubyData(string text)
	{
		rubyDataList = new List<RubyData>();
		string text2 = OnlyReserveRubyTag(text);
		string pattern = "<ruby>|<rt>|</rt>|</ruby>";
		Match match = Regex.Match(text2, pattern);
		while (match.Success)
		{
			string value = match.Value;
			if (value.Equals("<ruby>"))
			{
				rubyDataList.Add(new RubyData(match.Index));
				text2 = text2.Remove(match.Index, match.Length);
			}
			else if (value.Equals("<rt>"))
			{
				RubyData rubyData = rubyDataList[rubyDataList.Count - 1];
				rubyData.endIndex = match.Index - 1;
				rubyData.rubyContentStartIndex = match.Index;
				text2 = text2.Remove(match.Index, match.Length);
			}
			else if (value.Equals("</rt>"))
			{
				RubyData rubyData2 = rubyDataList[rubyDataList.Count - 1];
				rubyData2.rubyContentEndIndex = match.Index - 1;
				text2 = text2.Remove(match.Index, match.Length);
				int num = rubyData2.rubyContentEndIndex - rubyData2.rubyContentStartIndex + 1;
				rubyData2.rubyContent = text2.Substring(rubyData2.rubyContentStartIndex, num);
				text2 = text2.Remove(rubyData2.rubyContentStartIndex, num);
			}
			else if (value.Equals("</ruby>"))
			{
				text2 = text2.Remove(match.Index, match.Length);
			}
			match = Regex.Match(text2, pattern);
		}
	}

	public IEnumerator GenerateRubyTextCoroutine()
	{
		yield return null;
		GenerateRubyText();
	}

	public void GenerateRubyText()
	{
		if (textComponent == null || !base.isActiveAndEnabled)
		{
			return;
		}
		for (int i = 0; i < rubyDataList.Count; i++)
		{
			RubyData rubyData = rubyDataList[i];
			if (rubyData.isFilled)
			{
				GameObject rubyTagGo = GetRubyTagGo(i);
				Text componentInChildren = rubyTagGo.GetComponentInChildren<Text>();
				componentInChildren.rectTransform.sizeDelta = new Vector2(rubyData.totalWidth, componentInChildren.rectTransform.sizeDelta.y);
				componentInChildren.text = rubyData.rubyContent;
				componentInChildren.color = rubyData.color;
				Vector3 localPosition = rubyTagGo.transform.localPosition;
				rubyTagGo.transform.localPosition = new Vector3(rubyData.posX, rubyData.posY + 3f, localPosition.z);
			}
		}
		for (int j = rubyDataList.Count; j < rubyGoList.Count; j++)
		{
			rubyGoList[j].SetActive(value: false);
		}
	}

	public GameObject GetRubyTagGo(int index)
	{
		if (index == rubyGoList.Count)
		{
			GameObject gameObject = Asset.Instantiate("Widget/Common/Com_Prefab/rubyTextTemplate");
			gameObject.transform.SetParent(base.transform);
			rubyGoList.Add(gameObject);
		}
		rubyGoList[index].SetActive(value: true);
		return rubyGoList[index];
	}

	public string OnlyReserveRubyTag(string text)
	{
		string pattern = "\n            <              # 标签起始符\n            (?!            # 负向先行断言：排除以下结构\n                \\/?        # 允许闭合标签的斜线（如 </ruby>）\n                (ruby|rt)  # 目标保留的标签名\n                \\b         # 单词边界防止部分匹配（如 rubyx 不匹配）\n            )\n            [^>]+          # 匹配标签内容（含属性）\n            >              # 标签结束符\n            |[\\r\\n]+       # 替换换行符\n        ";
		return Regex.Replace(text, pattern, "", RegexOptions.IgnorePatternWhitespace);
	}

	public string RemoveRubyTag(string text)
	{
		return Regex.Replace(text, "<ruby>|</ruby>|<rt>.*?</rt>", "");
	}

	public string RemoveAllRichTag(string text)
	{
		string pattern = "<rt>.*?</rt>|<[^>]+>";
		return Regex.Replace(text, pattern, "");
	}
}
