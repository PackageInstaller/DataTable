using MagicaCloth2;

namespace ACT.Battle;

public class MonoMagicaCloth : LuminSerializedMonoBehaviour
{
	public MagicaCloth[] magicaCloths;

	public void Control(bool enable)
	{
		MagicaCloth[] array = magicaCloths;
		foreach (MagicaCloth magicaCloth in array)
		{
			if (magicaCloth != null)
			{
				magicaCloth.enabled = enable;
			}
		}
	}
}
