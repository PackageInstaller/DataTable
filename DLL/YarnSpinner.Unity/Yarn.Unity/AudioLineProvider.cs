using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

namespace Yarn.Unity;

public class AudioLineProvider : LineProviderBehaviour
{
	private interface IAssetLineProvider
	{
		bool LinesAvailable { get; }

		AudioLineProvider audioLineProvider { get; set; }

		LocalizedLine GetLocalizedLine(Line line);

		void PrepareForLines(IEnumerable<string> lineIDs);
	}

	private class NullProvider : IAssetLineProvider
	{
		public bool LinesAvailable => false;

		public AudioLineProvider audioLineProvider { get; set; }

		public LocalizedLine GetLocalizedLine(Line line)
		{
			//IL_0005: Unknown result type (might be due to invalid IL or missing references)
			Debug.LogWarning("asked for line " + line.ID + " but this provider has no project.");
			return null;
		}

		public void PrepareForLines(IEnumerable<string> lineIDs)
		{
		}
	}

	private class DirectReferenceAudioLineProvider : IAssetLineProvider
	{
		public AudioLineProvider audioLineProvider { get; set; }

		public bool LinesAvailable => true;

		public LocalizedLine GetLocalizedLine(Line line)
		{
			//IL_005a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0083: Unknown result type (might be due to invalid IL or missing references)
			//IL_0096: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
			//IL_0071: Unknown result type (might be due to invalid IL or missing references)
			Localization localization = audioLineProvider.YarnProject.GetLocalization(audioLineProvider.audioLanguageCode);
			Localization localization2 = ((!(audioLineProvider.audioLanguageCode != audioLineProvider.textLanguageCode)) ? localization : audioLineProvider.YarnProject.GetLocalization(audioLineProvider.textLanguageCode));
			string localizedString = localization2.GetLocalizedString(line.ID);
			AudioClip asset = null;
			if (localization.ContainsLocalizedAssets)
			{
				asset = localization.GetLocalizedObject<AudioClip>(line.ID);
			}
			return new LocalizedLine
			{
				TextID = line.ID,
				RawText = localizedString,
				Substitutions = line.Substitutions,
				Metadata = audioLineProvider.YarnProject.lineMetadata.GetMetadata(line.ID),
				Asset = (Object)(object)asset
			};
		}

		public void PrepareForLines(IEnumerable<string> lineIDs)
		{
		}
	}

	[Language]
	public string textLanguageCode = CultureInfo.CurrentCulture.Name;

	[Language]
	public string audioLanguageCode = CultureInfo.CurrentCulture.Name;

	private IAssetLineProvider _provider;

	public override string LocaleCode => textLanguageCode;

	private IAssetLineProvider provider
	{
		get
		{
			if (_provider == null)
			{
				_provider = configureProvider();
			}
			else if (_provider is NullProvider && base.YarnProject != null)
			{
				_provider = configureProvider();
			}
			return _provider;
			IAssetLineProvider configureProvider()
			{
				IAssetLineProvider assetLineProvider;
				if (base.YarnProject != null)
				{
					if (base.YarnProject.GetLocalization(audioLanguageCode).UsesAddressableAssets)
					{
						Debug.LogError("The Yarn project " + base.YarnProject.name + " is configured to use Addressable assets, but the package is not installed. Double check your package settings. Falling back to providing non-Addressable audio loading");
						assetLineProvider = new DirectReferenceAudioLineProvider();
					}
					else
					{
						assetLineProvider = new DirectReferenceAudioLineProvider();
					}
				}
				else
				{
					Debug.LogError("The AudioLineProvider is attempting to configure itself but the project isn't defined.");
					assetLineProvider = new NullProvider();
				}
				assetLineProvider.audioLineProvider = this;
				return assetLineProvider;
			}
		}
	}

	public override bool LinesAvailable => provider.LinesAvailable;

	public override LocalizedLine GetLocalizedLine(Line line)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return provider.GetLocalizedLine(line);
	}

	public override void PrepareForLines(IEnumerable<string> lineIDs)
	{
		provider.PrepareForLines(lineIDs);
	}
}
