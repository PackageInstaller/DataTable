using ACT.UI;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(fileName = "UIBorderConnectionSO", menuName = "ACT/Settings/Connections/Other/UIBorder")]
public class UIBorderConnectionSO : FloatConnectionSO
{
	public class Connection : BaseConnection<float>
	{
		public Connection(ConnectionSO<float> connectionSO, ISettingWithValue<float> setting)
			: base(connectionSO, setting)
		{
		}

		public override float GetDefault()
		{
			return SafeAreaBorderHelper.ReturnLegalSafeAreaDefaultValue();
		}

		public override void Init(float value)
		{
		}

		public override void Set(float value)
		{
		}
	}

	public override IConnection<float> CreateConnection(ISettingWithValue<float> owner)
	{
		return new Connection(this, owner);
	}
}
