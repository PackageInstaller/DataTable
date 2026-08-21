-- @FileName:   BigHostelPoseUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.bigHostel.view.BigHostelPoseUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bigHostel/BigHostelPoseUI.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
isAdapta = 1 --是否开启适配刘海
isScreensave = 0
isAddMask = 0

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
    self.mSceneSelectGroup = self:getChildGO("mSceneSelectGroup")
    self.mSelectItem = self:getChildGO("mSelectItem")

    self.mTouch = self:getChildGO("mTouch")
end

function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mTouch, self.onClickClose)
end
--激活
function active(self, args)
    super.active(self)

    self.m_sceneModel = bigHostel.BigHostelManager:getSceneModel()
    local bodyShorHash = self.m_sceneModel:getBodyShortHash()
    self.m_list =
    {
        gs.Animator.StringToHash("NF_stand"),
        gs.Animator.StringToHash("NF_stand_pose1"),
        gs.Animator.StringToHash("NF_stand_pose2"),
        gs.Animator.StringToHash("NF_stand_pose3"),
        gs.Animator.StringToHash("NF_stand_pose4"),
        -- gs.Animator.StringToHash("NF_stand_pose5"),
        gs.Animator.StringToHash("NF_stand_pose6"),
        gs.Animator.StringToHash("NF_stand_pose7"),
        gs.Animator.StringToHash("NF_stand_pose8"),

    }
    for k, hash in pairs(self.m_list) do
        if bodyShorHash == hash then
            self.m_selectIndex = k
            break
        end
    end

    self:refreshItem()

    self:refreshSelect()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearItem()
end

function refreshItem(self)
    self.m_sceneItemList = {}
    for i = 1, #self.m_list do
        local parent = self:getChildTrans(string.format("mSelectPoint (%s)", i))
        local item = SimpleInsItem:create(self.mSelectItem, parent, "BigHostelPoseUI_PoseItem")
        item.index = i
        item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/bigHostel/bigHostel_sceneIcon_%02d.png", i))

        item:addUIEvent(nil, function (_item)
            if self.m_selectIndex == _item.index then
                return
            end

            self.m_selectIndex = _item.index
            self:refreshSelect()

            self.m_sceneModel:setTrigger("leave")
            if _item.index == 1 then
                self.m_sceneModel:setInt("nf_pose", 99)
            else
                if(_item.index) <= 5 then
                    self.m_sceneModel:setInt("nf_pose", _item.index - 1)
                else
                    self.m_sceneModel:setInt("nf_pose", _item.index)
                end
            end
            self:close()
        end)

        table.insert(self.m_sceneItemList, item)
    end
end

function refreshSelect(self)
    if self.m_selectIndex then
        for i = 1, 10 do
            self.m_childGos[string.format("mImgSelect (%s)", i)]:SetActive(self.m_selectIndex == i)
        end
    end
end

function clearItem(self)
    if self.m_sceneItemList then
        for _, v in pairs(self.m_sceneItemList) do
            v.index = nil
            v:poolRecover()
        end

        self.m_sceneItemList = nil
    end
end

return _M
