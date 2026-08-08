using UnityEngine;

public class HpTips : MonoBehaviour
{
	private CustomTextMesh _customTextMesh;

	private Camera _mainCamera;

	private MeshRenderer _meshRenderer;

	public string path;

	private int _length;

	public float randomRadius;

	public float randomAngle;

	public float appearAndDisappearTime = 0.1f;

	public float time1;

	public float maxScale;

	public float time2;

	public float finalScale;

	public float minDistance;

	public float maxDistance;

	public float raiseTime;

	public float fadeTime;

	public float weakScale = 0.5f;

	public float weakAlpha = 0.5f;

	public AnimationCurve curve = new AnimationCurve();

	private Vector3 pos;

	private float _startAlpha = 1f;

	private float _distance;

	private bool _startUpdate;

	private float _runningTime;

	private bool _scaleFinished;

	private void Awake()
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		if (_customTextMesh == null)
		{
			_customTextMesh = GetComponent<CustomTextMesh>();
		}
		if (_meshRenderer == null)
		{
			_meshRenderer = GetComponent<MeshRenderer>();
		}
	}

	public void SetValue(int text)
	{
		_customTextMesh.SetText(text);
		_length = _customTextMesh.mNumbers.Count;
	}

	public void StartUpdate(Vector3 from, bool weak = false)
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		float angle = Random.Range(0f - randomAngle, randomAngle);
		float y = Random.Range(0f, randomRadius);
		Vector3 vector = new Vector3(0f, y, 0f);
		if (_mainCamera != null)
		{
			vector = Quaternion.AngleAxis(angle, _mainCamera.transform.forward) * vector;
		}
		from += vector;
		if (base.transform.parent != U3DHud.mInstance.transform)
		{
			base.transform.parent = U3DHud.mInstance.transform;
		}
		U3DHud.mInstance.SetHUDPosition(base.transform, from);
		float num = 1f;
		float startAlpha = 1f;
		if (weak)
		{
			num = weakScale;
			startAlpha = weakAlpha;
		}
		base.transform.localScale = new Vector3(num, num, num);
		base.transform.localRotation = Quaternion.identity;
		_startUpdate = true;
		_scaleFinished = false;
		_runningTime = 0f;
		_distance = Random.Range(minDistance, maxDistance);
		pos = from;
		if (_mainCamera != null && (double)_mainCamera.WorldToScreenPoint(pos).z < 0.1)
		{
			_startUpdate = false;
			DestroyOrReturn();
		}
		for (int i = 0; i < _length; i++)
		{
			_customTextMesh.mScales[i] = 0f;
		}
		_customTextMesh.Rebuild();
		_startAlpha = startAlpha;
		Color color = _meshRenderer.material.GetColor("_Color");
		color.a = _startAlpha;
		_meshRenderer.material.SetColor("_Color", color);
		Update();
	}

	private void Update()
	{
		if (!_startUpdate)
		{
			if (base.gameObject.activeSelf)
			{
				Color color = _meshRenderer.material.GetColor("_Color");
				color.a = 1f;
				_meshRenderer.material.SetColor("_Color", color);
				DestroyOrReturn();
			}
			return;
		}
		if (_mainCamera != null && (double)_mainCamera.WorldToScreenPoint(pos).z < 0.1)
		{
			_startUpdate = false;
		}
		bool flag = false;
		if (!_scaleFinished)
		{
			for (int i = 0; i < _length; i++)
			{
				if (time1 == 0f && time2 == 0f)
				{
					_customTextMesh.mScales[i] = 1f;
					flag = true;
					_scaleFinished = true;
				}
				else if (_runningTime - (float)i * appearAndDisappearTime < time1)
				{
					_customTextMesh.mScales[i] = Mathf.Lerp(0f, maxScale, (_runningTime - (float)i * appearAndDisappearTime) / time1);
					flag = true;
				}
				else if (_runningTime - (float)i * appearAndDisappearTime - time1 < time2)
				{
					_customTextMesh.mScales[i] = Mathf.Lerp(maxScale, finalScale, (_runningTime - (float)i * appearAndDisappearTime - time1) / time2);
					flag = true;
				}
				else if (_runningTime - time1 - time2 - (float)_length * appearAndDisappearTime > 0f)
				{
					_customTextMesh.mScales[i] = 1f;
					flag = true;
					_scaleFinished = true;
				}
			}
		}
		float num = _runningTime - time1 - time2 - (float)_length * appearAndDisappearTime - raiseTime;
		if (num > 0f)
		{
			Color color2 = _meshRenderer.material.GetColor("_Color");
			color2.a = Mathf.Lerp(_startAlpha, 0f, num / fadeTime);
			_meshRenderer.material.SetColor("_Color", color2);
		}
		num = _runningTime;
		float num2 = raiseTime + fadeTime + time1 + time2 + (float)_length * appearAndDisappearTime;
		if (num > 0f && num <= num2)
		{
			float t = curve.Evaluate(num / num2);
			float y = Mathf.Lerp(0f, _distance, t);
			Vector3 localPosition = U3DHud.mInstance.ConverHUDWorld(pos + new Vector3(0f, y, 0f));
			base.transform.localPosition = localPosition;
		}
		else if (num <= 0f)
		{
			Vector3 localPosition2 = U3DHud.mInstance.ConverHUDWorld(pos);
			base.transform.localPosition = localPosition2;
		}
		else if (num > num2)
		{
			_startUpdate = false;
		}
		_runningTime += Time.deltaTime;
		if (flag)
		{
			_customTextMesh.Rebuild();
		}
	}

	public void DestroyOrReturn()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene == null))
		{
			battleScene.GetWorldSatetManager()?.ReturnHpTips(this, path);
		}
	}

	private void OnDisable()
	{
	}
}
