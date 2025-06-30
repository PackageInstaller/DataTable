--[[ 
-----------------------------------------------------
@filename       : AchievementTip
@Description    : 成就提示
@date           : 2021-10-19 18:10:21
@Author         : zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('task.AchievementTip', Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("achievement/AchievementTip.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构  
function dtor(self)
end

-- 取父容器
function getParentTrans(self)
    return GameView.msg
end

function initData(self)
    self.mItemTip = nil
    self.mAngle = 0
end

-- 初始化
function configUI(self)
    self.mImgBgL = self:getChildGO("mImgBgL"):GetComponent(ty.AutoRefImage)
    self.mImgBgR = self:getChildGO("mImgBgR"):GetComponent(ty.AutoRefImage)
end

-- 激活
function active(self)
    super.active(self)
    self.mImgBgR:SetImg(UrlManager:getBgPath("sDiagramUi/vx_achievement_02.png"), false)
    self.mImgBgL:SetImg(UrlManager:getBgPath("sDiagramUi/vx_achievement_01.png"), false)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearTimer()
end

function clearTimer(self)
    if (self.mTimerId) then
        LoopManager:removeTimerByIndex(self.mTimerId)
        self.mTimerId = nil
    end
end

function checkActive(self)
    if (not self.mTimerId) then
        if (self.mItemTip) then
            self.mItemTip:poolRecover()
            self.mItemTip = nil
        end
        if (fight.SceneManager:isInFightScene()) then
            return
        end
        local achievementId = task.AchievementManager:getActiveAchievementId()
        if (achievementId) then
            local achievementVo = task.AchievementManager:getAchievementVo(achievementId)
            if (achievementVo) then
                local achievementConfigVo = task.AchievementManager:getAchievementConfigVo(achievementVo.id,
                achievementVo.step)
                self.mItemTip = SimpleInsItem:create(self:getChildGO("mItemTip"), self:getChildTrans("mGroup"),
                self.__cname .. "_achievement_tip_item")
                --local imgIcon = self.mItemTip:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
                local textTip = self.mItemTip:getChildGO("mTxtTip"):GetComponent(ty.Text)

                -- imgIcon:SetImg(UrlManager:getPackPath(string.format("achievement/achievement_preview_icon_%s.png",
                -- achievementConfigVo.tabType)))
                textTip.text = achievementConfigVo:getName()

                local function onTimer()
                    self:clearTimer()
                    self:checkActive()
                end
                self.mTimerId = LoopManager:addTimer(1.3, 1.3, self, onTimer)
            else
                self:checkActive()
            end
        end
    end
end
-- 时针动效
function updateEffect(self)
    self.mAngle = self.mAngle + 10
    TweenFactory:lRotate2(self:getChildTrans("mImgEffectBig"), { x = 0, y = 0, z = self.mAngle })
    TweenFactory:lRotate2(self:getChildTrans("mImgEffectBig"), { x = 0, y = 0, z = -self.mAngle })
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]