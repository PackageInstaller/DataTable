namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnAudioFilterReadHandler
{
	UniTask<(float[] data, int channels)> OnAudioFilterReadAsync();
}
