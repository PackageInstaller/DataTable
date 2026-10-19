using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class ModifyPanelCompInitData
{
	public List<ModifyPanelCompData> CompDatas { get; }

	public Action<ModifyPanelCompBase> SelectAction { get; }

	public Action<CustomUICompType, Vector2> RecordPosAction { get; }

	public Action<CustomUICompType, Vector2> RecordPosDeltaAction { get; }

	public Action<CustomUICompType, float> SetDiameterAction { get; }

	public Func<ModifyPanelCompBase, bool> CheckOverlapFunc { get; }

	public Action<ModifyPanelCompBase> ResetTransformAction { get; }

	public ModifyPanelCompInitData(List<ModifyPanelCompData> compDatas, Action<ModifyPanelCompBase> selectAction, Action<CustomUICompType, Vector2> recordPosAction, Action<CustomUICompType, Vector2> recordPosDeltaAction, Action<CustomUICompType, float> setDiameterAction, Func<ModifyPanelCompBase, bool> checkOverlapFunc, Action<ModifyPanelCompBase> resetTransformAction)
	{
		CompDatas = compDatas;
		SelectAction = selectAction;
		RecordPosAction = recordPosAction;
		RecordPosDeltaAction = recordPosDeltaAction;
		SetDiameterAction = setDiameterAction;
		CheckOverlapFunc = checkOverlapFunc;
		ResetTransformAction = resetTransformAction;
	}
}
