module("bootstrap.config.t_lang_launcher_tips", package.seeall)

local var_0_0 = {
	jp = 4,
	key = 1,
	zh = 2,
	tw = 3,
	th = 6,
	kr = 7,
	en = 5
}
local var_0_1 = {
	{
		"retry",
		"重试",
		"",
		"0",
		"Retry",
		"ลองใหม่",
		""
	},
	{
		"cancel",
		"取消",
		"",
		"0",
		"Cancel",
		"ยกเลิก",
		""
	},
	{
		"confirm",
		"确认",
		"",
		"0",
		"Confirm",
		"ยืนยัน",
		""
	},
	{
		"sure",
		"确定",
		"",
		"0",
		"Confirm",
		"ยืนยัน",
		""
	},
	{
		"tips",
		"提示",
		"",
		"ヒント",
		"Tips",
		"ทิปส์",
		"알림"
	},
	{
		"restart",
		"游戏已更新完毕，请重启游戏完成更新",
		"",
		"",
		"",
		"",
		""
	},
	{
		"a1",
		"游戏已更新，需要重新安装客户端，是否立即跳转到平台下载客户端？",
		"",
		"アプリが更新されました。ストアで新しいバージョンをダウンロードしますか？",
		"The client has been updated, and a client reinstall is required. Move to the platform to download the client now?",
		"ไคลเอนท์อัปเดตแล้ว ต้องติดตั้งไคลเอนท์ใหม่ ต้องการไปดาวน์โหลดไคลเอนท์หรือไม่?",
		""
	},
	{
		"a2",
		"检测到%s的资源需要更新，是否下载？\r\n（建议在wifi环境下进行）",
		"",
		"ゲームに必要なデータをダウンロードします。Wi-Fi環境でのダウンロードをおすすめします。ダウンロード容量は約%s、ダウンロードしますか？",
		"Resource file updates detected, the resource size is about %s. Update now? (Recommended to download in wifi environment)",
		"ต้องอัปเดตโครงสร้างดวงดาว ขนาดข้อมูล %s ทำการอัปเดตหรือไม่? (ควรใช้ wifi ในการโหลด)",
		""
	},
	{
		"a3",
		"获取更新信息中",
		"",
		"データダウンロード中",
		"Getting update information",
		"กำลังโหลดข้อมูลอัปเดต",
		""
	},
	{
		"a4",
		"<color=black>读取热更新前的资源失败，检查ui/views/bootstrap/目录</color>",
		"",
		"<color=black>データの読み込み中にエラーが発生しました。ui/views/bootstrap/目录</color>をチェックください。",
		"<color=black>Loading resources before hot update failed, check ui/views/bootstrap/directory</color>",
		"<color=black>อ่านข้อมูลก่อนฮอทอัปเดตล้มเหลว ตรวจสอบ ui/views/bootstrap/directory</color>",
		""
	},
	{
		"a5",
		"获取游戏配置失败，请检查网络",
		"",
		"エラーが発生しました。ネットワークの接続状態を確認して再度お試し下さい。",
		"Getting game configuration failed, please check the network",
		"โหลดตั้งค่าเกมล้มเหลว กรุณาตรวจสอบเครือข่าย",
		""
	},
	{
		"a6",
		"开始进行世界通讯——",
		"",
		"星界に接続開始",
		"Start getting game configuration",
		"เริ่มติดต่อกับโลก--",
		""
	},
	{
		"a7",
		"世界线同调完成…",
		"",
		"星界に接続済",
		"Getting game configuration completed",
		"ซิงโครไนซ์เวิลด์ไลน์สำเร็จ…",
		""
	},
	{
		"a8",
		"世界构造中",
		"",
		"星界構築中",
		"Loading resources",
		"กำลังสร้างโลก",
		""
	},
	{
		"a9",
		"检查更新中…",
		"",
		"更新データを読み込み中",
		"Checking for updates",
		"ตรวจสอบอัปเดต",
		""
	},
	{
		"a10",
		"更新中%d%s/s（%dMB/%dMB）",
		"",
		"データ更新中%d%s/s（%dMB/%dMB）",
		"Updating %d%s/s (%dMB/%dMB)",
		"กำลังอัปเดต %d%s/s (%dMB/%dMB)",
		""
	},
	{
		"a11",
		"正在解压资源... %d%%",
		"",
		"データ解凍中",
		"Unpacking %d%%",
		"กำลัง Extract ข้อมูล %d%%",
		""
	},
	{
		"a12",
		"解压完毕，请稍等",
		"",
		"解凍完了しました。星界構築中、暫くお待ちください。",
		"Unpacking complete, replacing resources, please wait",
		"Extract เสร็จสิ้น กำลังประกอบโครงสร้างโลก กรุณารอสักครู่",
		""
	},
	{
		"a13",
		"欢迎回来，主管",
		"",
		"ローディング中",
		"Loading resources",
		"โหลดข้อมูล",
		""
	},
	{
		"a14",
		"开始解压资源包",
		"",
		"データ解凍中%d%%",
		"Start unpacking the resource package",
		"เริ่ม Extract แพ็คเกจข้อมูล",
		""
	},
	{
		"a15",
		"下载热更新资源成功完成",
		"",
		"更新データはダウンロード完了しました",
		"Downloading hot update resource successfully completed",
		"โหลดข้อมูลฮอทอัปเดตสำเร็จ",
		""
	},
	{
		"a16",
		"请求服务器Version.manifest文件成功",
		"",
		"サーバーからVersion.manifestのダウンロードに成功しました",
		"Requesting server Version.manifest file succeeded",
		"ขอไฟล์ Version.manifest จากเซิร์ฟเวอร์สำเร็จ",
		""
	},
	{
		"a17",
		"请求服务器Project.manifest文件成功",
		"",
		"サーバーからProject.manifesのダウンロードに成功しました",
		"Requesting server Project.manifest file succeeded",
		"ขอไฟล์ Project.manifest จากเซิร์ฟเวอร์สำเร็จ",
		""
	},
	{
		"a18",
		"请求服务器更新配置失败，请重试",
		"",
		"サーバーが応答しません。再度お試しください",
		"Requesting server update configuration failed, please try again",
		"ขอตั้งค่าอัปเดตจากเซิร์ฟเวอร์ล้มเหลว กรุณาลองอีกครั้ง",
		""
	},
	{
		"a19",
		"下载更新资源包失败，请重试",
		"",
		"データの更新に失敗しました。再度お試しください。",
		"Downloading update resource package failed, please try again",
		"โหลดแพ็คเกจข้อมูลล้มเหลว กรุณาลองอีกครั้ง",
		""
	},
	{
		"a20",
		"解压资源包失败，请重试",
		"",
		"データの解凍に失敗しました。再度お試しください。",
		"Unpacking resource package failed, please try again",
		"Extract แพ็คเกจข้อมูลล้มเหลว กรุณาลองอีกครั้ง",
		""
	},
	{
		"a21",
		"连接服务器失败，请检查网络后重试",
		"",
		"ログイン初期化失敗、再度お試しください。",
		"Login initialization failed, please try again",
		"ล็อกอินเริ่มต้นล้มเหลว กรุณาลองอีกครั้ง",
		""
	},
	{
		"a22",
		"开始下载",
		"",
		"ダウンロード開始",
		"Start download",
		"เริ่มโหลด",
		""
	},
	{
		"a23",
		"连接服务器失败，请检查网络正常后点击[确认]继续下载",
		"",
		"データの更新に失敗しました。ネットワークの接続状態を確認して再度お試し下さい。",
		"Downloading update resource package failed, network error, please check the network and try again",
		"โหลดแพ็คเกจข้อมูลล้มเหลว เครือข่ายผิดปกติ กรุณาตรวจสอบเครือข่ายแล้วลองอีกครั้ง",
		""
	},
	{
		"a24",
		"下载更新资源包失败，资源缺失，请重试",
		"",
		"データの更新に失敗しました。データ欠損のため、再度お試し下さい。",
		"Downloading update resource package failed, missing resources, please try again",
		"โหลดแพ็คเกจข้อมูลล้มเหลว ข้อมูลไม่สมบูรณ์ กรุณาลองอีกครั้ง",
		""
	},
	{
		"a25",
		"下载更新资源包失败，服务器维护，请稍后重试",
		"",
		"データの更新に失敗しました。サーバーメンテナンス中のため、暫く時間を置いてからゲームを起動しなおしてください。",
		"Downloading update resource package failed, server under maintenance, please try again later",
		"โหลดแพ็คเกจข้อมูลล้มเหลว กำลังปรับปรุงเซิร์ฟเวอร์ กรุณาลองใหม่ในภายหลัง",
		""
	},
	{
		"a26",
		"下载更新资源包失败，磁盘空间不足，请清理空间后重试",
		"",
		"データの更新に失敗しました。ストレージの空き容量が不足しています。ゲームを起動するのに十分な容量が確保されるよう、ストレージの整理をお願いいたします。",
		"Downloading update resource package failed, insufficient disk space, please clean up the space and try again",
		"โหลดแพ็คเกจข้อมูลล้มเหลว ที่ว่างไม่พอ กรุณาลบข้อมูลบางส่วนแล้วลองอีกครั้ง",
		""
	},
	{
		"a27",
		"下载更新资源包失败，请求服务器超时，请稍后重试",
		"",
		"データの更新に失敗しました。オーバータイム、サーバーが応答しません。再度お試しください",
		"Downloading update resource package failed, server request timeout, please try again later",
		"โหลดแพ็คเกจข้อมูลล้มเหลว คำขอเซิร์ฟเวอร์หมดเวลา กรุณาลองใหม่ในภายหลัง",
		""
	},
	{
		"a28",
		"解压资源包失败，网络异常，请检查网络后重试",
		"",
		"データの解凍に失敗しました。ネットワークの接続状態を確認して再度お試し下さい。",
		"Unpacking resource package failed, network error, please check the network and try again",
		"Extract แพ็คเกจข้อมูลล้มเหลว เครือข่ายผิดปกติ กรุณาตรวจสอบเครือข่ายแล้วลองอีกครั้ง",
		""
	},
	{
		"a29",
		"解压资源包失败，资源缺失，请重试",
		"",
		"データの解凍に失敗しました。データ欠損のため、再度お試し下さい。",
		"Unpacking resource package failed, missing resources, please try again",
		"Extract แพ็คเกจข้อมูลล้มเหลว ข้อมูลไม่สมบูรณ์ กรุณาลองอีกครั้ง",
		""
	},
	{
		"a30",
		"解压资源包失败，服务器维护，请稍后重试",
		"",
		"",
		"Unpacking resource package failed, server under maintenance, please try again later",
		"Extract แพ็คเกจข้อมูลล้มเหลว กำลังปรับปรุงเซิร์ฟเวอร์ กรุณาลองใหม่ในภายหลัง",
		""
	},
	{
		"a31",
		"解压资源包失败，磁盘空间不足，请清理空间后重试",
		"",
		"",
		"Unpacking resource package failed, insufficient disk space, please clean up the space and try again",
		"Extract แพ็คเกจข้อมูลล้มเหลว ที่ว่างไม่พอ กรุณาลบข้อมูลบางส่วนแล้วลองอีกครั้ง",
		""
	},
	{
		"a32",
		"解压资源包失败，请求服务器超时，请稍后重试",
		"",
		"",
		"Unpacking resource package failed, server request timeout, please try again later",
		"Extract แพ็คเกจข้อมูลล้มเหลว คำขอเซิร์ฟเวอร์หมดเวลา กรุณาลองใหม่ในภายหลัง",
		""
	},
	{
		"a33",
		"手机空间不足，空间必须至少是待下载补丁包大小的3倍",
		"",
		"",
		"Insufficient phone storage space, the space must be at least 3 times the size of the patch to be downloaded",
		"ที่ว่างมือถือไม่พอ ควรมีที่ว่างสำหรับดาวน์โหลดอย่างน้อย 3 เท่าของขนาดแพทช์",
		""
	},
	{
		"a34",
		"修复游戏",
		"",
		"",
		"",
		"",
		""
	},
	{
		"a35",
		"本次修复会删除损坏的文件及不正确的设置，修复完成后会退出游戏，需手动启动游戏",
		"",
		"",
		"",
		"",
		""
	}
}
local var_0_2 = {
	dataList = var_0_1
}
local var_0_3 = {
	__index = function(arg_1_0, arg_1_1)
		local var_1_0 = var_0_0[arg_1_1]

		if var_1_0 then
			return rawget(arg_1_0, var_1_0)
		else
			error(string.format("the field name [%s] is nonexist!", arg_1_1))
		end
	end
}

for iter_0_0, iter_0_1 in ipairs(var_0_1) do
	var_0_2[iter_0_1[1]] = iter_0_1

	setmetatable(iter_0_1, var_0_3)
end

return var_0_2
