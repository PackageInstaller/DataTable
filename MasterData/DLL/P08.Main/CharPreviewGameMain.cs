using UnityEngine;

public class CharPreviewGameMain : GameMain
{
	private static Object sUICamera;

	private static string uiCameraName = "UICamera_DontDestroy";

	private ClientEv root;

	private void Awake()
	{
		if (sUICamera != null)
		{
			Object.DestroyImmediate(sUICamera);
		}
		sUICamera = Object.Instantiate(Resources.Load(uiCameraName));
		sUICamera.name = uiCameraName;
		DownloadManager.Create();
		isSplashing = true;
		root = new ClientEv(this);
		root.Link(new CharPreviewStartGame(this));
		Object.DontDestroyOnLoad(GameObject.Find("CharPreviewSetting"));
	}

	private void Start()
	{
	}

	private void Update()
	{
		root.Run();
	}
}
