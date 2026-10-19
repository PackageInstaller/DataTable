using System;
using System.Collections.Generic;
using ACT.Model;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ModifyPanelCompSingle : ModifyPanelCompBase
{
	public CustomUICompType selfType;

	private bool _inGroup;

	private Action<CustomUICompType, Vector2> _recordPosAction;

	private Action<CustomUICompType, Vector2> _recordPosDeltaAction;

	private Action<CustomUICompType, float> _recordDiameterAction;

	public override CustomUICompShapeType ShapeType => Model<CustomUIModel>.Interface.Scheme.Standard.GetShapeType(selfType);

	public override bool UseDiameter => Model<CustomUIModel>.Interface.Scheme.Standard.GetUseDiameter(selfType);

	public bool InGroup
	{
		get
		{
			return _inGroup;
		}
		set
		{
			_inGroup = value;
			GetComponent<MonoEmptyForRaycast>().raycastTarget = !value;
		}
	}

	public override void Init(ModifyPanelCompInitData initData)
	{
		base.Init(initData);
		SetTransform(initData.CompDatas[0]);
		if (!_inGroup)
		{
			ChangeState(ModifyPanelCompState.Normal);
			_selectAction = initData.SelectAction;
			_checkOverlapFunc = initData.CheckOverlapFunc;
			_resetTransformAction = initData.ResetTransformAction;
		}
		_recordPosAction = initData.RecordPosAction;
		_recordPosDeltaAction = initData.RecordPosDeltaAction;
		_recordDiameterAction = initData.SetDiameterAction;
	}

	public override void SetTransform(List<ModifyPanelCompData> compDatas)
	{
		SetTransform(compDatas[0]);
	}

	public void SetTransform(ModifyPanelCompData compData)
	{
		SetAnchor(compData.AnchorX, compData.AnchorY);
		SetPos(compData.Pos);
		SetDiameter(compData.Diameter);
	}

	public override void GetTypes(out List<CustomUICompType> types)
	{
		types = new List<CustomUICompType> { selfType };
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (!_inGroup)
		{
			SetLastPointerPos(eventData);
			SetPosDelta(_pointerDelta);
			CheckOverlap();
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		RecordPos();
		_ = _validModify;
	}

	public override void RecordPos()
	{
		_recordPosAction?.Invoke(selfType, _curPos);
	}

	public override void RecordPosDelta(Vector2 posDelta)
	{
		_recordPosDeltaAction?.Invoke(selfType, posDelta);
	}

	public override void RecordDiameter()
	{
		_recordDiameterAction?.Invoke(selfType, _curDiameter);
	}

	public override void OnPosModifyBtnUp()
	{
		RecordPos();
		_ = _validModify;
	}

	public override void OnPosModifyBtnLongClick(Vector2 posDelta)
	{
		SetPosDelta(posDelta);
		if (!_inGroup)
		{
			CheckOverlap();
		}
	}

	public override void OnDiameterSliderValChange(float newDiameter)
	{
		SetDiameter(newDiameter);
		if (!_inGroup)
		{
			CheckOverlap();
		}
	}

	public override void OnDiameterSliderUp()
	{
		RecordDiameter();
		_ = _validModify;
	}

	public override void OnEdgeOffsetChange(Vector2 compPosDelta)
	{
		SetPosDelta(compPosDelta);
		RecordPosDelta(compPosDelta);
	}
}
