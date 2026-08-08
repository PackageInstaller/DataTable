using UnityEngine;

public struct HoverEffectContext
{
	public bool isMobile;

	public int enterTween;

	public int exitTween;

	public int clickTween;

	public float originScale;

	public Animator animator;

	public HoverAnimStateFlag animState;

	public HoverPointerState pointerState;

	public bool firstEnableDirty;
}
