using UnityEngine;
using UnityEngine.Playables;

public class PlayableDirectorConfig
{
	public Vector3? position;

	public Quaternion? rotation;

	public Vector3? scale;

	public DirectorUpdateMode updateMode;

	public CustomModelMaterialVariantComponent.VariantNames variantNames;

	public PlayableDirectorConfig()
	{
		updateMode = DirectorUpdateMode.UnscaledGameTime;
		variantNames = CustomModelMaterialVariantComponent.VariantNames.None;
	}
}
