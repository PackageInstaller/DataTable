using System;
using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

public class ColorPuzzle : SerializedMonoBehaviour
{
	[Serializable]
	public class Line
	{
		public ColorPuzzleNode[] nodes;

		public bool Match
		{
			get
			{
				if ((from node in nodes
					group node by node.Value).All((IGrouping<int, ColorPuzzleNode> group) => group.Count() <= 1))
				{
					return nodes.All((ColorPuzzleNode node) => node.Value != -1);
				}
				return false;
			}
		}

		internal void SetValues(int[] lineValues)
		{
			for (int i = 0; i < lineValues.Length; i++)
			{
				ColorPuzzleNode obj = nodes[i];
				int value = lineValues[i];
				obj.Value = value;
			}
		}

		internal void SetHints(int[] lineValues)
		{
			for (int i = 0; i < lineValues.Length; i++)
			{
				ColorPuzzleNode obj = nodes[i];
				int hint = lineValues[i];
				obj.Hint = hint;
			}
		}
	}

	[NoToLua]
	public Sprite[] pallete;

	[NoToLua]
	public ToggleGroup select;

	[NoToLua]
	public GameObject palleteToggle;

	public const int NODE_EMPTY_VALUE = -1;

	[NoToLua]
	public Action OnPuzzleComlete;

	[NoToLua]
	public Action<bool> OnClickNode;

	[NoToLua]
	public Action<int, int> BeforeNodeApplyValue;

	public List<Line> lines;

	private List<ISet<Line>> zones;

	internal List<ISet<Line>> Zones
	{
		get
		{
			if (zones == null || zones.Count == 0)
			{
				CalcZone();
			}
			return zones;
		}
	}

	public int CurSelect { get; internal set; } = -1;

	private void Start()
	{
		if (pallete != null)
		{
			UpdatePalleteToggle();
		}
		CalcZone();
		Solve();
	}

	private void CalcZone()
	{
		zones = new List<ISet<Line>>();
		foreach (Line lineAddToZone in lines)
		{
			if (zones.Any((ISet<Line> set) => set.Contains(lineAddToZone)))
			{
				continue;
			}
			HashSet<Line> hashSet = new HashSet<Line> { lineAddToZone };
			Queue<ColorPuzzleNode> queue = new Queue<ColorPuzzleNode>(lineAddToZone.nodes);
			HashSet<ColorPuzzleNode> hashSet2 = new HashSet<ColorPuzzleNode>();
			while (queue.Count > 0)
			{
				ColorPuzzleNode node = queue.Dequeue();
				if (!hashSet2.Add(node))
				{
					continue;
				}
				foreach (Line item2 in lines.Where((Line line) => line != lineAddToZone && line.nodes.Any((ColorPuzzleNode colorPuzzleNode) => colorPuzzleNode == node)))
				{
					ColorPuzzleNode[] nodes = item2.nodes;
					foreach (ColorPuzzleNode item in nodes)
					{
						queue.Enqueue(item);
					}
					hashSet.Add(item2);
				}
			}
			zones.Add(hashSet);
		}
	}

	internal Sprite GetNodeSprite(int value)
	{
		if (value < 0 || value >= pallete.Length)
		{
			return null;
		}
		return pallete[value];
	}

	public void SetPallete(Sprite[] sprites)
	{
		pallete = sprites;
		UpdatePalleteToggle();
	}

	private void UpdatePalleteToggle()
	{
		int childCount = select.transform.childCount;
		for (int i = 0; i < pallete.Length; i++)
		{
			GameObject gameObject;
			if (i >= childCount)
			{
				gameObject = UnityEngine.Object.Instantiate(palleteToggle, select.transform);
				gameObject.hideFlags = HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
			}
			else
			{
				gameObject = select.transform.GetChild(i).gameObject;
			}
			gameObject.SetActive(value: true);
			SetupPalleteToggle(gameObject, pallete[i], CurSelect == i);
		}
		if (!select.AnyTogglesOn())
		{
			CurSelect = -1;
		}
		for (int j = pallete.Length; j < select.transform.childCount; j++)
		{
			select.transform.GetChild(j).gameObject.SetActive(value: false);
		}
	}

	private void SetupPalleteToggle(GameObject toggleObj, Sprite sprite, bool isOn)
	{
		Toggle componentInChildren = toggleObj.GetComponentInChildren<Toggle>();
		componentInChildren.image.sprite = sprite;
		componentInChildren.isOn = isOn;
	}

	[NoToLua]
	public void OnPalleteToggleOn(GameObject palleteToggleObj)
	{
		int curSelect = (select.GetFirstActiveToggle() ? palleteToggleObj.transform.GetSiblingIndex() : (-1));
		CurSelect = curSelect;
		PlaySoundEffect("ui_system_3_0", "ui_page");
	}

	private bool LineIsValid(Line line)
	{
		if (line.nodes.Where((ColorPuzzleNode node) => node.valueFixed).All((ColorPuzzleNode node) => node.Value != -1))
		{
			return line.nodes.Length <= pallete.Length;
		}
		return false;
	}

	public bool Solve()
	{
		return Zones.All(Solve);
	}

	protected bool Solve(IEnumerable<Line> lines)
	{
		Stack<Line> notCheckedLines = new Stack<Line>(lines);
		return Solve(notCheckedLines);
	}

	private bool Solve(Stack<Line> notCheckedLines)
	{
		if (notCheckedLines.Count > 0)
		{
			Line line = notCheckedLines.Pop();
			if (!LineIsValid(line) || (from node in line.nodes
				where node.Value != -1
				group node by node.Value).Any((IGrouping<int, ColorPuzzleNode> g) => g.Count() > 1))
			{
				notCheckedLines.Push(line);
				return false;
			}
			int[] values = line.nodes.Select((ColorPuzzleNode node) => node.Value).ToArray();
			foreach (int[] item in EnumerateValueCombination(line))
			{
				line.SetValues(item);
				if (Solve(notCheckedLines))
				{
					line.SetValues(values);
					line.SetHints(item);
					return true;
				}
			}
			line.SetValues(values);
			notCheckedLines.Push(line);
			return false;
		}
		return true;
	}

	private IEnumerable<int[]> EnumerateValueCombination(Line line)
	{
		int[] result = line.nodes.Select((ColorPuzzleNode node) => node.Value).ToArray();
		int[] freeValue = Enumerable.Range(0, pallete.Length).Except(line.nodes.Select((ColorPuzzleNode node) => node.Value)).ToArray();
		int[] emptyNodeIdx = (from idx in Enumerable.Range(0, result.Length)
			where result[idx] == -1
			select idx).ToArray();
		int pickCnt = emptyNodeIdx.Length;
		foreach (int[] item in EnumerateCombination(freeValue.Length, pickCnt))
		{
			for (int num = 0; num < item.Length; num++)
			{
				int num2 = item[num];
				int num3 = emptyNodeIdx[num];
				result[num3] = freeValue[num2];
			}
			yield return result;
		}
	}

	private static IEnumerable<int[]> EnumerateCombination(int choiceRange, int pickCnt, int[] result = null)
	{
		if (result == null)
		{
			result = new int[pickCnt];
		}
		if (pickCnt == 0)
		{
			yield return result;
			yield break;
		}
		int curIdx = pickCnt - 1;
		IEnumerable<int> enumerable = Enumerable.Range(0, choiceRange);
		foreach (int v in enumerable)
		{
			foreach (int[] item in EnumerateCombination(choiceRange, pickCnt - 1, result))
			{
				_ = item;
				if (!result.Take(curIdx).Contains(v))
				{
					result[curIdx] = v;
					yield return result;
				}
			}
		}
	}

	public void AutoComplete()
	{
		foreach (ColorPuzzleNode item in lines.SelectMany((Line line) => line.nodes))
		{
			item.Value = item.Hint;
		}
		CheckComplete();
	}

	public bool CheckComplete(bool showConflict = false)
	{
		IEnumerable<Line> enumerable = lines.Where((Line line) => !line.Match);
		if (enumerable.Any())
		{
			if (showConflict)
			{
				foreach (Line item in enumerable)
				{
					Dictionary<int, int> dictionary = (from node in item.nodes
						where node.Value != -1
						group node by node.Value).ToDictionary((IGrouping<int, ColorPuzzleNode> g) => g.Key, (IGrouping<int, ColorPuzzleNode> g) => g.Count());
					ColorPuzzleNode[] nodes = item.nodes;
					foreach (ColorPuzzleNode colorPuzzleNode in nodes)
					{
						if (!dictionary.TryGetValue(colorPuzzleNode.Value, out var value))
						{
							value = 0;
						}
						if (value > 1 || colorPuzzleNode.Value == -1)
						{
							colorPuzzleNode.OnNotifyConflict();
						}
					}
				}
			}
			return false;
		}
		return true;
	}

	public void ClearNodes()
	{
		foreach (ColorPuzzleNode item in lines.SelectMany((Line line) => line.nodes))
		{
			if (!item.valueFixed)
			{
				item.Value = -1;
			}
		}
	}

	public void SetOnNodeClickCallback(Action<bool> callback)
	{
		OnClickNode = callback;
	}

	public void SetOnCompleteCallback(Action callback)
	{
		OnPuzzleComlete = callback;
	}

	public void SetBeforeApplyValueCallback(Action<int, int> action)
	{
		BeforeNodeApplyValue = action;
	}

	internal static void PlaySoundEffect(string cueSheet, string cueName)
	{
		AudioManager.Instance.Play("effect", cueSheet, cueName, useStream: false);
	}
}
