using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ModifyPanelCompGroup : ModifyPanelCompBase
{
	[SerializeReference]
	private ModifyPanelCompSingle[] _singleComps;

	public override CustomUICompShapeType ShapeType => CustomUICompShapeType.Rectangle;

	public override bool UseDiameter => false;

	public override void Init(ModifyPanelCompInitData initData)
	{
		ModifyPanelCompSingle[] singleComps = _singleComps;
		foreach (ModifyPanelCompSingle modifyPanelCompSingle in singleComps)
		{
			modifyPanelCompSingle.InGroup = true;
			modifyPanelCompSingle.Init(SplitInitData(initData, modifyPanelCompSingle.selfType));
		}
		_selectAction = initData.SelectAction;
		_checkOverlapFunc = initData.CheckOverlapFunc;
		_resetTransformAction = initData.ResetTransformAction;
		ChangeState(ModifyPanelCompState.Normal);
		SetRect();
	}

	public override void SetTransform(List<ModifyPanelCompData> compDatas)
	{
		ModifyPanelCompSingle[] singleComps = _singleComps;
		foreach (ModifyPanelCompSingle singleComp in singleComps)
		{
			singleComp.SetTransform(compDatas.Find((ModifyPanelCompData _) => _.Type == singleComp.selfType));
		}
	}

	private void SetRect()
	{
		float num = float.MaxValue;
		float num2 = float.MinValue;
		float num3 = float.MaxValue;
		float num4 = float.MinValue;
		ModifyPanelCompSingle[] singleComps = _singleComps;
		foreach (ModifyPanelCompSingle modifyPanelCompSingle in singleComps)
		{
			num = Mathf.Min(num, modifyPanelCompSingle.RT.localPosition.x + modifyPanelCompSingle.RT.rect.xMin);
			num2 = Mathf.Max(num2, modifyPanelCompSingle.RT.localPosition.x + modifyPanelCompSingle.RT.rect.xMax);
			num3 = Mathf.Min(num3, modifyPanelCompSingle.RT.localPosition.y + modifyPanelCompSingle.RT.rect.yMin);
			num4 = Mathf.Max(num4, modifyPanelCompSingle.RT.localPosition.y + modifyPanelCompSingle.RT.rect.yMax);
		}
		SetPos(new Vector2((num + num2) / 2f, (num3 + num4) / 2f));
		RT.sizeDelta = new Vector2(num2 - num, num4 - num3);
	}

	public override void GetTypes(out List<CustomUICompType> types)
	{
		types = new List<CustomUICompType>();
		ModifyPanelCompSingle[] singleComps = _singleComps;
		for (int i = 0; i < singleComps.Length; i++)
		{
			singleComps[i].GetTypes(out var types2);
			types.AddRange(types2);
		}
	}

	private ModifyPanelCompInitData SplitInitData(ModifyPanelCompInitData initData, CustomUICompType type)
	{
		ModifyPanelCompData item = null;
		foreach (ModifyPanelCompData compData in initData.CompDatas)
		{
			if (compData.Type == type)
			{
				item = compData;
			}
		}
		return new ModifyPanelCompInitData(new List<ModifyPanelCompData> { item }, initData.SelectAction, initData.RecordPosAction, initData.RecordPosDeltaAction, initData.SetDiameterAction, initData.CheckOverlapFunc, initData.ResetTransformAction);
	}

	public override void OnPosModifyBtnLongClick(Vector2 posDelta)
	{
		SetPosDelta(posDelta);
		ModifyPanelCompSingle[] singleComps = _singleComps;
		for (int i = 0; i < singleComps.Length; i++)
		{
			singleComps[i].OnPosModifyBtnLongClick(posDelta);
		}
		CheckOverlap();
	}

	public override void OnPosModifyBtnUp()
	{
		ModifyPanelCompSingle[] singleComps = _singleComps;
		for (int i = 0; i < singleComps.Length; i++)
		{
			singleComps[i].RecordPos();
		}
		_ = _validModify;
	}

	public override void OnDiameterSliderValChange(float newDiameter)
	{
	}

	public override void OnDiameterSliderUp()
	{
	}

	public override void OnEdgeOffsetChange(Vector2 compPosDelta)
	{
		SetPosDelta(compPosDelta);
		ModifyPanelCompSingle[] singleComps = _singleComps;
		for (int i = 0; i < singleComps.Length; i++)
		{
			singleComps[i].OnEdgeOffsetChange(compPosDelta);
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		SetLastPointerPos(eventData);
		SetPosDelta(_pointerDelta);
		ModifyPanelCompSingle[] singleComps = _singleComps;
		for (int i = 0; i < singleComps.Length; i++)
		{
			singleComps[i].SetPosDelta(_pointerDelta);
		}
		CheckOverlap();
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		ModifyPanelCompSingle[] singleComps = _singleComps;
		for (int i = 0; i < singleComps.Length; i++)
		{
			singleComps[i].RecordPos();
		}
		_ = _validModify;
	}
}
