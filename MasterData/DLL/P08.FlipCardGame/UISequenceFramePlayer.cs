using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
public class UISequenceFramePlayer : MonoBehaviour
{
	[SerializeField]
	[Tooltip("序列帧图片数组")]
	private Sprite[] _frames;

	[SerializeField]
	[Tooltip("帧率 (帧/秒)")]
	private float _frameRate = 30f;

	[SerializeField]
	[Tooltip("每张图片持续帧数")]
	private int _frameDuration = 3;

	[SerializeField]
	[Tooltip("循环时末尾回到首帧的间隔(帧数)")]
	private int _loopGapFrames;

	[SerializeField]
	[Tooltip("是否循环播放")]
	private bool _loop = true;

	[SerializeField]
	[Tooltip("启动时自动播放")]
	private bool _playOnAwake = true;

	private Image _image;

	private int _currentFrameIndex;

	private float _timer;

	private bool _isPlaying;

	private int _currentDurationCount;

	private bool _isWaitingLoopGap;

	private int _loopGapCount;

	private float _cachedFrameInterval;

	public Sprite[] Frames
	{
		get
		{
			return _frames;
		}
		set
		{
			_frames = value;
		}
	}

	public float FrameRate
	{
		get
		{
			return _frameRate;
		}
		set
		{
			_frameRate = Mathf.Max(0.1f, value);
			_cachedFrameInterval = 1f / _frameRate;
		}
	}

	public bool Loop
	{
		get
		{
			return _loop;
		}
		set
		{
			_loop = value;
		}
	}

	public int DefaultFrameDuration
	{
		get
		{
			return _frameDuration;
		}
		set
		{
			_frameDuration = Mathf.Max(1, value);
		}
	}

	public int LoopGapFrames
	{
		get
		{
			return _loopGapFrames;
		}
		set
		{
			_loopGapFrames = Mathf.Max(0, value);
		}
	}

	public bool IsPlaying => _isPlaying;

	public bool IsWaitingLoopGap => _isWaitingLoopGap;

	public int CurrentFrameIndex => _currentFrameIndex;

	public int FrameCount
	{
		get
		{
			Sprite[] frames = _frames;
			if (frames == null)
			{
				return 0;
			}
			return frames.Length;
		}
	}

	public int TotalFrameCount => ((_frames != null) ? _frames.Length : 0) * Mathf.Max(1, _frameDuration);

	public float FrameInterval => _cachedFrameInterval;

	private void Awake()
	{
		_image = GetComponent<Image>();
		_cachedFrameInterval = 1f / _frameRate;
	}

	private void OnEnable()
	{
		if (_playOnAwake && Application.isPlaying)
		{
			Play();
		}
	}

	private void OnDisable()
	{
		Stop();
	}

	private void Update()
	{
		if (Application.isPlaying)
		{
			AdvanceTime(Time.deltaTime);
		}
	}

	public void AdvanceTime(float deltaTime)
	{
		if (!_isPlaying || _frames == null || _frames.Length == 0)
		{
			return;
		}
		if (_isWaitingLoopGap)
		{
			_timer += deltaTime;
			if (_timer >= FrameInterval)
			{
				_timer -= FrameInterval;
				_loopGapCount++;
				if (_loopGapCount >= _loopGapFrames)
				{
					_isWaitingLoopGap = false;
					_loopGapCount = 0;
					_currentFrameIndex = 0;
					_currentDurationCount = 0;
					_timer = 0f;
					ApplyFrame();
				}
			}
			return;
		}
		_timer += deltaTime;
		if (_timer >= FrameInterval)
		{
			_timer -= FrameInterval;
			_currentDurationCount++;
			if (_currentDurationCount >= _frameDuration)
			{
				NextFrame();
			}
		}
	}

	private void NextFrame()
	{
		_currentFrameIndex++;
		_currentDurationCount = 0;
		if (_currentFrameIndex >= _frames.Length)
		{
			if (!_loop)
			{
				_currentFrameIndex = _frames.Length - 1;
				_isPlaying = false;
				return;
			}
			if (_loopGapFrames > 0)
			{
				_currentFrameIndex = _frames.Length - 1;
				_isWaitingLoopGap = true;
				_loopGapCount = 0;
				return;
			}
			_currentFrameIndex = 0;
		}
		ApplyFrame();
	}

	private void ApplyFrame()
	{
		if (_image == null)
		{
			_image = GetComponent<Image>();
		}
		if (_image != null && _frames != null && _currentFrameIndex < _frames.Length)
		{
			_image.sprite = _frames[_currentFrameIndex];
		}
	}

	public void Play()
	{
		if (_frames != null && _frames.Length != 0)
		{
			if (_image == null)
			{
				_image = GetComponent<Image>();
			}
			_isPlaying = true;
			_timer = 0f;
			_currentFrameIndex = 0;
			_currentDurationCount = 0;
			_isWaitingLoopGap = false;
			_loopGapCount = 0;
			_cachedFrameInterval = 1f / _frameRate;
			ApplyFrame();
		}
	}

	public void Stop()
	{
		_isPlaying = false;
		_timer = 0f;
		_isWaitingLoopGap = false;
		_loopGapCount = 0;
	}

	public void Pause()
	{
		_isPlaying = false;
	}

	public void Resume()
	{
		if (_frames != null && _frames.Length != 0)
		{
			_isPlaying = true;
		}
	}

	public void SetFrame(int frameIndex)
	{
		if (_frames != null && _frames.Length != 0)
		{
			_currentFrameIndex = Mathf.Clamp(frameIndex, 0, _frames.Length - 1);
			_currentDurationCount = 0;
			ApplyFrame();
		}
	}
}
