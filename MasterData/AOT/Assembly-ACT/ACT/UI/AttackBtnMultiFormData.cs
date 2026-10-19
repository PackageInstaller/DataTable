using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.UI;

public class AttackBtnMultiFormData : AttackBtnData
{
	private List<OperateBtnStateConfigData> _formDatas;

	public AttackBtnMultiFormData(AttackBtnMultiFormConfig config, Entity belongEb)
	{
		_formDatas = new List<OperateBtnStateConfigData>();
		foreach (OperateBtnFormConfig formConfig in config._formConfigs)
		{
			_formDatas.Add(new OperateBtnStateConfigData(formConfig));
		}
		InitFormDataManager(belongEb);
	}

	protected override void InitFormDataManager(Entity entity)
	{
		_formDataManager = new OperateBtnFormDataManager(entity, _formDatas, btnType);
	}
}
