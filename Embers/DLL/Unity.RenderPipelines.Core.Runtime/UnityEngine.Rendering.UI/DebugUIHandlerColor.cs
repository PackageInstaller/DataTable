using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerColor : DebugUIHandlerWidget
{
	public Text nameLabel;

	public UIFoldout valueToggle;

	public Image colorImage;

	public DebugUIHandlerIndirectFloatField fieldR;

	public DebugUIHandlerIndirectFloatField fieldG;

	public DebugUIHandlerIndirectFloatField fieldB;

	public DebugUIHandlerIndirectFloatField fieldA;

	private DebugUI.ColorField m_Field;

	private DebugUIHandlerContainer m_Container;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.ColorField>();
		m_Container = GetComponent<DebugUIHandlerContainer>();
		nameLabel.text = m_Field.displayName;
		fieldR.getter = () => m_Field.GetValue().r;
		fieldR.setter = delegate(float x)
		{
			SetValue(x, r: true);
		};
		fieldR.nextUIHandler = fieldG;
		SetupSettings(fieldR);
		fieldG.getter = () => m_Field.GetValue().g;
		fieldG.setter = delegate(float x)
		{
			SetValue(x, r: false, g: true);
		};
		fieldG.previousUIHandler = fieldR;
		fieldG.nextUIHandler = fieldB;
		SetupSettings(fieldG);
		fieldB.getter = () => m_Field.GetValue().b;
		fieldB.setter = delegate(float x)
		{
			SetValue(x, r: false, g: false, b: true);
		};
		fieldB.previousUIHandler = fieldG;
		fieldB.nextUIHandler = (m_Field.showAlpha ? fieldA : null);
		SetupSettings(fieldB);
		fieldA.gameObject.SetActive(m_Field.showAlpha);
		fieldA.getter = () => m_Field.GetValue().a;
		fieldA.setter = delegate(float x)
		{
			SetValue(x, r: false, g: false, b: false, a: true);
		};
		fieldA.previousUIHandler = fieldB;
		SetupSettings(fieldA);
		UpdateColor();
	}

	private void SetValue(float x, bool r = false, bool g = false, bool b = false, bool a = false)
	{
		Color value = m_Field.GetValue();
		if (r)
		{
			value.r = x;
		}
		if (g)
		{
			value.g = x;
		}
		if (b)
		{
			value.b = x;
		}
		if (a)
		{
			value.a = x;
		}
		m_Field.SetValue(value);
		UpdateColor();
	}

	private void SetupSettings(DebugUIHandlerIndirectFloatField field)
	{
		field.parentUIHandler = this;
		field.incStepGetter = () => m_Field.incStep;
		field.incStepMultGetter = () => m_Field.incStepMult;
		field.decimalsGetter = () => m_Field.decimals;
		field.Init();
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		if (fromNext || !valueToggle.isOn)
		{
			nameLabel.color = colorSelected;
		}
		else if (valueToggle.isOn)
		{
			if (m_Container.IsDirectChild(previous))
			{
				nameLabel.color = colorSelected;
			}
			else
			{
				DebugUIHandlerWidget lastItem = m_Container.GetLastItem();
				DebugManager.instance.ChangeSelection(lastItem, fromNext: false);
			}
		}
		return true;
	}

	public override void OnDeselection()
	{
		nameLabel.color = colorDefault;
	}

	public override void OnIncrement(bool fast)
	{
		valueToggle.isOn = true;
	}

	public override void OnDecrement(bool fast)
	{
		valueToggle.isOn = false;
	}

	public override void OnAction()
	{
		valueToggle.isOn = !valueToggle.isOn;
	}

	internal void UpdateColor()
	{
		if (colorImage != null)
		{
			colorImage.color = m_Field.GetValue();
		}
	}

	public override DebugUIHandlerWidget Next()
	{
		if (!valueToggle.isOn || m_Container == null)
		{
			return base.Next();
		}
		DebugUIHandlerWidget firstItem = m_Container.GetFirstItem();
		if (firstItem == null)
		{
			return base.Next();
		}
		return firstItem;
	}
}
