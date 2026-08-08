using UnityEngine;

public class SourceSpaceEnterEffectRaceLogoController : MonoBehaviour
{
	public Renderer m_Render;

	private bool Changed;

	public void SetRaceLogo(int pRaceIndex)
	{
		if (!Changed)
		{
			switch (pRaceIndex)
			{
			case 1:
				m_Render.sharedMaterial.SetTextureOffset("_Tex", new Vector2(0.333f, 0.5f));
				break;
			case 2:
				m_Render.sharedMaterial.SetTextureOffset("_Tex", new Vector2(0.666f, 0.5f));
				break;
			case 3:
				m_Render.sharedMaterial.SetTextureOffset("_Tex", new Vector2(0f, 0f));
				break;
			case 4:
				m_Render.sharedMaterial.SetTextureOffset("_Tex", new Vector2(0.333f, 0f));
				break;
			case 5:
				m_Render.sharedMaterial.SetTextureOffset("_Tex", new Vector2(0.666f, 0f));
				break;
			default:
				m_Render.sharedMaterial.SetTextureOffset("_Tex", new Vector2(0f, 0.5f));
				break;
			}
			Changed = true;
		}
	}
}
