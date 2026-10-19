using TMPro;
using UnityEngine;
using UnityEngine.Profiling;

public class MonoMemoryUsage : MonoBehaviour
{
	public TextMeshProUGUI MOnoMemorymaxMB;

	public TextMeshProUGUI MemorymaxMB;

	public TextMeshProUGUI MOnoMemorycurrentMB;

	public TextMeshProUGUI MemorycurrentMB;

	public TextMeshProUGUI GraphicsMB;

	public Canvas fullMonitor;

	public long MonoMemoryMax => Profiler.GetMonoHeapSizeLong();

	public long MonoMemorycurrent => Profiler.GetMonoUsedSizeLong();

	public long MemoryMax => Profiler.GetTotalReservedMemoryLong();

	public long Memorycurrent => Profiler.GetTotalAllocatedMemoryLong();

	public long Graphicsmb => Profiler.GetAllocatedMemoryForGraphicsDriver();

	private void OnEnable()
	{
		Valueupdate();
	}

	private void Update()
	{
		Valueupdate();
	}

	public void Valueupdate()
	{
		long num = MonoMemoryMax >> 20;
		long num2 = MonoMemorycurrent >> 20;
		long num3 = MemoryMax >> 20;
		long num4 = Memorycurrent >> 20;
		long num5 = Graphicsmb >> 20;
		if (fullMonitor.enabled)
		{
			MOnoMemorymaxMB.text = num.ToString();
			MOnoMemorycurrentMB.text = num2.ToString();
			MemorymaxMB.text = num3.ToString();
			MemorycurrentMB.text = num4.ToString();
			GraphicsMB.text = num5.ToString();
		}
	}
}
