using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.UI;

public class SpAttackBtnMultiFormData : SpAttackBtnData
{
	private List<OperateBtnStateConfigData> _formDatas;

	public SpAttackBtnMultiFormData(SpAttackBtnMultiFormConfig config, Entity entity)
	{
		_formDatas = new List<OperateBtnStateConfigData>();
		foreach (OperateBtnFormConfig formConfig in config._formConfigs)
		{
			_formDatas.Add(new OperateBtnStateConfigData(formConfig));
		}
		InitFormDataManager(entity);
	}

	protected override void InitFormDataManager(Entity entity)
	{
		_formDataManager = new OperateBtnFormDataManager(entity, _formDatas, btnType);
	}
}
