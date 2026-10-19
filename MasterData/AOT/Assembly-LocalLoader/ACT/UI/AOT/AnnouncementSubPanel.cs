using System.Threading.Tasks;
using UnityEngine;

namespace ACT.UI.AOT;

public abstract class AnnouncementSubPanel : MonoBehaviour
{
	public abstract bool IsHCLR { get; set; }

	public abstract Task Refresh();

	public abstract Task Clear();

	public abstract void ReportOnClose();

	public abstract void ReportOnOpen();
}
