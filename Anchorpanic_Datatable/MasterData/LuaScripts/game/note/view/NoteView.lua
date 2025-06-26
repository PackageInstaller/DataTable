--[[ 
-----------------------------------------------------
@filename       : NoteView
@Description    : 便签界面
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('note.NoteView', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath('note/NoteView.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function dtor(self)
end

function initData(self)
    -- item字典
    self.mItemDic = {}

    -- item高度
    self.mItemH = 94
    -- item间隔
    self.mItemGap = 15
end

function configUI(self)
    self.mGroupList = self:getChildTrans("mGroupList")
    self.mItemNote = self:getChildGO("mItemNote")
end

function active(self)
    super.active(self)
    note.NoteManager:addEventListener(note.NoteManager.NOTE_CLEAR, self.onClearHandler, self)
    note.NoteManager:addEventListener(note.NoteManager.NOTE_UPDATE, self.onUpdateHandler, self)
    self:checkUpdateView()
end

function deActive(self)
    super.deActive(self)
    note.NoteManager:removeEventListener(note.NoteManager.NOTE_CLEAR, self.onClearHandler, self)
    note.NoteManager:removeEventListener(note.NoteManager.NOTE_UPDATE, self.onUpdateHandler, self)
    self:onClearHandler()
end

function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 回收预制体
function resetAllItem(self)
    if (self.mItemDic) then
        for index, data in pairs(self.mItemDic) do
            self:clearTimeout(data.timeId)
            data.tween:Kill()
            data.item:poolRecover()
        end
    end
    self.mItemDic = {}
end

function show(self, parent)
    self:setParentTrans(parent)
    self:checkUpdateView()
end

-- 清理
function onClearHandler(self)
    self:clearAllTimeout()
    self:resetAllItem()
end

-- 更新
function onUpdateHandler(self, args)
    self:checkUpdateView()
end

function checkUpdateView(self)
    if (not note.NoteManager.hasTypeFriendInit or not note.NoteManager.hasTypeMailInit) then
        return
    end
    if (not note.NoteManager:getEnableByUi() or not note.NoteManager:getEnableByLoading() or not note.NoteManager:getEnableByFight()) then
        return
    end

    local hasMail = false
    for index = 1, note.NoteShowNum do
        if (not self.mItemDic[index]) then
            local noteVo = note.NoteManager:popNote()
            if (noteVo) then
                local noteConfigVo = note.NoteManager:getNoteConfigVo(noteVo.type, noteVo.funId)
                if(not hasMail and noteVo.type == note.NoteType.UNREAD_MAIL) then 
                    hasMail = true
                end
                local item = SimpleInsItem:create(self.mItemNote, self.mGroupList, self.__cname .. ".NoteItem")
                item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("note/note_icon_" .. noteConfigVo.type .. ".png"), true)
                item:getChildGO("mTextTitle"):GetComponent(ty.Text).text = _TT(noteConfigVo.title)
                item:getChildGO("mTextContent"):GetComponent(ty.Text).text = _TT(noteConfigVo.des)

                local function _clickItemFun()
                    if (noteConfigVo.uiCode and noteConfigVo.uiCode > 0) then
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = noteConfigVo.uiCode })
                    else
                        Debug:log_error("NoteView", string.format("uicode配置异常，为%s", noteConfigVo.uiCode))
                    end
                end
                item:addUIEvent("mImgClick", _clickItemFun, nil)

                self:addNoteAction(index, item, noteVo)
            end
        end
    end
    -- 屏蔽新邮件语音播报功能（没有录这个语音了）
    -- if(hasMail) then 
    --     self:playAddMailCv()
    -- end
end

function playAddMailCv(self)
    local heroVo = hero.HeroManager:getHeroVo(role.RoleManager:getRoleVo():getShowBoardHeroId())
    if (not heroVo) then
        local list = hero.HeroManager:getHeroList()
        if list and #list > 0 then
            heroVo = list[1]
        end
    end
    if heroVo then
        AudioManager:playHeroCVByFieldName(heroVo.tid, "mail_voice")
    end
end

function addNoteAction(self, index, item, noteVo)
    local itemTrans = item:getTrans()
    gs.TransQuick:LPosXY(itemTrans, -500, self:getItemY(index))

    local function _onTimeOut()
        self:clearTimeout(self.mItemDic[index].timeId)
        self.mItemDic[index].tween:Kill()
        self.mItemDic[index].item:poolRecover()
        self.mItemDic[index] = nil
        note.NoteManager:removeNote(noteVo.type, noteVo.funId)

        self:checkUpdateView()
    end
    self.mItemDic[index] = { item = item, timeId = self:setTimeout(3, _onTimeOut), tween = TweenFactory:move2LPosX(itemTrans, 0, 0.5, gs.DT.Ease.OutQuad, nil) }
end

-- 获取Item的y坐标
function getItemY(self, index)
    return -(index - 1) * (self.mItemH + self.mItemGap)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]