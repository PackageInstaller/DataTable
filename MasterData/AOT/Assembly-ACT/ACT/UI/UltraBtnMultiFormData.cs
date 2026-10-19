using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.UI;

public class UltraBtnMultiFormData : UltraBtnData
{
	private List<OperateBtnStateConfigData> _formDatas;

	public UltraBtnMultiFormData(UltraBtnMultiFormConfig config, Entity entity)
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
