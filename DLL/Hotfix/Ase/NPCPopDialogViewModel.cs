#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class NPCPopDialogViewModel : OptionBase
{
	private Dictionary<int, NPCDialogData> npcDialogDatas = new Dictionary<int, NPCDialogData>();

	private InteractionRequest updatePosRequest = new InteractionRequest();

	private InteractionRequest<NPCDialogData> showDialogRequest = new InteractionRequest<NPCDialogData>();

	private InteractionRequest<NPCDialogData> closeDialogRequest = new InteractionRequest<NPCDialogData>();

	public Action updatePosCall;

	public Dictionary<int, NPCDialogData> NpcDialogDatas => npcDialogDatas;

	public IInteractionRequest UpdatePosRequest => updatePosRequest;

	public IInteractionRequest ShowDialogRequest => showDialogRequest;

	public IInteractionRequest CloseDialogRequest => closeDialogRequest;

	public void UpdateAllPos(Camera camera)
	{
		if (camera == null)
		{
			return;
		}
		foreach (NPCDialogData value in npcDialogDatas.Values)
		{
			value.pos = UIUtilly.ScenePosToScreenPos(camera, value.posOri);
		}
		updatePosCall?.Invoke();
	}

	public void ShowBubbles(int npcId, int bubbleId, Vector3 posOri, Vector3 pos)
	{
		DRBubbleQueue bubbleQueue = GameEntry.DataTable.GetDataRow((DRBubbleQueue p) => p.Id == bubbleId);
		if (bubbleQueue == null)
		{
			Log.Error($"BubbleQueue 表找不到Id为【{bubbleId}】的数据！");
			return;
		}
		List<string> list = new List<string>();
		List<float> list2 = new List<float>();
		List<bool> list3 = new List<bool>();
		int i;
		for (i = 0; i < bubbleQueue.GroupList.Count; i++)
		{
			DRBubble dataRow = GameEntry.DataTable.GetDataRow((DRBubble p) => p.Id == bubbleQueue.GroupList[i]);
			if (dataRow == null)
			{
				Log.Error($"Bubble 表找不到Id为【{bubbleQueue.GroupList[i]}】的数据！");
			}
			else if (dataRow.Judge == 1)
			{
				list.Add(dataRow.Text);
				list2.Add(dataRow.Frames);
				list3.Add(item: false);
			}
			else
			{
				list.Add(dataRow.Icon);
				list2.Add(dataRow.Frames);
				list3.Add(item: true);
			}
		}
		ShowDialog(npcId, list, posOri, pos, list2, list3);
	}

	public void ShowDialog(int id, List<string> texts, Vector3 posOri, Vector3 pos, List<float> duratime, List<bool> isSticker)
	{
		CloseBubbles(id);
		NPCDialogData nPCDialogData = new NPCDialogData(id, texts, posOri, pos, duratime, isSticker);
		npcDialogDatas.Add(id, nPCDialogData);
		showDialogRequest.Raise(nPCDialogData);
	}

	public void CloseBubbles(int id)
	{
		if (npcDialogDatas.ContainsKey(id))
		{
			closeDialogRequest.Raise(npcDialogDatas[id]);
			npcDialogDatas.Remove(id);
		}
	}

	public override void Close()
	{
		updatePosCall = null;
		base.Close();
	}
}
