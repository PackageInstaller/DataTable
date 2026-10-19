using System;
using ACT.Config;
using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class RogueChooseArtifactCell : MonoBehaviour
{
	public GameObject GoSelect;

	public GameObject GoSelected;

	public BImage ImageArtifactIcon;

	public GameObject GoUnDiscovered;

	public LocalizeStringEvent TextDes;

	public LocalizeStringEvent TextName;

	public Action FunClick;

	public int ArtifactId;

	private bool _isSelect;

	public bool isSelect
	{
		get
		{
			return _isSelect;
		}
		set
		{
			_isSelect = value;
			GoSelected.SetActive(value);
		}
	}

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void OnClick()
	{
		FunClick?.Invoke();
	}

	public void Init(RogueArtifact data)
	{
		ArtifactId = data.id;
		isSelect = Model<RoGueModel>.Interface._RogueTableArtifacts.Contains(ArtifactId);
		TextDes.StringReference.TableEntryReference = data.effectDesc;
		TextName.StringReference.TableEntryReference = data.artifactName;
	}
}
