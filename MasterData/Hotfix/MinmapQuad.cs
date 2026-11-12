using UnityEngine;

public class MinmapQuad : MonoBehaviour
{
	private static readonly int MaterialPropertyID = Shader.PropertyToID("_Explored");

	private MeshRenderer meshRenderer;

	private MaterialPropertyBlock mpb;

	private void Awake()
	{
		meshRenderer = GetComponent<MeshRenderer>();
		meshRenderer.enabled = false;
		mpb = new MaterialPropertyBlock();
	}

	private void OnEnable()
	{
		meshRenderer.enabled = true;
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower)
		{
			Unexplore();
		}
	}

	public void Explore()
	{
		mpb.SetFloat(MaterialPropertyID, 1f);
		meshRenderer.SetPropertyBlock(mpb);
		meshRenderer.enabled = true;
	}

	public void Unexplore()
	{
		mpb.SetFloat(MaterialPropertyID, 0f);
		meshRenderer.SetPropertyBlock(mpb);
		meshRenderer.enabled = true;
	}
}
