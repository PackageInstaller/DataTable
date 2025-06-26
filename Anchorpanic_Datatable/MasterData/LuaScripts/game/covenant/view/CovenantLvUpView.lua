module("covenant.CovenantLvUpView", Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("covenant/CovenantLvUpView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_isTweening = false
end

-- 设置父容器
function getParentTrans(self)
    return GameView.msg
end

function configUI(self)
    self.mPreLvTxt = self:getChildGO("PreLvTxt"):GetComponent(ty.Text)
    self.mCurLvTxt = self:getChildGO("CurLvTxt"):GetComponent(ty.Text)
    self.mForcesTxt = self:getChildGO("ForcesTxt"):GetComponent(ty.Text)

    self.mBgCs = self:getChildGO("BG"):GetComponent(ty.CanvasGroup)
    self.mPreCs = self.mPreLvTxt.gameObject:GetComponent(ty.CanvasGroup)
    self.mCurCs = self.mCurLvTxt.gameObject:GetComponent(ty.CanvasGroup)

    self.mPreRt = self.mPreLvTxt.gameObject:GetComponent(ty.RectTransform)
    self.mCurRt = self.mCurLvTxt.gameObject:GetComponent(ty.RectTransform)
end

function start(self, args)
    --GameDispatcher:dispatchEvent(EventName.START_SHOW_FORCES_LV_UP,{forces_id = 1,pre_Lv = 1,cur_Lv = 3})
    if(self.tween1) then
        self.tween1:Kill()
    end

    if(self.tween2) then
        self.tween2:Kill()
    end

    self.cusForcesId = args.forces_id
    local selectData = covenant.CovenantManager:getCovenantSelectData(self.cusForcesId)
    self.mForcesTxt.text = _TT(selectData.name) .. _TT(29525)
    self.mPreLvTxt.text = args.pre_Lv
    self.mCurLvTxt.text = args.cur_Lv

    self.mBgCs.alpha = 0

    self.tween1 = TweenFactory:canvasGroupAlphaTo(self.mBgCs, 0, 1, 0.4, gs.DT.Ease.InSine)
    self.tween2 =
        TweenFactory:canvasGroupAlphaTo(
        self.mPreCs,
        0,
        1,
        0.4,
        gs.DT.Ease.InSine,
        function()
            self.mPreCs.alpha = 0
            self.mCurCs.alpha = 1

            self.mCurLvTxt.gameObject:SetActive(true)
            TweenFactory:scaleTo01(
                self.mCurRt,
                4,
                1,
                0.25,
                gs.DT.Ease.InSine,
                function()
                    TweenFactory:canvasGroupAlphaTo(self.mBgCs, 1, 0, 1.5, gs.DT.Ease.InSine)
                    TweenFactory:canvasGroupAlphaTo(self.mCurCs, 1, 0, 1.5, gs.DT.Ease.InSine)
                end
            )
        end
    )
end

function active(self)
end

function deActive(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
