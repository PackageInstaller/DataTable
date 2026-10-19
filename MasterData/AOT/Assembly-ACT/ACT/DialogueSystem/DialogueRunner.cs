using UnityEngine;

namespace ACT.DialogueSystem;

public class DialogueRunner : MonoBehaviour
{
	static DialogueRunner()
	{
		DialogueRegistry.RegisterProcessorFactory<IfSelector>(new NodeFactory<IfSelectorProcessor>());
		DialogueRegistry.RegisterProcessorFactory<IfNode>(new NodeFactory<IfNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<LuminDialogueRoot>(new NodeFactory<LuminDialogueRootProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ChatNode>(new NodeFactory<ChatNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ChatOptionNode>(new NodeFactory<ChatOptionNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<Timeline>(new NodeFactory<TimelineProcessor>());
		DialogueRegistry.RegisterProcessorFactory<XNodeConversation>(new NodeFactory<XNodeConversationProcessor>());
		DialogueRegistry.RegisterProcessorFactory<PlayVideoNode>(new NodeFactory<PlayVideoNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<BlackScreenNode>(new NodeFactory<BlackScreenNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<SignalNode>(new NodeFactory<SignalNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<EnterBlackScreenNode>(new NodeFactory<EnterBlackScreenNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ExitBlackScreenNode>(new NodeFactory<ExitBlackScreenNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<EnterGlobalBlackScreenNode>(new NodeFactory<EnterGlobalBlackScreenNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ExitGlobalBlackScreenNode>(new NodeFactory<ExitGlobalBlackScreenNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<LogNode>(new NodeFactory<LogNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<WaitNode>(new NodeFactory<WaitNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<EnterCenterTextNode>(new NodeFactory<EnterCenterTextNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ExitCenterTextNode>(new NodeFactory<ExitCenterTextNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ShowCenterTextNode>(new NodeFactory<ShowCenterTextNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ShowAVGCaptionPrefabNode>(new NodeFactory<ShowAVGCaptionPrefabNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<TextProviderNode>(new NodeFactory<TextProviderNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ColorScreenNode>(new NodeFactory<ColorScreenNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<LoadBgNode>(new NodeFactory<LoadBgNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<HideBgNode>(new NodeFactory<HideBgNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ImageNode>(new NodeFactory<ImageNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<BgmNode>(new NodeFactory<BgmNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<BgmStateNode>(new NodeFactory<BgmStateNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<EnvBgmNode>(new NodeFactory<EnvBgmNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<SoundNode>(new NodeFactory<SoundNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<LetterboxNode>(new NodeFactory<LetterboxNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<CustomSubtitleNode>(new NodeFactory<CustomSubtitleNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<CommsChatNode>(new NodeFactory<CommsChatProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ChatStepEventsNode>(new NodeFactory<ChatStepEventsNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<BGMotionStepEventNode>(new NodeFactory<BGMotionStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<CameraMotionStepEventNode>(new NodeFactory<CameraMotionStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<CameraFocusStepEventNode>(new NodeFactory<CameraFocusStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<FogStepEventNode>(new NodeFactory<FogStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<LoungeRoleAnimStepEventNode>(new NodeFactory<LoungeRoleAnimStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<PlayNpcAnimationStepEventNode>(new NodeFactory<PlayNpcAnimationStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<RedWarningStepEventNode>(new NodeFactory<RedWarningStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ShakeStepEventNode>(new NodeFactory<ShakeStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<SparkleStepEventNode>(new NodeFactory<SparkleStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<WakeFxStepEventNode>(new NodeFactory<WakeFxStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<WhileFlashStepEventNode>(new NodeFactory<WhileFlashStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<SpineChangeAnimStepEventNode>(new NodeFactory<SpineChangeAnimStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<DepthOfFieldStepEventNode>(new NodeFactory<DepthOfFieldStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<PostProcessPrefabStepEventNode>(new NodeFactory<PostProcessPrefabStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<FilmNoiseScratchStepEventNode>(new NodeFactory<FilmNoiseScratchStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<ScreenTearStepEventNode>(new NodeFactory<ScreenTearStepEventNodeProcessor>());
		DialogueRegistry.RegisterProcessorFactory<WaitStepEventNode>(new NodeFactory<WaitStepEventNodeProcessor>());
	}
}
