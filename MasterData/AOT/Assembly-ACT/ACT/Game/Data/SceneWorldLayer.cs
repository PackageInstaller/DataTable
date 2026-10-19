using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum SceneWorldLayer
{
	[OriginalName("SCENE_WORLD_LAYER_SURFACE")]
	Surface,
	[OriginalName("SCENE_WORLD_LAYER_INNER")]
	Inner
}
