using UnityEngine;

namespace ACT.UI;

public interface ITextAnimatorEffectHandler
{
	Vector3 GetOffset(in TextAnimatorEffectRange range, int charIndex, float time);
}
