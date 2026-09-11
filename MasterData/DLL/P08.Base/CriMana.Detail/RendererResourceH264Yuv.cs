using UnityEngine;

namespace CriMana.Detail;

public class RendererResourceH264Yuv : RendererResourceSofdecPrimeYuvRawData
{
	public RendererResourceH264Yuv(int playerId, MovieInfo movieInfo, bool additive, Shader userShader)
		: base(playerId, movieInfo, additive, userShader)
	{
	}
}
