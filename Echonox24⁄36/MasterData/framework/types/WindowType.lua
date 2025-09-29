module("framework.types.WindowType", package.seeall)

return {
	WindowShowType = {
		FullScreenHudShowType = 4,
		ModalShowType = 1,
		FullScreenShowType = 3,
		NormalShowType = 2,
		NoneShowType = 0
	},
	WindowResourceType = {
		ResidentResourceType = 2,
		NoneResourceType = 0,
		ImmediateDestoryResourceType = 3,
		AutoResourceType = 1
	},
	WindowStatusType = {
		ViewStatusOpening = 2,
		ViewStatusClosing = 3,
		ViewStatusIniting = 1,
		ViewStatusClose = 5,
		ViewStatusOpen = 4
	},
	WindowOpType = {
		ViewOpClose = 3,
		ViewOpNone = 1,
		ViewOpOpen = 2
	},
	WindowOpenReasonType = {
		NormalOpenType = 1,
		QuickOpenType = 2
	},
	WindowCloseReasonType = {
		QuickCloseType = 2,
		NormalCloseType = 1
	},
	WindowAniType = {
		CloserAniType = "close",
		OpenAniType = "open"
	}
}
