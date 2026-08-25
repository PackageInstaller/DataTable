local DOTweenUtils = {}

function DOTweenUtils.Init()
  local oldSequenceFunc = CS.DG.Tweening.DOTween.Sequence
  DOTweenUtils.oldSequenceFunc = oldSequenceFunc
  
  function CS.DG.Tweening.DOTween.Sequence(target)
    assert(target, "ERROR: DOTween.Sequence必须传入target参数（Lua对象），以便最终通过KillAllTweensByTarget关闭该Target对象关联的所有Tween动画")
    do return oldSequenceFunc().SetId, (oldSequenceFunc()) end
    return oldSequenceFunc().SetId, oldSequenceFunc(), target
  end
  
  local oldToFunc = CS.DG.Tweening.DOTween.To
  DOTweenUtils.oldToFunc = oldToFunc
  
  function CS.DG.Tweening.DOTween.To(getter, setter, endValue, duration, target)
    assert(target, "ERROR: DOTween.To必须传入target参数（Lua对象），以便最终通过KillAllTweensByTarget关闭该Target对象关联的所有Tween动画")
    do return oldToFunc(getter, setter, endValue, duration).SetId, (oldToFunc(getter, setter, endValue, duration)) end
    return oldToFunc(getter, setter, endValue, duration).SetId, oldToFunc(getter, setter, endValue, duration), target, endValue, duration
  end
end

function DOTweenUtils.Release()
  print("=============================DOTweenUtils.Release()======")
  if DOTweenUtils.oldSequenceFunc then
    CS.DG.Tweening.DOTween.Sequence = DOTweenUtils.oldSequenceFunc
    DOTweenUtils.oldSequenceFunc = nil
  end
  if DOTweenUtils.oldToFunc then
    CS.DG.Tweening.DOTween.To = DOTweenUtils.oldToFunc
    DOTweenUtils.oldToFunc = nil
  end
  CS.DG.Tweening.DOTween.KillAll(true)
  CS.DG.Tweening.DOTween.Clear(true)
  local goTween = CS.UnityEngine.GameObject.Find("[DOTween]")
  if not IsNil(goTween) then
    CS.UnityEngine.GameObject.DestroyImmediate(goTween)
  end
end

function DOTweenUtils.KillAllTweensByTarget(target)
  CS.DG.Tweening.DOTween.Kill(target)
  if target and target.ui and target.ui.uiNode then
    DOTweenUtils.KillAllShortcutTweensOfRootNode(target.ui.uiNode)
  end
end

function DOTweenUtils.KillAllShortcutTweensOfRootNode(rootNode)
  CS.Z1Client.DOTweenUtil.KillAllShortcutTweensOfRootNode(rootNode)
end

return DOTweenUtils
