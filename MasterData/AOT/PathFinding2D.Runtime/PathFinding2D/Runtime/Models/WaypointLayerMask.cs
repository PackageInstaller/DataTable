namespace PathFinding2D.Runtime.Models;

public struct WaypointLayerMask
{
	public int LayerMask { get; private set; }

	public static WaypointLayerMask All => new WaypointLayerMask
	{
		LayerMask = int.MaxValue
	};

	public static WaypointLayerMask None => new WaypointLayerMask
	{
		LayerMask = 0
	};

	public static implicit operator int(WaypointLayerMask mask)
	{
		return mask.LayerMask;
	}

	public static implicit operator WaypointLayerMask(int intVal)
	{
		return new WaypointLayerMask
		{
			LayerMask = intVal
		};
	}

	public static implicit operator WaypointLayer(WaypointLayerMask mask)
	{
		return (WaypointLayer)mask.LayerMask;
	}

	public static implicit operator WaypointLayerMask(WaypointLayer layer)
	{
		return new WaypointLayerMask
		{
			LayerMask = (int)layer
		};
	}

	public bool HasLayer(WaypointLayer layer)
	{
		return ((WaypointLayer)LayerMask).HasFlag(layer);
	}

	public static int NameToLayerIndex(string layerName)
	{
		return NavigationRuntime.Instance.Profile.NameToLayer(layerName);
	}

	public static WaypointLayerMask NameToLayerMask(string layerName)
	{
		return 1 << NameToLayerIndex(layerName);
	}

	public static WaypointLayerMask IndexToLayerMask(int layerIndex)
	{
		return 1 << layerIndex;
	}

	public void AddLayer(int layerIndex)
	{
		LayerMask |= 1 << layerIndex;
	}

	public void AddLayer(string layerName)
	{
		LayerMask |= 1 << NameToLayerIndex(layerName);
	}

	public void RemoveLayer(int layerIndex)
	{
		LayerMask &= ~(1 << layerIndex);
	}

	public void RemoveLayer(string layerName)
	{
		RemoveLayer(NameToLayerIndex(layerName));
	}
}
