using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TeamAttributeViewModel : OptionBase
{
	public class AttributeData : ViewModelBase
	{
		private string iconPath;

		private bool attributeActive;

		private Color color;

		private int enumIndex;

		private InteractionRequest refreshEffectRequest = new InteractionRequest();

		public string IconPath
		{
			get
			{
				return iconPath;
			}
			set
			{
				Set(ref iconPath, value, "IconPath");
			}
		}

		public int EnumIndex
		{
			get
			{
				return enumIndex;
			}
			set
			{
				Set(ref enumIndex, value, "EnumIndex");
			}
		}

		public bool AttributeActive
		{
			get
			{
				return attributeActive;
			}
			set
			{
				Set(ref attributeActive, value, "AttributeActive");
			}
		}

		public Color Color
		{
			get
			{
				return color;
			}
			set
			{
				Set(ref color, value, "Color");
			}
		}

		public InteractionRequest RefreshEffectRequest => refreshEffectRequest;

		public AttributeData()
		{
			IconPath = "hero_attr_Empty";
			AttributeActive = false;
			EnumIndex = 0;
			Color = new Color(1f, 1f, 1f, 1f);
		}

		public AttributeData(HeroAttributeEnum attributeEnum, bool active)
		{
			RefreshData(attributeEnum, active);
		}

		public void RefreshData(HeroAttributeEnum attributeEnum, bool active)
		{
			AttributeActive = active;
			IconPath = (attributeEnum.Equals(HeroAttributeEnum.Normal) ? "hero_attr_Empty" : $"hero_attr_{(int)attributeEnum}");
			EnumIndex = (int)attributeEnum;
			Color = ((AttributeActive && !attributeEnum.Equals(HeroAttributeEnum.Normal)) ? new Color(1f, 1f, 1f, 1f) : new Color(1f, 1f, 1f, 0.5f));
			refreshEffectRequest.Raise();
		}

		public void RefreshData(AttributeData attributeData)
		{
			AttributeActive = attributeData.AttributeActive;
			IconPath = attributeData.IconPath;
			Color = attributeData.Color;
			EnumIndex = attributeData.EnumIndex;
			refreshEffectRequest.Raise();
		}
	}

	private SimpleCommand openDetailCmd;

	private List<HeroAttributeEnum> attributeEnums = new List<HeroAttributeEnum>();

	private ObservableList<AttributeData> _attributeDatas = new ObservableList<AttributeData>();

	private List<HeroModel> heroModelList;

	public SimpleCommand OpenDetailCmd => openDetailCmd;

	public ObservableList<AttributeData> AttributeDatas => _attributeDatas;

	public TeamAttributeViewModel()
	{
		Init();
	}

	public TeamAttributeViewModel(OptionBase parent)
	{
		base.parent = parent;
		Init();
	}

	private void Init()
	{
		openDetailCmd = new SimpleCommand(OpenTeamAttributeInfoWindow);
		for (int i = 0; i < 3; i++)
		{
			_attributeDatas.Add(new AttributeData());
		}
	}

	public void RefreshData(List<HeroModel> heroModelList)
	{
		attributeEnums = new List<HeroAttributeEnum>();
		this.heroModelList = heroModelList;
		List<int> list = new List<int>();
		foreach (HeroModel heroModel in heroModelList)
		{
			if (heroModel != null && list.Find((int p) => p.Equals(heroModel.Id)) == 0)
			{
				list.Add(heroModel.Id);
				attributeEnums.Add(heroModel.Attribute);
			}
		}
		List<AttributeData> list2 = new List<AttributeData>();
		int i;
		for (i = 0; i < _attributeDatas.Count; i++)
		{
			list2.Add((attributeEnums.Count > i) ? new AttributeData(attributeEnums[i], attributeEnums.FindAll((HeroAttributeEnum p) => p.Equals(attributeEnums[i])).Count > 1) : new AttributeData());
		}
		list2.Sort((AttributeData x, AttributeData y) => y.AttributeActive.CompareTo(x.AttributeActive));
		for (int num = 0; num < _attributeDatas.Count; num++)
		{
			_attributeDatas[num].RefreshData(list2[num]);
		}
	}

	public void OpenTeamAttributeInfoWindow()
	{
		openDetailCmd.Enabled = false;
		parent?.ItemOnClick(new OpenViewArg(typeof(AttributeBindingWindow), new AttributeBindingViewModel(parent, heroModelList), "TeamAttribute", isOpenWindow: true, "DEFAULT", delegate
		{
			openDetailCmd.Enabled = true;
		}));
	}
}
