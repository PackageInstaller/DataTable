#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class WeaponBuff : PropertyBuff
{
	protected override void OnExecute()
	{
		if (!(base.buffOwner is HeroEntity heroEntity) || heroEntity.BattleHeroData.WeaponEnum == WeaponEnum.None)
		{
			return;
		}
		if (dataBase.changeType == ChangeType.Set)
		{
			if (dataBase.propertyType == PropertyType.Cur)
			{
				heroEntity.BattleHeroData.WeaponMechanismBase.SetLayer((int)dataBase.propertyValue);
			}
			else
			{
				Log.Error($"属性Buff 设置属性类型 ({dataBase.propertyType}) 无效！");
			}
		}
		else if (dataBase.changeType == ChangeType.Add || dataBase.changeType == ChangeType.Dec)
		{
			float num = ((dataBase.changeType == ChangeType.Add) ? dataBase.propertyValue : (0f - dataBase.propertyValue));
			if (dataBase.propertyType == PropertyType.Cur)
			{
				heroEntity.BattleHeroData.WeaponMechanismBase.AddLayer((int)num);
			}
			else
			{
				Log.Error($"属性Buff 设置属性类型 ({dataBase.propertyType}) 无效！");
			}
		}
	}
}
