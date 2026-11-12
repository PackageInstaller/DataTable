namespace XLua.CSObjectWrap;

public static class HotfixGenInitRegister
{
	public static void Register(ObjectTranslator translator)
	{
		if (translator != null)
		{
			translator.DelayWrapLoader(typeof(SoldierLevelController.SoldierMsg), SoldierLevelControllerSoldierMsgWrap.__Register);
			translator.DelayWrapLoader(typeof(SoldierLevelController.SoldierLevelMsg), SoldierLevelControllerSoldierLevelMsgWrap.__Register);
			translator.DelayWrapLoader(typeof(SoldierLevelController.SoldierAttr), SoldierLevelControllerSoldierAttrWrap.__Register);
			translator.DelayWrapLoader(typeof(NovaAPIHotfix), NovaAPIHotfixWrap.__Register);
			translator.DelayWrapLoader(typeof(SoldierActor), SoldierActorWrap.__Register);
			translator.DelayWrapLoader(typeof(SoldierLevelController), SoldierLevelControllerWrap.__Register);
			translator.DelayWrapLoader(typeof(DormModuleHelper_HotFix), DormModuleHelper_HotFixWrap.__Register);
			translator.DelayWrapLoader(typeof(NovaAPI), NovaAPIWrap.__Register);
			translator.DelayWrapLoader(typeof(AdventureModuleHelper), AdventureModuleHelperWrap.__Register);
			translator.DelayWrapLoader(typeof(MainMenuModuleHelper), MainMenuModuleHelperWrap.__Register);
			translator.DelayWrapLoader(typeof(InteractiveManager), InteractiveManagerWrap.__Register);
			translator.DelayWrapLoader(typeof(FRIndicator), FRIndicatorWrap.__Register);
			translator.DelayWrapLoader(typeof(HpBarColor), HpBarColorWrap.__Register);
			translator.DelayWrapLoader(typeof(HpBarCanvasGroup), HpBarCanvasGroupWrap.__Register);
			translator.DelayWrapLoader(typeof(HpBarRectTransform), HpBarRectTransformWrap.__Register);
			translator.DelayWrapLoader(typeof(HpBarRotation), HpBarRotationWrap.__Register);
			translator.DelayWrapLoader(typeof(AdventureModuleLevelLoadParams.BootConfigLoadType), AdventureModuleLevelLoadParamsBootConfigLoadTypeWrap.__Register);
		}
	}
}
