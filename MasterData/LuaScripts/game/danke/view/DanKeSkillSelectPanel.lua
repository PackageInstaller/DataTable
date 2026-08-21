-- @FileName:   DanKeSkillSelectPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.view.DanKeSkillSelectPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("danke/DanKeSkillSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mItemWeapon = self:getChildGO("mItemWeapon")
    self.mWeaponGroup = self:getChildTrans("mWeaponGroup")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)
    self.m_lastTimeScale = gs.Time.timeScale
    fight.FightManager:setupTimeScale(0)

    GameDispatcher:dispatchEvent(EventName.DANKE_UPDATE_PAUSESTATE, true)

    self:refreshSkill(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItem()
    GameDispatcher:dispatchEvent(EventName.DANKE_UPDATE_PAUSESTATE, false)
end

function refreshSkill(self, args)
    self.m_skillList = args.skill_list
    self.m_closeCall = args.closeCall

    self:clearItem()
    for i = 1, #self.m_skillList do
        local vo = self.m_skillList[i]
        local item = SimpleInsItem:create(self.mItemWeapon, self.mWeaponGroup, "DanKeSkillSelectPanel_Item")

        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(vo:getIcon())
        item:getChildGO("mTextName"):GetComponent(ty.Text).text = vo:getName()

        item:getChildGO("mSignWeapon"):SetActive(vo.type == DanKeConst.PlayerSkill_Type.Initiative)
        item:getChildGO("mSignBuff"):SetActive(vo.type == DanKeConst.PlayerSkill_Type.Passive)
        item:getChildGO("mTextLv"):GetComponent(ty.Text).text = "LV." .. vo:getLevel()

        local levelParam = vo:getSelfLevelConfig()
        item:getChildGO("mTextDesc"):GetComponent(ty.Text).text = _TT(levelParam.des)

        item:addUIEvent(nil, function ()
            GameDispatcher:dispatchEvent(EventName.DANKE_SELECT_SKILL, vo)
            self:close()
        end)
        table.insert(self.m_itemList, item)
    end
end

function close(self)
    if not self:m_closeCall() then
        super.close(self)
        fight.FightManager:setupTimeScale(self.m_lastTimeScale or 1)
    end
end

function clearItem(self)
    if self.m_itemList then
        for _, item in pairs(self.m_itemList) do
            item:recover()
        end
    end

    self.m_itemList = {}
end

return _M
