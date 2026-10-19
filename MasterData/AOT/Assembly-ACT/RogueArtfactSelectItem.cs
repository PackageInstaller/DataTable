using ACT.Config;
using ACT.Core;
using ACT.Model;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class RogueArtfactSelectItem : MonoBehaviour
{
	public LocalizeStringEvent TextArtfactName;

	public LocalizeStringEvent TextArtfactDes;

	public GameObject GoSelect;

	public Button BtnClick;

	public RogueArtifactCard RogueArtifact;

	private void Start()
	{
	}

	public void Init(RogueArtifactCard Artifact)
	{
		RogueArtifact = Artifact;
		RogueArtifact data = CoreUtils.GetData(Artifact.id, RuntimeConfigs.data.rogueArtifacts);
		GoSelect.SetActive(value: false);
		TextArtfactDes.StringReference.TableEntryReference = data.effectDesc;
		TextArtfactName.StringReference.TableEntryReference = data.artifactName;
	}

	private void Update()
	{
	}
}
