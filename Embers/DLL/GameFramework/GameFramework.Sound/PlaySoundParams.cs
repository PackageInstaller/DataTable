namespace GameFramework.Sound;

public sealed class PlaySoundParams : IReference
{
	private bool m_Referenced;

	private float m_Time;

	private bool m_MuteInSoundGroup;

	private bool m_Loop;

	private int m_Priority;

	private float m_VolumeInSoundGroup;

	private float m_FadeInSeconds;

	private float m_Pitch;

	private float m_PanStereo;

	private float m_SpatialBlend;

	private float m_MaxDistance;

	private float m_DopplerLevel;

	public float Time
	{
		get
		{
			return m_Time;
		}
		set
		{
			m_Time = value;
		}
	}

	public bool MuteInSoundGroup
	{
		get
		{
			return m_MuteInSoundGroup;
		}
		set
		{
			m_MuteInSoundGroup = value;
		}
	}

	public bool Loop
	{
		get
		{
			return m_Loop;
		}
		set
		{
			m_Loop = value;
		}
	}

	public int Priority
	{
		get
		{
			return m_Priority;
		}
		set
		{
			m_Priority = value;
		}
	}

	public float VolumeInSoundGroup
	{
		get
		{
			return m_VolumeInSoundGroup;
		}
		set
		{
			m_VolumeInSoundGroup = value;
		}
	}

	public float FadeInSeconds
	{
		get
		{
			return m_FadeInSeconds;
		}
		set
		{
			m_FadeInSeconds = value;
		}
	}

	public float Pitch
	{
		get
		{
			return m_Pitch;
		}
		set
		{
			m_Pitch = value;
		}
	}

	public float PanStereo
	{
		get
		{
			return m_PanStereo;
		}
		set
		{
			m_PanStereo = value;
		}
	}

	public float SpatialBlend
	{
		get
		{
			return m_SpatialBlend;
		}
		set
		{
			m_SpatialBlend = value;
		}
	}

	public float MaxDistance
	{
		get
		{
			return m_MaxDistance;
		}
		set
		{
			m_MaxDistance = value;
		}
	}

	public float DopplerLevel
	{
		get
		{
			return m_DopplerLevel;
		}
		set
		{
			m_DopplerLevel = value;
		}
	}

	internal bool Referenced => m_Referenced;

	public PlaySoundParams()
	{
		m_Referenced = false;
		m_Time = 0f;
		m_MuteInSoundGroup = false;
		m_Loop = false;
		m_Priority = 0;
		m_VolumeInSoundGroup = 1f;
		m_FadeInSeconds = 0f;
		m_Pitch = 1f;
		m_PanStereo = 0f;
		m_SpatialBlend = 0f;
		m_MaxDistance = 100f;
		m_DopplerLevel = 1f;
	}

	public static PlaySoundParams Create()
	{
		PlaySoundParams playSoundParams = ReferencePool.Acquire<PlaySoundParams>();
		playSoundParams.m_Referenced = true;
		return playSoundParams;
	}

	public void Clear()
	{
		m_Time = 0f;
		m_MuteInSoundGroup = false;
		m_Loop = false;
		m_Priority = 0;
		m_VolumeInSoundGroup = 1f;
		m_FadeInSeconds = 0f;
		m_Pitch = 1f;
		m_PanStereo = 0f;
		m_SpatialBlend = 0f;
		m_MaxDistance = 100f;
		m_DopplerLevel = 1f;
	}
}
