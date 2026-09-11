using System.Collections;

namespace Capture.Runtime;

public abstract class GameModeLoaderBase
{
	public abstract IEnumerator Load();

	public abstract IEnumerator Release();
}
