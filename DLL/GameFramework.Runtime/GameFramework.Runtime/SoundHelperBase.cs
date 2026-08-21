using GameFramework.Sound;
using UnityEngine;

namespace GameFramework.Runtime;

public abstract class SoundHelperBase : MonoBehaviour, ISoundHelper
{
	public abstract void ReleaseSoundAsset(string soundAsset);
}
