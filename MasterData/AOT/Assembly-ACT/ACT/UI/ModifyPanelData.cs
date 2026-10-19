using System.Collections.Generic;
using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class ModifyPanelData
{
	private Dictionary<CustomUICompType, ModifyPanelCompData> _compDatas;

	public int Id { get; private set; }

	public string Name { get; private set; }

	public float EdgeOffset { get; private set; }

	public bool CanRename { get; }

	public bool CanDelete { get; }

	public bool CanSave { get; }

	public bool CanSaveAs { get; }

	public bool CanResetToTemplate { get; }

	public bool Dirty { get; private set; }

	public ModifyPanelData(CustomUIScheme scheme, bool useResetTemplate = false)
	{
		Id = scheme.Id;
		Name = scheme.GetName();
		CanRename = scheme.CanRename;
		CanDelete = scheme.CanDelete;
		CanSave = scheme.CanSave;
		CanSaveAs = scheme.CanSaveAs;
		CanResetToTemplate = scheme.Type == CustomUISchemeType.Custom;
		IEnumerable<KeyValuePair<CustomUICompType, CustomUITransform>> enumerable;
		if (!useResetTemplate || !CanResetToTemplate)
		{
			enumerable = scheme;
		}
		else
		{
			enumerable = scheme.GetResetTemplateTransforms();
		}
		_compDatas = new Dictionary<CustomUICompType, ModifyPanelCompData>();
		foreach (var (customUICompType2, customUITransform2) in enumerable)
		{
			_compDatas.Add(customUICompType2, new ModifyPanelCompData(customUICompType2, customUITransform2.AnchorX, customUITransform2.AnchorY, customUITransform2.Pos, customUITransform2.Diameter));
		}
	}

	public ModifyPanelCompData GetCompData(CustomUICompType type)
	{
		if (_compDatas.TryGetValue(type, out var value))
		{
			return value;
		}
		return null;
	}

	public bool RecordCompDiameter(CustomUICompType type, float newDiameter)
	{
		if (_compDatas.TryGetValue(type, out var value))
		{
			if (Model<CustomUIModel>.Interface.Scheme.Standard.GetUseDiameter(type))
			{
				value.SetDiameter(newDiameter);
			}
			Dirty = true;
			return true;
		}
		return false;
	}

	public bool RecordCompPos(CustomUICompType type, Vector2 newPos)
	{
		if (_compDatas.TryGetValue(type, out var value))
		{
			value.SetPos(newPos);
			Dirty = true;
			return true;
		}
		return false;
	}

	public bool RecordCompPosDelta(CustomUICompType type, Vector2 posDelta)
	{
		if (_compDatas.TryGetValue(type, out var value))
		{
			value.SePosDelta(posDelta);
			Dirty = true;
			return true;
		}
		return false;
	}

	public void RecordEdgeOffset(float newOffset)
	{
		EdgeOffset = newOffset;
		Dirty = true;
	}

	public void RecordName(string newName)
	{
		Name = newName;
		Dirty = true;
	}

	public void SetSavedName(string newName)
	{
		Name = newName;
	}

	private CustomUISchemeModifyWrapper GetModifyWrapper(int schemeId, string name)
	{
		List<CustomUICompModify> list = new List<CustomUICompModify>();
		foreach (var (type, modifyPanelCompData2) in _compDatas)
		{
			list.Add(new CustomUICompModify(type, modifyPanelCompData2.Pos, modifyPanelCompData2.Diameter));
		}
		return new CustomUISchemeModifyWrapper(schemeId, name, EdgeOffset, list);
	}

	private CustomUISchemeModifyWrapper GetModifyWrapper(int schemeId)
	{
		return GetModifyWrapper(schemeId, Name);
	}

	public CustomUISchemeModifyWrapper GetSelfModifyData()
	{
		Dirty = false;
		return GetModifyWrapper(Id);
	}

	public CustomUISchemeModifyWrapper GetModifyDataById(int schemeId)
	{
		Dirty = false;
		return GetModifyWrapper(schemeId);
	}

	public CustomUISchemeModifyWrapper GetModifyDataById(int schemeId, string name)
	{
		return GetModifyWrapper(schemeId, name);
	}
}
