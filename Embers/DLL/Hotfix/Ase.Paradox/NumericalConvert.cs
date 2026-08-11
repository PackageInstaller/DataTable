using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("数据类型转换", 0)]
[Category("✫ Utility")]
[Description("数值转换。")]
public class NumericalConvert : ActionTaskBase
{
	[Name("原数值类型", 0)]
	public NumericalConvertEnum originEnum;

	[Name("转换类型", 0)]
	public NumericalConvertEnum convertEnum;

	[ShowIf("originEnum", 0)]
	[Name("原Int数值", 0)]
	public BBParameter<int> originInt;

	[ShowIf("originEnum", 1)]
	[Name("原Float数值", 0)]
	public BBParameter<float> originFloat;

	[ShowIf("convertEnum", 0)]
	[Name("转换的Int数值", 0)]
	public BBParameter<int> convertInt;

	[ShowIf("convertEnum", 1)]
	[Name("转换的Float数值", 0)]
	public BBParameter<float> convertFloat;

	[ShowIf("convertEnum", 0)]
	[Name("是否向上取整", 0)]
	public bool isCeil;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (originEnum == NumericalConvertEnum.Int)
		{
			if (convertEnum == NumericalConvertEnum.Int)
			{
				convertInt.value = originInt.value;
			}
			else if (convertEnum == NumericalConvertEnum.Float)
			{
				convertFloat.value = originInt.value;
			}
		}
		else if (originEnum == NumericalConvertEnum.Float)
		{
			if (convertEnum == NumericalConvertEnum.Int)
			{
				convertInt.value = ((!isCeil) ? ((int)originFloat.value) : Mathf.CeilToInt(originFloat.value));
			}
			else if (convertEnum == NumericalConvertEnum.Float)
			{
				convertFloat.value = originFloat.value;
			}
		}
		EndAction();
	}
}
