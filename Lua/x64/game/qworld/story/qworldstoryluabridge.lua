function QWorldStorySetContent(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	QWorldMgr:GetQWorldStoryMgr():SetContent(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
end

function QWorldPlayStory(arg_2_0, arg_2_1)
	QWorldMgr:GetQWorldStoryMgr():StartStory(arg_2_0, nil)
end

function QWorldStoryOpenChoice(arg_3_0, arg_3_1, arg_3_2)
	QWorldMgr:GetQWorldStoryMgr():OpenChoice(arg_3_0, arg_3_2)
end

function QWorldStoryCloseChoice()
	QWorldMgr:GetQWorldStoryMgr():CloseChoice()
end

function QWorldEndStory()
	QWorldMgr:GetQWorldStoryMgr():StopStory()
end

function QWorldStartTalk(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	QWorldMgr:GetQWorldStoryMgr():StartTalk(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
end

function QWorldStartTalkList(arg_7_0, arg_7_1, arg_7_2)
	QWorldMgr:GetQWorldStoryMgr():StartTalkList(arg_7_0, arg_7_1, arg_7_2)
end

function QWorldHideTalk(arg_8_0)
	QWorldMgr:GetQWorldStoryMgr():HideTalk(arg_8_0)
end

function QWorldCloseTalk(arg_9_0)
	QWorldMgr:GetQWorldStoryMgr():CloseTalk(arg_9_0)
end
