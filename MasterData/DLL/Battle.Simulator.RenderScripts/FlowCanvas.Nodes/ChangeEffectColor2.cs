using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改特效颜色(rgba)", 0)]
[Category("Render/函数")]
[Description("修改特效颜色")]
public class ChangeEffectColor2 : CallableActionNode<int, string, int, int, int, int, Dictionary<int, List<GameObject>>, int>
{
	public override void Invoke(int buffID, string materialPath, int r, int g, int b, int a, Dictionary<int, List<GameObject>> buffCollection, int index)
	{
		if (!buffCollection.TryGetValue(buffID, out var value))
		{
			return;
		}
		try
		{
			GameObject gameObject = value[index];
			MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
			materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), new Color32((byte)r, (byte)g, (byte)b, (byte)a));
			gameObject.transform.Find(materialPath).GetComponent<Renderer>().SetPropertyBlock(materialPropertyBlock);
		}
		catch (Exception)
		{
			Debug.Log("修改特效颜色失败" + materialPath);
		}
	}
}
