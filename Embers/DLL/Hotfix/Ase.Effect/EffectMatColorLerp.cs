using UnityEngine;

namespace Ase.Effect;

public class EffectMatColorLerp : EffectMatLerp
{
	private Color _materialInsColor;

	private static readonly int BaseColorID = Shader.PropertyToID("_BaseColor");

	public override void StartMatLerp(bool isRevert)
	{
		base.StartMatLerp(isRevert);
		_materialInsColor = _startMat.GetColor(BaseColorID);
		_materialIns.SetColor(BaseColorID, _materialInsColor);
	}

	public override void EndMatLerp()
	{
		if (_startLerpMat)
		{
			_timer = Duration;
			_startLerpMat = false;
			_materialInsColor = _toMat.GetColor(BaseColorID);
			_materialIns.SetColor(BaseColorID, _materialInsColor);
		}
	}

	protected override void Update()
	{
		if (_startLerpMat)
		{
			_timer += Time.deltaTime;
			_materialInsColor = Color.Lerp(_startMat.GetColor(BaseColorID), _toMat.GetColor(BaseColorID), Mathf.Clamp(_timer / Duration, 0f, 1f));
			_materialIns.SetColor(BaseColorID, _materialInsColor);
			if (_timer >= Duration)
			{
				EndMatLerp();
			}
		}
	}
}
