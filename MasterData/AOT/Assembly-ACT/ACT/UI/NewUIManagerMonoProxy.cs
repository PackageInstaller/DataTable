using ACT.LocalLoader;
using UnityEngine;
using UnityEngine.InputSystem.UI;
using UnityEngine.UI;

namespace ACT.UI;

public class NewUIManagerMonoProxy : MonoBehaviour
{
	public InputSystemUIInputModule inputModule;

	public Transform panelRoot;

	public Transform popRoot;

	public Transform toastRoot;

	public Transform tipRoot;

	public RectTransform uiEffectRoot;

	public BlurUIEffect uiBlurEffect = new BlurUIEffect
	{
		BlurRadius = 1.5f
	};

	public Image newUIManagerBlackScreen;

	public FrameworkBlackScreen blackScreen;

	public FrameworkBlackLoad blackLoad;

	public FrameworkBlackFade blackFade;

	public MonoMessageBox messageBox;

	public MonoUIDtxt uidTxt;

	public MonoLoaderView loadingPanel;

	public GameObject payPendingPanel;

	public GuideComp guideComp;

	public CharacterFullScreenAni characterFullScreenAni;

	public GameObject rayCastBlocker;

	public DisconnectionPanel disconnectionPanel;

	public MonoNetworkFluctuationView monoNetworkFluctuation;
}
