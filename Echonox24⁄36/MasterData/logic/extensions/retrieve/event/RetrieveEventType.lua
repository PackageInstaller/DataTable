-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/event/RetrieveEventType.lua

module("logic.extensions.retrieve.event.RetrieveEventType", package.seeall)

local RetrieveEventType = {}

RetrieveEventType.DATA_REFRESH = UIDUtil.getEventUID()
RetrieveEventType.CHOOSE_LOTTERY_END = UIDUtil.getEventUID()
RetrieveEventType.LOTTERY_LOG_FILTER = UIDUtil.getEventUID()
RetrieveEventType.LOTTERY_PICK_ITEM = UIDUtil.getEventUID()
RetrieveEventType.LOTTERY_CHOOSE_POOL_END = UIDUtil.getEventUID()
RetrieveEventType.Enter_Show_Finish = UIDUtil.getEventUID()
RetrieveEventType.Retrieve_FLOW_END = UIDUtil.getEventUID()
RetrieveEventType.Retrieve_Show_Phone = UIDUtil.getEventUID()
RetrieveEventType.Retrieve_Show_Phone_End = UIDUtil.getEventUID()
RetrieveEventType.Select_Pool = UIDUtil.getEventUID()
RetrieveEventType.Begin_Show_Lottery = UIDUtil.getEventUID()
RetrieveEventType.Show_Lottery_UI_Finish = UIDUtil.getEventUID()
RetrieveEventType.Phone_Button_Click = UIDUtil.getEventUID()
RetrieveEventType.Show_Jump_View = UIDUtil.getEventUID()
RetrieveEventType.Show_Hero_Info = UIDUtil.getEventUID()
RetrieveEventType.Open_Get_Role_UI = UIDUtil.getEventUID()
RetrieveEventType.EnterShowVideoFinish = UIDUtil.getEventUID()
RetrieveEventType.onTestLotteryCharacterReply = UIDUtil.getEventUID()
RetrieveEventType.onTestLotteryCharacterNO2Reply = UIDUtil.getEventUID()
RetrieveEventType.onTestLotteryCharacterNO3Reply = UIDUtil.getEventUID()
RetrieveEventType.onTestLotteryCharacterChange = UIDUtil.getEventUID()

return RetrieveEventType
