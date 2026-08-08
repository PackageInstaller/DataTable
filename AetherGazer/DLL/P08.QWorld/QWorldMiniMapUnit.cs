using UnityEngine;

public class QWorldMiniMapUnit
{
	public int tags;

	private Transform entity_transform;

	private QWorldMap map;

	public bool m_miniDirty;

	public bool m_maxDirty;

	private Vector3 volumeSize;

	private float radius;

	private int zoneType;

	public int EntityEntityId { get; private set; }

	public int MiniMapType { get; private set; }

	public string Icon { get; private set; }

	public int IconType { get; private set; }

	public string baseIcon { get; private set; }

	public bool Select { get; private set; }

	public int MapDisplay { get; private set; }

	public bool TrackShow { get; private set; }

	public bool IsTrack
	{
		get
		{
			if (map != null)
			{
				return map.IsTrack(EntityEntityId);
			}
			return false;
		}
	}

	public bool IsTrackMini
	{
		get
		{
			if (map != null)
			{
				return map.IsTrack(EntityEntityId);
			}
			return false;
		}
	}

	public Vector3 Position
	{
		get
		{
			if (!(null == entity_transform))
			{
				return entity_transform.position;
			}
			return Vector3.zero;
		}
	}

	public Quaternion Rotation
	{
		get
		{
			if (!(null == entity_transform))
			{
				return entity_transform.rotation;
			}
			return Quaternion.identity;
		}
	}

	public Vector3 VolumeSize
	{
		get
		{
			_ = volumeSize;
			return volumeSize;
		}
	}

	public float Radius
	{
		get
		{
			if (0f == radius)
			{
				if (entity_transform.TryGetComponent<QWCapsuleDevice>(out var component))
				{
					radius = component.radius;
				}
				else
				{
					radius = 1f;
				}
			}
			return radius;
		}
	}

	public int ZoneType
	{
		get
		{
			if (zoneType == 0)
			{
				QWZoneDevice component = entity_transform.GetComponent<QWZoneDevice>();
				if (component is QWVolumeDevice)
				{
					zoneType = 1;
				}
				else if (component is QWCapsuleDevice)
				{
					zoneType = 2;
				}
			}
			return zoneType;
		}
	}

	public QWorldMiniMapUnit(QWorldMap qWorldMap, int entityId, Transform entityTransform)
	{
		map = qWorldMap;
		EntityEntityId = entityId;
		entity_transform = entityTransform;
		SetAllDirty();
	}

	public void Dispose()
	{
		EntityEntityId = 0;
		entity_transform = null;
		map = null;
	}

	public void SetAllDirty()
	{
		m_miniDirty = true;
		m_maxDirty = true;
	}

	public void SetIcon(string path, int iconType = 0, string basePath = "")
	{
		if (Icon != path || IconType != iconType)
		{
			Icon = path;
			IconType = iconType;
			baseIcon = basePath;
			SetAllDirty();
		}
	}

	public void SetSelect(bool select)
	{
		if (Select != select)
		{
			Select = select;
			SetAllDirty();
		}
	}

	public void SetMiniType(int miniType)
	{
		if (miniType != MiniMapType)
		{
			MiniMapType = miniType;
			SetAllDirty();
		}
	}

	public void SetMapDisplay(int map_display)
	{
		if (map_display != MapDisplay)
		{
			MapDisplay = map_display;
			SetAllDirty();
		}
	}

	public void SetMapTrackShow(bool trackShow)
	{
		if (trackShow != TrackShow)
		{
			TrackShow = trackShow;
			SetAllDirty();
		}
	}

	public bool GetMiniMapDisplay()
	{
		if (2 == MapDisplay || 3 == MapDisplay || (TrackShow && IsTrack))
		{
			return true;
		}
		return false;
	}

	public bool GetMaxMapDisplay()
	{
		if (1 == MapDisplay || 3 == MapDisplay || (TrackShow && IsTrack))
		{
			return true;
		}
		return false;
	}
}
