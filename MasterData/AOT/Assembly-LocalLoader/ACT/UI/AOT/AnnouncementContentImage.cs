using System;
using System.Threading;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI.AOT;

public class AnnouncementContentImage : MonoBehaviour
{
	[SerializeField]
	private RectTransform container;

	[SerializeField]
	private RawImage image;

	[SerializeField]
	private LayoutElement element;

	private void Start()
	{
		image.color = new Color(1f, 1f, 1f, 1f);
	}

	public async void Set(float width, AnnouncementTextSegment imageSegment, CancellationTokenSource cancellationTokenSource)
	{
		CancellationToken cancellationToken = cancellationTokenSource.Token;
		byte[] array = await AnnouncementCache.CacheImage(imageSegment.Url, cancellationToken);
		if (!cancellationToken.IsCancellationRequested && (bool)this)
		{
			float minWidth;
			if (array == null)
			{
				LayoutElement layoutElement = element;
				minWidth = (element.preferredHeight = 0f);
				layoutElement.minWidth = minWidth;
				LayoutElement layoutElement2 = element;
				minWidth = (element.preferredHeight = 0f);
				layoutElement2.minHeight = minWidth;
				return;
			}
			float num3 = width / (float)imageSegment.Width * (float)imageSegment.Height;
			LayoutElement layoutElement3 = element;
			minWidth = (element.preferredHeight = width);
			layoutElement3.minWidth = minWidth;
			LayoutElement layoutElement4 = element;
			minWidth = (element.preferredHeight = num3);
			layoutElement4.minHeight = minWidth;
			Texture2D texture2D = new Texture2D((int)Math.Floor(width), (int)Math.Floor(num3), TextureFormat.RGBA32, mipChain: false)
			{
				wrapMode = TextureWrapMode.Clamp
			};
			texture2D.LoadImage(array);
			container.sizeDelta = new Vector2(width, num3);
			image.texture = texture2D;
			image.gameObject.SetActive(value: true);
			Canvas.ForceUpdateCanvases();
		}
	}
}
