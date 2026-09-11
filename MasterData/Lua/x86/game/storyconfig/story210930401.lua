return {
	Play1109304001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109304001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109304002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST11a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST11a")
				var_4_0.name = "ST11a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST11a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST11a

				arg_1_1.bgs_.ST11a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST11a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109304001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109304002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109304002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109304003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109304002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 15 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 15)

				if (15 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 15)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1109304003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109304003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109304004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.65

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1109304003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 26 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 26)

				if (26 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 26)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1109304004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109304004
		arg_17_1.duration_ = 4.1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109304005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1093ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1093ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1093ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1093ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1093ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1093ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_20_5 = arg_17_1.actors_["1093ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1109304004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 19 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 19)

				if (19 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 19)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304004", "story_v_side_new_1109304.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304004", "story_v_side_new_1109304.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1109304", "1109304004", "story_v_side_new_1109304.awb")

						arg_17_1:RecordAudio("1109304004", var_20_15)
						arg_17_1:RecordAudio("1109304004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304004", "story_v_side_new_1109304.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304004", "story_v_side_new_1109304.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play1109304005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109304005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109304006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1093ui_story"]) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = arg_21_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1093ui_story"]) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(arg_21_1.actors_["1093ui_story"]) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1093ui_story"]) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109304005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 28 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 28)

				if (28 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 28)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109304006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109304006
		arg_25_1.duration_ = 12.03

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109304007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action448")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_28_0 = arg_25_1.actors_["1093ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_1 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 and not isNil(var_28_0) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_28_3 = 0
			local var_28_4 = 1.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:GetWordFromCfg(1109304006)
				local var_28_6 = arg_25_1:FormatText(var_28_5.content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 49 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 49)

				if (49 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 49)) > 0 and var_28_4 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304006", "story_v_side_new_1109304.awb") ~= 0 then
					local var_28_9 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304006", "story_v_side_new_1109304.awb") / 1000

					if var_28_9 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_3
					end

					if var_28_5.prefab_name ~= "" and arg_25_1.actors_[var_28_5.prefab_name] ~= nil then
						local var_28_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_5.prefab_name].transform, "story_v_side_new_1109304", "1109304006", "story_v_side_new_1109304.awb")

						arg_25_1:RecordAudio("1109304006", var_28_10)
						arg_25_1:RecordAudio("1109304006", var_28_10)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304006", "story_v_side_new_1109304.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304006", "story_v_side_new_1109304.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_11 and arg_25_1.time_ < var_28_3 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109304007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109304007
		arg_29_1.duration_ = 5.77

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109304008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_32_0 = 0
			local var_32_1 = 0.95

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(1109304007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 38 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 38)

				if (38 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 38)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304007", "story_v_side_new_1109304.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304007", "story_v_side_new_1109304.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_side_new_1109304", "1109304007", "story_v_side_new_1109304.awb")

						arg_29_1:RecordAudio("1109304007", var_32_7)
						arg_29_1:RecordAudio("1109304007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304007", "story_v_side_new_1109304.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304007", "story_v_side_new_1109304.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109304008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109304008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109304009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = arg_33_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(arg_33_1.actors_["1093ui_story"]) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_2")
			end

			local var_36_1 = 0
			local var_36_2 = 0.425

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1109304008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 17 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 17)

				if (17 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 17)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109304009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109304009
		arg_37_1.duration_ = 12.17

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109304010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = arg_37_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(arg_37_1.actors_["1093ui_story"]) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_40_2 = 0
			local var_40_3 = 1.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(1109304009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 44 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 44)

				if (44 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 44)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304009", "story_v_side_new_1109304.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304009", "story_v_side_new_1109304.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_new_1109304", "1109304009", "story_v_side_new_1109304.awb")

						arg_37_1:RecordAudio("1109304009", var_40_9)
						arg_37_1:RecordAudio("1109304009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304009", "story_v_side_new_1109304.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304009", "story_v_side_new_1109304.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109304010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109304010
		arg_41_1.duration_ = 6.5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109304011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_44_0 = 0
			local var_44_1 = 0.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(1109304010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 29 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 29)

				if (29 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 29)) > 0 and var_44_1 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304010", "story_v_side_new_1109304.awb") ~= 0 then
					local var_44_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304010", "story_v_side_new_1109304.awb") / 1000

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end

					if var_44_2.prefab_name ~= "" and arg_41_1.actors_[var_44_2.prefab_name] ~= nil then
						local var_44_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_2.prefab_name].transform, "story_v_side_new_1109304", "1109304010", "story_v_side_new_1109304.awb")

						arg_41_1:RecordAudio("1109304010", var_44_7)
						arg_41_1:RecordAudio("1109304010", var_44_7)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304010", "story_v_side_new_1109304.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304010", "story_v_side_new_1109304.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1109304011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109304011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109304012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1093ui_story"]) and arg_45_1.var_.characterEffect1093ui_story == nil then
				arg_45_1.var_.characterEffect1093ui_story = arg_45_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1093ui_story"]) then
				if arg_45_1.var_.characterEffect1093ui_story and not isNil(arg_45_1.actors_["1093ui_story"]) then
					arg_45_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1093ui_story"]) and arg_45_1.var_.characterEffect1093ui_story then
				arg_45_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1109304011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 37 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 37)

				if (37 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 37)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1109304012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109304012
		arg_49_1.duration_ = 3.1

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109304013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = arg_49_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) then
				if arg_49_1.var_.characterEffect1093ui_story and not isNil(arg_49_1.actors_["1093ui_story"]) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.125

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(1109304012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 5 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 5)

				if (5 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 5)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304012", "story_v_side_new_1109304.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304012", "story_v_side_new_1109304.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_new_1109304", "1109304012", "story_v_side_new_1109304.awb")

						arg_49_1:RecordAudio("1109304012", var_52_9)
						arg_49_1:RecordAudio("1109304012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304012", "story_v_side_new_1109304.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304012", "story_v_side_new_1109304.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109304013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109304013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1109304014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1093ui_story = arg_53_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1093ui_story"].transform.position).z)
				arg_53_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1093ui_story"].transform.localEulerAngles = arg_53_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1093ui_story"].transform.position).z)
				arg_53_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1093ui_story"].transform.localEulerAngles = arg_53_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_get", "")
			end

			local var_56_2 = 0
			local var_56_3 = 0.8

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1109304013).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 31 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 31)

				if (31 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 31)) > 0 and var_56_3 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_7 and arg_53_1.time_ < var_56_2 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109304014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109304014
		arg_57_1.duration_ = 3.67

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1109304015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(1109304014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 11 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 11)

				if (11 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 11)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304014", "story_v_side_new_1109304.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304014", "story_v_side_new_1109304.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_side_new_1109304", "1109304014", "story_v_side_new_1109304.awb")

						arg_57_1:RecordAudio("1109304014", var_60_6)
						arg_57_1:RecordAudio("1109304014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304014", "story_v_side_new_1109304.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304014", "story_v_side_new_1109304.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1109304015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109304015
		arg_61_1.duration_ = 2.13

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1109304016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.225

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(1109304015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 9 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 9)

				if (9 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 9)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304015", "story_v_side_new_1109304.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304015", "story_v_side_new_1109304.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_side_new_1109304", "1109304015", "story_v_side_new_1109304.awb")

						arg_61_1:RecordAudio("1109304015", var_64_6)
						arg_61_1:RecordAudio("1109304015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304015", "story_v_side_new_1109304.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304015", "story_v_side_new_1109304.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1109304016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109304016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109304017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1109304016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 52 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 52)

				if (52 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 52)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1109304017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109304017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1109304018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1109304017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 40 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 40)

				if (40 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 40)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1109304018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109304018
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1109304019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.075

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(1109304018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 3 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 3)

				if (3 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 3)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304018", "story_v_side_new_1109304.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304018", "story_v_side_new_1109304.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_side_new_1109304", "1109304018", "story_v_side_new_1109304.awb")

						arg_73_1:RecordAudio("1109304018", var_76_6)
						arg_73_1:RecordAudio("1109304018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304018", "story_v_side_new_1109304.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304018", "story_v_side_new_1109304.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1109304019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109304019
		arg_77_1.duration_ = 1.4

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1109304020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(1109304019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 4 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 4)

				if (4 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 4)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304019", "story_v_side_new_1109304.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304019", "story_v_side_new_1109304.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_side_new_1109304", "1109304019", "story_v_side_new_1109304.awb")

						arg_77_1:RecordAudio("1109304019", var_80_6)
						arg_77_1:RecordAudio("1109304019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304019", "story_v_side_new_1109304.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304019", "story_v_side_new_1109304.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1109304020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109304020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109304021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.65

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1109304020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 26 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 26)

				if (26 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 26)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109304021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109304021
		arg_85_1.duration_ = 7.63

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109304022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1093ui_story = arg_85_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).z)
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles = arg_85_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_85_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).z)
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles = arg_85_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_88_1 = arg_85_1.actors_["1093ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1093ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1093ui_story then
				arg_85_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.6

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(1109304021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 24 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 24)

				if (24 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 24)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304021", "story_v_side_new_1109304.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304021", "story_v_side_new_1109304.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_new_1109304", "1109304021", "story_v_side_new_1109304.awb")

						arg_85_1:RecordAudio("1109304021", var_88_11)
						arg_85_1:RecordAudio("1109304021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304021", "story_v_side_new_1109304.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304021", "story_v_side_new_1109304.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109304022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109304022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109304023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1093ui_story"]) and arg_89_1.var_.characterEffect1093ui_story == nil then
				arg_89_1.var_.characterEffect1093ui_story = arg_89_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1093ui_story"]) then
				if arg_89_1.var_.characterEffect1093ui_story and not isNil(arg_89_1.actors_["1093ui_story"]) then
					arg_89_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1093ui_story"]) and arg_89_1.var_.characterEffect1093ui_story then
				arg_89_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1109304022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 4 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 4)

				if (4 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 4)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109304023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109304023
		arg_93_1.duration_ = 9.4

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109304024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_96_0 = arg_93_1.actors_["1093ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_1 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 and not isNil(var_96_0) then
				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1093ui_story then
				arg_93_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_96_3 = 0
			local var_96_4 = 0.825

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:GetWordFromCfg(1109304023)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_8 = 33 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 33)

				if (33 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 33)) > 0 and var_96_4 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304023", "story_v_side_new_1109304.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304023", "story_v_side_new_1109304.awb") / 1000

					if var_96_9 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_3
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_side_new_1109304", "1109304023", "story_v_side_new_1109304.awb")

						arg_93_1:RecordAudio("1109304023", var_96_10)
						arg_93_1:RecordAudio("1109304023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304023", "story_v_side_new_1109304.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304023", "story_v_side_new_1109304.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_11 and arg_93_1.time_ < var_96_3 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109304024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109304024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109304025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1093ui_story"]) and arg_97_1.var_.characterEffect1093ui_story == nil then
				arg_97_1.var_.characterEffect1093ui_story = arg_97_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1093ui_story"]) then
				if arg_97_1.var_.characterEffect1093ui_story and not isNil(arg_97_1.actors_["1093ui_story"]) then
					arg_97_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1093ui_story"]) and arg_97_1.var_.characterEffect1093ui_story then
				arg_97_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.95

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1109304024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 38 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 38)

				if (38 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 38)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109304025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109304025
		arg_101_1.duration_ = 11.3

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1109304026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = arg_101_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) then
				if arg_101_1.var_.characterEffect1093ui_story and not isNil(arg_101_1.actors_["1093ui_story"]) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action447")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_104_2 = 0
			local var_104_3 = 0.625

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(1109304025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 25 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 25)

				if (25 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 25)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304025", "story_v_side_new_1109304.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304025", "story_v_side_new_1109304.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_side_new_1109304", "1109304025", "story_v_side_new_1109304.awb")

						arg_101_1:RecordAudio("1109304025", var_104_9)
						arg_101_1:RecordAudio("1109304025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304025", "story_v_side_new_1109304.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304025", "story_v_side_new_1109304.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1109304026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109304026
		arg_105_1.duration_ = 7.77

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109304027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_108_0 = 0
			local var_108_1 = 0.775

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(1109304026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 30 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 30)

				if (30 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 30)) > 0 and var_108_1 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304026", "story_v_side_new_1109304.awb") ~= 0 then
					local var_108_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304026", "story_v_side_new_1109304.awb") / 1000

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_side_new_1109304", "1109304026", "story_v_side_new_1109304.awb")

						arg_105_1:RecordAudio("1109304026", var_108_7)
						arg_105_1:RecordAudio("1109304026", var_108_7)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304026", "story_v_side_new_1109304.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304026", "story_v_side_new_1109304.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109304027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109304027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109304028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = arg_109_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) then
				if arg_109_1.var_.characterEffect1093ui_story and not isNil(arg_109_1.actors_["1093ui_story"]) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.075

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1109304027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 3 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 3)

				if (3 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 3)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1109304028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109304028
		arg_113_1.duration_ = 5.15

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1109304029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.STblack == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_116_0.name = "STblack"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.STblack = var_116_0
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.STblack

				arg_113_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "STblack" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_5 = 2

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_5 then
				local var_116_6 = Color.New(0, 0, 0)

				var_116_6.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_4) / var_116_5)
				arg_113_1.mask_.color = var_116_6
			end

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = 1
				arg_113_1.mask_.color = var_116_7
			end

			local var_116_8 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_9 = 2

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 then
				local var_116_10 = Color.New(0, 0, 0)

				var_116_10.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_8) / var_116_9)
				arg_113_1.mask_.color = var_116_10
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 then
				local var_116_11 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_11.a = 0
				arg_113_1.mask_.color = var_116_11
			end

			local var_116_12 = arg_113_1.actors_["1093ui_story"].transform

			if 1.966 < arg_113_1.time_ and arg_113_1.time_ <= 1.966 + arg_116_0 then
				arg_113_1.var_.moveOldPos1093ui_story = var_116_12.localPosition
			end

			local var_116_13 = 0.001

			if 1.966 <= arg_113_1.time_ and arg_113_1.time_ < 1.966 + var_116_13 then
				var_116_12.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 1.966) / var_116_13)
				var_116_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_12.position).x, (manager.ui.mainCamera.transform.position - var_116_12.position).y, (manager.ui.mainCamera.transform.position - var_116_12.position).z)
				var_116_12.localEulerAngles.z = 0
				var_116_12.localEulerAngles.x = 0
				var_116_12.localEulerAngles = var_116_12.localEulerAngles
			end

			if arg_113_1.time_ >= 1.966 + var_116_13 and arg_113_1.time_ < 1.966 + var_116_13 + arg_116_0 then
				var_116_12.localPosition = Vector3.New(0, 100, 0)
				var_116_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_12.position).x, (manager.ui.mainCamera.transform.position - var_116_12.position).y, (manager.ui.mainCamera.transform.position - var_116_12.position).z)
				var_116_12.localEulerAngles.z = 0
				var_116_12.localEulerAngles.x = 0
				var_116_12.localEulerAngles = var_116_12.localEulerAngles
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(true)
				arg_113_1.dialog_:SetActive(false)

				arg_113_1.fswtw_.percent = 0
				arg_113_1.fswt_.text = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1109304028).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.fswt_)

				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_113_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_113_1.fswtw_:SetDirty()

				arg_113_1.typewritterCharCountI18N = 0

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_14 = 2.01666666666667

			if 2.01666666666667 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_15 = 35
			local var_116_16 = 2.33333333333333
			local var_116_17, var_116_18 = arg_113_1:GetPercentByPara(arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1109304028).content), 1)

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_19 = var_116_15 <= 0 and var_116_16 or var_116_16 * ((var_116_18 - arg_113_1.typewritterCharCountI18N) / var_116_15)

				if (var_116_15 <= 0 and var_116_16 or var_116_16 * ((var_116_18 - arg_113_1.typewritterCharCountI18N) / var_116_15)) > 0 and var_116_16 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_14
					end
				end
			end

			local var_116_20 = math.max(2.33333333333333, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_20 then
				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_17, (arg_113_1.time_ - var_116_14) / var_116_20)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_20 and arg_113_1.time_ < var_116_14 + var_116_20 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_17

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_18
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_21 = arg_113_1.fswbg_.transform:Find("textbox/adapt/content") or arg_113_1.fswbg_.transform:Find("textbox/content")
				local var_116_22 = arg_113_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_116_23 = var_116_21:GetComponent("RectTransform")

				var_116_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_116_23.offsetMin = Vector2.New(0, 0)
				var_116_23.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109304029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109304029
		arg_117_1.duration_ = 2.13

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109304030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.oldValueTypewriter = arg_117_1.fswtw_.percent

				SetActive(arg_117_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_117_1:ShowNextGo(false)
			end

			local var_120_0 = 32
			local var_120_1 = 2.13333333333333
			local var_120_2, var_120_3 = arg_117_1:GetPercentByPara(arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1109304028).content), 2)

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				local var_120_4 = var_120_0 <= 0 and var_120_1 or var_120_1 * ((var_120_3 - arg_117_1.typewritterCharCountI18N) / var_120_0)

				if (var_120_0 <= 0 and var_120_1 or var_120_1 * ((var_120_3 - arg_117_1.typewritterCharCountI18N) / var_120_0)) > 0 and var_120_1 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end
			end

			local var_120_5 = math.max(2.13333333333333, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				arg_117_1.fswtw_.percent = Mathf.Lerp(arg_117_1.var_.oldValueTypewriter, var_120_2, (arg_117_1.time_ - 0) / var_120_5)
				arg_117_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_117_1.fswtw_:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				arg_117_1.fswtw_.percent = var_120_2

				arg_117_1.fswtw_:SetDirty()
				arg_117_1:ShowNextGo(true)

				arg_117_1.typewritterCharCountI18N = var_120_3
			end

			local var_120_6 = 0
			local var_120_7 = 0x0.0000000000001p-1022

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1109304029).content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 0 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_8) / 0)

				if (0 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_8) / 0)) > 0 and var_120_7 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_11 and arg_117_1.time_ < var_120_6 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109304030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109304030
		arg_121_1.duration_ = 3.53

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109304031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.oldValueTypewriter = arg_121_1.fswtw_.percent

				SetActive(arg_121_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_121_1:ShowNextGo(false)
			end

			local var_124_0 = 53
			local var_124_1 = 3.53333333333333
			local var_124_2, var_124_3 = arg_121_1:GetPercentByPara(arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1109304028).content), 3)

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				local var_124_4 = var_124_0 <= 0 and var_124_1 or var_124_1 * ((var_124_3 - arg_121_1.typewritterCharCountI18N) / var_124_0)

				if (var_124_0 <= 0 and var_124_1 or var_124_1 * ((var_124_3 - arg_121_1.typewritterCharCountI18N) / var_124_0)) > 0 and var_124_1 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end
			end

			local var_124_5 = math.max(3.53333333333333, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				arg_121_1.fswtw_.percent = Mathf.Lerp(arg_121_1.var_.oldValueTypewriter, var_124_2, (arg_121_1.time_ - 0) / var_124_5)
				arg_121_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_121_1.fswtw_:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 then
				arg_121_1.fswtw_.percent = var_124_2

				arg_121_1.fswtw_:SetDirty()
				arg_121_1:ShowNextGo(true)

				arg_121_1.typewritterCharCountI18N = var_124_3
			end

			local var_124_6 = 0
			local var_124_7 = 0x0.0000000000001p-1022

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1109304030).content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 0 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_8) / 0)

				if (0 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_8) / 0)) > 0 and var_124_7 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_11 and arg_121_1.time_ < var_124_6 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109304031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109304031
		arg_125_1.duration_ = 1.67

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109304032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.oldValueTypewriter = arg_125_1.fswtw_.percent

				SetActive(arg_125_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_125_1:ShowNextGo(false)
			end

			local var_128_0 = 25
			local var_128_1 = 1.66666666666667
			local var_128_2, var_128_3 = arg_125_1:GetPercentByPara(arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1109304028).content), 4)

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				local var_128_4 = var_128_0 <= 0 and var_128_1 or var_128_1 * ((var_128_3 - arg_125_1.typewritterCharCountI18N) / var_128_0)

				if (var_128_0 <= 0 and var_128_1 or var_128_1 * ((var_128_3 - arg_125_1.typewritterCharCountI18N) / var_128_0)) > 0 and var_128_1 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end
			end

			local var_128_5 = math.max(1.66666666666667, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				arg_125_1.fswtw_.percent = Mathf.Lerp(arg_125_1.var_.oldValueTypewriter, var_128_2, (arg_125_1.time_ - 0) / var_128_5)
				arg_125_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_125_1.fswtw_:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				arg_125_1.fswtw_.percent = var_128_2

				arg_125_1.fswtw_:SetDirty()
				arg_125_1:ShowNextGo(true)

				arg_125_1.typewritterCharCountI18N = var_128_3
			end

			local var_128_6 = 0
			local var_128_7 = 0x0.0000000000001p-1022

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1109304031).content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 0 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 0)

				if (0 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 0)) > 0 and var_128_7 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_11 and arg_125_1.time_ < var_128_6 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109304032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109304032
		arg_129_1.duration_ = 2.6

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109304033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_0 = 39
			local var_132_1 = 2.6
			local var_132_2, var_132_3 = arg_129_1:GetPercentByPara(arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1109304028).content), 5)

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_4 = var_132_0 <= 0 and var_132_1 or var_132_1 * ((var_132_3 - arg_129_1.typewritterCharCountI18N) / var_132_0)

				if (var_132_0 <= 0 and var_132_1 or var_132_1 * ((var_132_3 - arg_129_1.typewritterCharCountI18N) / var_132_0)) > 0 and var_132_1 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end
			end

			local var_132_5 = math.max(2.6, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_2, (arg_129_1.time_ - 0) / var_132_5)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_2

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_3
			end

			local var_132_6 = 0
			local var_132_7 = 0x0.0000000000001p-1022

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1109304032).content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 0 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 0)

				if (0 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 0)) > 0 and var_132_7 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_11 and arg_129_1.time_ < var_132_6 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109304033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109304033
		arg_133_1.duration_ = 1

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109304034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.oldValueTypewriter = arg_133_1.fswtw_.percent

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_0 = 2
			local var_136_1 = 0.133333333333333
			local var_136_2, var_136_3 = arg_133_1:GetPercentByPara(arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1109304028).content), 6)

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				local var_136_4 = var_136_0 <= 0 and var_136_1 or var_136_1 * ((var_136_3 - arg_133_1.typewritterCharCountI18N) / var_136_0)

				if (var_136_0 <= 0 and var_136_1 or var_136_1 * ((var_136_3 - arg_133_1.typewritterCharCountI18N) / var_136_0)) > 0 and var_136_1 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end
			end

			local var_136_5 = math.max(0.133333333333333, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				arg_133_1.fswtw_.percent = Mathf.Lerp(arg_133_1.var_.oldValueTypewriter, var_136_2, (arg_133_1.time_ - 0) / var_136_5)
				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_133_1.fswtw_:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				arg_133_1.fswtw_.percent = var_136_2

				arg_133_1.fswtw_:SetDirty()
				arg_133_1:ShowNextGo(true)

				arg_133_1.typewritterCharCountI18N = var_136_3
			end

			local var_136_6 = 0
			local var_136_7 = 0x0.0000000000001p-1022

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1109304033).content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 0 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_8) / 0)

				if (0 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_8) / 0)) > 0 and var_136_7 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_11 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_11 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_11

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_11 and arg_133_1.time_ < var_136_6 + var_136_11 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109304034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109304034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109304035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				local var_140_0 = arg_137_1.bgs_.ST11a

				arg_137_1.bgs_.ST11a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_1 = var_140_0:GetComponent("SpriteRenderer")

				if var_140_1 and var_140_1.sprite then
					local var_140_2 = 2 * (var_140_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_0.transform.localScale = Vector3.New(var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "ST11a" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_3 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_4 = 2

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_4 then
				local var_140_5 = Color.New(0, 0, 0)

				var_140_5.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_3) / var_140_4)
				arg_137_1.mask_.color = var_140_5
			end

			if arg_137_1.time_ >= var_140_3 + var_140_4 and arg_137_1.time_ < var_140_3 + var_140_4 + arg_140_0 then
				local var_140_6 = Color.New(0, 0, 0)

				var_140_6.a = 1
				arg_137_1.mask_.color = var_140_6
			end

			local var_140_7 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_8 = 2

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 then
				local var_140_9 = Color.New(0, 0, 0)

				var_140_9.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_7) / var_140_8)
				arg_137_1.mask_.color = var_140_9
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 then
				local var_140_10 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_10.a = 0
				arg_137_1.mask_.color = var_140_10
			end

			if 1.98333333333333 < arg_137_1.time_ and arg_137_1.time_ <= 1.98333333333333 + arg_140_0 then
				arg_137_1.fswbg_:SetActive(false)
				arg_137_1.dialog_:SetActive(false)
				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_137_1:ShowNextGo(false)
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_11 = 4
			local var_140_12 = 0.75

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_13 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_13:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_14 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1109304034).content)

				arg_137_1.text_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 30 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 30)

				if (30 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 30)) > 0 and var_140_12 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16
					var_140_11 = var_140_11 + 0.3

					if var_140_16 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_14
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_17 = var_140_11 + 0.3
			local var_140_18 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_17 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_17) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_17 + var_140_18 and arg_137_1.time_ < var_140_17 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109304035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109304035
		arg_143_1.duration_ = 3.33

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109304036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1093ui_story = arg_143_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1093ui_story"].transform.position).z)
				arg_143_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1093ui_story"].transform.localEulerAngles = arg_143_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_143_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1093ui_story"].transform.position).z)
				arg_143_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1093ui_story"].transform.localEulerAngles = arg_143_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action5_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_146_1 = arg_143_1.actors_["1093ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1093ui_story == nil then
				arg_143_1.var_.characterEffect1093ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1093ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1093ui_story then
				arg_143_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_146_4 = 0
			local var_146_5 = 0.3

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(1109304035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 12 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 12)

				if (12 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 12)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304035", "story_v_side_new_1109304.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304035", "story_v_side_new_1109304.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_side_new_1109304", "1109304035", "story_v_side_new_1109304.awb")

						arg_143_1:RecordAudio("1109304035", var_146_11)
						arg_143_1:RecordAudio("1109304035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304035", "story_v_side_new_1109304.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304035", "story_v_side_new_1109304.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play1109304036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109304036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109304037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1093ui_story"]) and arg_147_1.var_.characterEffect1093ui_story == nil then
				arg_147_1.var_.characterEffect1093ui_story = arg_147_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1093ui_story"]) then
				if arg_147_1.var_.characterEffect1093ui_story and not isNil(arg_147_1.actors_["1093ui_story"]) then
					arg_147_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1093ui_story"]) and arg_147_1.var_.characterEffect1093ui_story then
				arg_147_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 1.025

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1109304036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 41 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 41)

				if (41 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 41)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109304037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109304037
		arg_151_1.duration_ = 13.5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109304038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1093ui_story"]) and arg_151_1.var_.characterEffect1093ui_story == nil then
				arg_151_1.var_.characterEffect1093ui_story = arg_151_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1093ui_story"]) then
				if arg_151_1.var_.characterEffect1093ui_story and not isNil(arg_151_1.actors_["1093ui_story"]) then
					arg_151_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1093ui_story"]) and arg_151_1.var_.characterEffect1093ui_story then
				arg_151_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action454")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_154_2 = 0
			local var_154_3 = 0.85

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(1109304037)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 34 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 34)

				if (34 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 34)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304037", "story_v_side_new_1109304.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304037", "story_v_side_new_1109304.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_side_new_1109304", "1109304037", "story_v_side_new_1109304.awb")

						arg_151_1:RecordAudio("1109304037", var_154_9)
						arg_151_1:RecordAudio("1109304037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304037", "story_v_side_new_1109304.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304037", "story_v_side_new_1109304.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109304038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109304038
		arg_155_1.duration_ = 5.87

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109304039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_158_0 = 0
			local var_158_1 = 0.375

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(1109304038)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 15 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 15)

				if (15 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 15)) > 0 and var_158_1 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304038", "story_v_side_new_1109304.awb") ~= 0 then
					local var_158_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304038", "story_v_side_new_1109304.awb") / 1000

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end

					if var_158_2.prefab_name ~= "" and arg_155_1.actors_[var_158_2.prefab_name] ~= nil then
						local var_158_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_2.prefab_name].transform, "story_v_side_new_1109304", "1109304038", "story_v_side_new_1109304.awb")

						arg_155_1:RecordAudio("1109304038", var_158_7)
						arg_155_1:RecordAudio("1109304038", var_158_7)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304038", "story_v_side_new_1109304.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304038", "story_v_side_new_1109304.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109304039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109304039
		arg_159_1.duration_ = 0.2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"

			SetActive(arg_159_1.choicesGo_, true)

			for iter_160_0, iter_160_1 in ipairs(arg_159_1.choices_) do
				SetActive(iter_160_1.go, iter_160_0 <= 2)
			end

			arg_159_1.choices_[1].txt.text = arg_159_1:FormatText(StoryChoiceCfg[356].name)
			arg_159_1.choices_[2].txt.text = arg_159_1:FormatText(StoryChoiceCfg[357].name)
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109304040(arg_159_1)
			end

			if arg_161_0 == 2 then
				arg_159_0:Play1109304042(arg_159_1)
			end

			arg_159_1:RecordChoiceLog(1109304039, 356, 357)
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1093ui_story"]) and arg_159_1.var_.characterEffect1093ui_story == nil then
				arg_159_1.var_.characterEffect1093ui_story = arg_159_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1093ui_story"]) then
				if arg_159_1.var_.characterEffect1093ui_story and not isNil(arg_159_1.actors_["1093ui_story"]) then
					arg_159_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1093ui_story"]) and arg_159_1.var_.characterEffect1093ui_story then
				arg_159_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109304040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109304040
		arg_163_1.duration_ = 3.3

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1109304041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1093ui_story"]) and arg_163_1.var_.characterEffect1093ui_story == nil then
				arg_163_1.var_.characterEffect1093ui_story = arg_163_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1093ui_story"]) then
				if arg_163_1.var_.characterEffect1093ui_story and not isNil(arg_163_1.actors_["1093ui_story"]) then
					arg_163_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1093ui_story"]) and arg_163_1.var_.characterEffect1093ui_story then
				arg_163_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action447")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_166_2 = 0
			local var_166_3 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(1109304040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 8 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 8)

				if (8 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 8)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304040", "story_v_side_new_1109304.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304040", "story_v_side_new_1109304.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_side_new_1109304", "1109304040", "story_v_side_new_1109304.awb")

						arg_163_1:RecordAudio("1109304040", var_166_9)
						arg_163_1:RecordAudio("1109304040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304040", "story_v_side_new_1109304.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304040", "story_v_side_new_1109304.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109304041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109304041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109304044(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1093ui_story"]) and arg_167_1.var_.characterEffect1093ui_story == nil then
				arg_167_1.var_.characterEffect1093ui_story = arg_167_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1093ui_story"]) then
				if arg_167_1.var_.characterEffect1093ui_story and not isNil(arg_167_1.actors_["1093ui_story"]) then
					arg_167_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1093ui_story"]) and arg_167_1.var_.characterEffect1093ui_story then
				arg_167_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1109304041).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 6 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 6)

				if (6 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 6)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109304044 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109304044
		arg_171_1.duration_ = 9.57

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1109304045(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1093ui_story"]) and arg_171_1.var_.characterEffect1093ui_story == nil then
				arg_171_1.var_.characterEffect1093ui_story = arg_171_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1093ui_story"]) then
				if arg_171_1.var_.characterEffect1093ui_story and not isNil(arg_171_1.actors_["1093ui_story"]) then
					arg_171_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1093ui_story"]) and arg_171_1.var_.characterEffect1093ui_story then
				arg_171_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action479")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_174_2 = 0
			local var_174_3 = 0.7

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(1109304044)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 28 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 28)

				if (28 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 28)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304044", "story_v_side_new_1109304.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304044", "story_v_side_new_1109304.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_side_new_1109304", "1109304044", "story_v_side_new_1109304.awb")

						arg_171_1:RecordAudio("1109304044", var_174_9)
						arg_171_1:RecordAudio("1109304044", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304044", "story_v_side_new_1109304.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304044", "story_v_side_new_1109304.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109304045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109304045
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109304046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1093ui_story"]) and arg_175_1.var_.characterEffect1093ui_story == nil then
				arg_175_1.var_.characterEffect1093ui_story = arg_175_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1093ui_story"]) then
				if arg_175_1.var_.characterEffect1093ui_story and not isNil(arg_175_1.actors_["1093ui_story"]) then
					arg_175_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1093ui_story"]) and arg_175_1.var_.characterEffect1093ui_story then
				arg_175_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.2

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1109304045).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 8 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 8)

				if (8 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 8)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1109304046 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109304046
		arg_179_1.duration_ = 6.8

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109304047(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1093ui_story"]) and arg_179_1.var_.characterEffect1093ui_story == nil then
				arg_179_1.var_.characterEffect1093ui_story = arg_179_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1093ui_story"]) then
				if arg_179_1.var_.characterEffect1093ui_story and not isNil(arg_179_1.actors_["1093ui_story"]) then
					arg_179_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1093ui_story"]) and arg_179_1.var_.characterEffect1093ui_story then
				arg_179_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action496")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.75

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(1109304046)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 30 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 30)

				if (30 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 30)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304046", "story_v_side_new_1109304.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304046", "story_v_side_new_1109304.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_side_new_1109304", "1109304046", "story_v_side_new_1109304.awb")

						arg_179_1:RecordAudio("1109304046", var_182_9)
						arg_179_1:RecordAudio("1109304046", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304046", "story_v_side_new_1109304.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304046", "story_v_side_new_1109304.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109304047 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109304047
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109304048(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1093ui_story"]) and arg_183_1.var_.characterEffect1093ui_story == nil then
				arg_183_1.var_.characterEffect1093ui_story = arg_183_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1093ui_story"]) then
				if arg_183_1.var_.characterEffect1093ui_story and not isNil(arg_183_1.actors_["1093ui_story"]) then
					arg_183_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1093ui_story"]) and arg_183_1.var_.characterEffect1093ui_story then
				arg_183_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 1.25

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1109304047).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 50 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 50)

				if (50 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 50)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109304048 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109304048
		arg_187_1.duration_ = 5.07

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109304049(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1093ui_story"]) and arg_187_1.var_.characterEffect1093ui_story == nil then
				arg_187_1.var_.characterEffect1093ui_story = arg_187_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1093ui_story"]) then
				if arg_187_1.var_.characterEffect1093ui_story and not isNil(arg_187_1.actors_["1093ui_story"]) then
					arg_187_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1093ui_story"]) and arg_187_1.var_.characterEffect1093ui_story then
				arg_187_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_190_2 = 0
			local var_190_3 = 0.35

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(1109304048)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 14 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 14)

				if (14 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 14)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304048", "story_v_side_new_1109304.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304048", "story_v_side_new_1109304.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_side_new_1109304", "1109304048", "story_v_side_new_1109304.awb")

						arg_187_1:RecordAudio("1109304048", var_190_9)
						arg_187_1:RecordAudio("1109304048", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304048", "story_v_side_new_1109304.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304048", "story_v_side_new_1109304.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109304049 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109304049
		arg_191_1.duration_ = 12.2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1109304050(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action467")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_194_0 = 0
			local var_194_1 = 1.15

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(1109304049)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 46 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 46)

				if (46 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 46)) > 0 and var_194_1 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304049", "story_v_side_new_1109304.awb") ~= 0 then
					local var_194_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304049", "story_v_side_new_1109304.awb") / 1000

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end

					if var_194_2.prefab_name ~= "" and arg_191_1.actors_[var_194_2.prefab_name] ~= nil then
						local var_194_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_2.prefab_name].transform, "story_v_side_new_1109304", "1109304049", "story_v_side_new_1109304.awb")

						arg_191_1:RecordAudio("1109304049", var_194_7)
						arg_191_1:RecordAudio("1109304049", var_194_7)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304049", "story_v_side_new_1109304.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304049", "story_v_side_new_1109304.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1109304050 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109304050
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109304051(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1093ui_story"]) and arg_195_1.var_.characterEffect1093ui_story == nil then
				arg_195_1.var_.characterEffect1093ui_story = arg_195_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1093ui_story"]) then
				if arg_195_1.var_.characterEffect1093ui_story and not isNil(arg_195_1.actors_["1093ui_story"]) then
					arg_195_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1093ui_story"]) and arg_195_1.var_.characterEffect1093ui_story then
				arg_195_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.3

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1109304050).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 12 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 12)

				if (12 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 12)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1109304051 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1109304051
		arg_199_1.duration_ = 7

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1109304052(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1093ui_story"]) and arg_199_1.var_.characterEffect1093ui_story == nil then
				arg_199_1.var_.characterEffect1093ui_story = arg_199_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1093ui_story"]) then
				if arg_199_1.var_.characterEffect1093ui_story and not isNil(arg_199_1.actors_["1093ui_story"]) then
					arg_199_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1093ui_story"]) and arg_199_1.var_.characterEffect1093ui_story then
				arg_199_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_202_2 = 0
			local var_202_3 = 0.375

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_4 = arg_199_1:GetWordFromCfg(1109304051)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 15 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 15)

				if (15 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 15)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304051", "story_v_side_new_1109304.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304051", "story_v_side_new_1109304.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_side_new_1109304", "1109304051", "story_v_side_new_1109304.awb")

						arg_199_1:RecordAudio("1109304051", var_202_9)
						arg_199_1:RecordAudio("1109304051", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304051", "story_v_side_new_1109304.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304051", "story_v_side_new_1109304.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1109304052 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109304052
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1109304053(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1093ui_story"]) and arg_203_1.var_.characterEffect1093ui_story == nil then
				arg_203_1.var_.characterEffect1093ui_story = arg_203_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1093ui_story"]) then
				if arg_203_1.var_.characterEffect1093ui_story and not isNil(arg_203_1.actors_["1093ui_story"]) then
					arg_203_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1093ui_story"]) and arg_203_1.var_.characterEffect1093ui_story then
				arg_203_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 1.225

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1109304052).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 49 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 49)

				if (49 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 49)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1109304053 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109304053
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109304054(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.975

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1109304053).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 39 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 39)

				if (39 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 39)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109304054 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109304054
		arg_211_1.duration_ = 13.23

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1109304055(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1093ui_story"]) and arg_211_1.var_.characterEffect1093ui_story == nil then
				arg_211_1.var_.characterEffect1093ui_story = arg_211_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1093ui_story"]) then
				if arg_211_1.var_.characterEffect1093ui_story and not isNil(arg_211_1.actors_["1093ui_story"]) then
					arg_211_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1093ui_story"]) and arg_211_1.var_.characterEffect1093ui_story then
				arg_211_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action478")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_214_2 = 0
			local var_214_3 = 1.05

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(1109304054)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 42 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 42)

				if (42 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 42)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304054", "story_v_side_new_1109304.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304054", "story_v_side_new_1109304.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_side_new_1109304", "1109304054", "story_v_side_new_1109304.awb")

						arg_211_1:RecordAudio("1109304054", var_214_9)
						arg_211_1:RecordAudio("1109304054", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304054", "story_v_side_new_1109304.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304054", "story_v_side_new_1109304.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109304055 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109304055
		arg_215_1.duration_ = 5.1

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1109304056(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_218_0 = 0
			local var_218_1 = 0.35

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(1109304055)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 14 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 14)

				if (14 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 14)) > 0 and var_218_1 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304055", "story_v_side_new_1109304.awb") ~= 0 then
					local var_218_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304055", "story_v_side_new_1109304.awb") / 1000

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end

					if var_218_2.prefab_name ~= "" and arg_215_1.actors_[var_218_2.prefab_name] ~= nil then
						local var_218_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_2.prefab_name].transform, "story_v_side_new_1109304", "1109304055", "story_v_side_new_1109304.awb")

						arg_215_1:RecordAudio("1109304055", var_218_7)
						arg_215_1:RecordAudio("1109304055", var_218_7)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304055", "story_v_side_new_1109304.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304055", "story_v_side_new_1109304.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1109304056 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1109304056
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1109304057(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1093ui_story"]) and arg_219_1.var_.characterEffect1093ui_story == nil then
				arg_219_1.var_.characterEffect1093ui_story = arg_219_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1093ui_story"]) then
				if arg_219_1.var_.characterEffect1093ui_story and not isNil(arg_219_1.actors_["1093ui_story"]) then
					arg_219_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1093ui_story"]) and arg_219_1.var_.characterEffect1093ui_story then
				arg_219_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_2")
			end

			local var_222_1 = 0
			local var_222_2 = 0.575

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1109304056).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 23 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 23)

				if (23 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 23)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1109304057 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1109304057
		arg_223_1.duration_ = 9.7

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1109304058(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1093ui_story"]) and arg_223_1.var_.characterEffect1093ui_story == nil then
				arg_223_1.var_.characterEffect1093ui_story = arg_223_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1093ui_story"]) then
				if arg_223_1.var_.characterEffect1093ui_story and not isNil(arg_223_1.actors_["1093ui_story"]) then
					arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1093ui_story"]) and arg_223_1.var_.characterEffect1093ui_story then
				arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_226_2 = 0
			local var_226_3 = 1.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:GetWordFromCfg(1109304057)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 48 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 48)

				if (48 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 48)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304057", "story_v_side_new_1109304.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304057", "story_v_side_new_1109304.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_side_new_1109304", "1109304057", "story_v_side_new_1109304.awb")

						arg_223_1:RecordAudio("1109304057", var_226_9)
						arg_223_1:RecordAudio("1109304057", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304057", "story_v_side_new_1109304.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304057", "story_v_side_new_1109304.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1109304058 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1109304058
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1109304059(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1093ui_story"]) and arg_227_1.var_.characterEffect1093ui_story == nil then
				arg_227_1.var_.characterEffect1093ui_story = arg_227_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1093ui_story"]) then
				if arg_227_1.var_.characterEffect1093ui_story and not isNil(arg_227_1.actors_["1093ui_story"]) then
					arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1093ui_story"]) and arg_227_1.var_.characterEffect1093ui_story then
				arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 1.675

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1109304058).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 67 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 67)

				if (67 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 67)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1109304059 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1109304059
		arg_231_1.duration_ = 11.2

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1109304060(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1093ui_story"]) and arg_231_1.var_.characterEffect1093ui_story == nil then
				arg_231_1.var_.characterEffect1093ui_story = arg_231_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1093ui_story"]) then
				if arg_231_1.var_.characterEffect1093ui_story and not isNil(arg_231_1.actors_["1093ui_story"]) then
					arg_231_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1093ui_story"]) and arg_231_1.var_.characterEffect1093ui_story then
				arg_231_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_234_2 = 0
			local var_234_3 = 1.275

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(1109304059)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 51 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 51)

				if (51 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 51)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304059", "story_v_side_new_1109304.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304059", "story_v_side_new_1109304.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_side_new_1109304", "1109304059", "story_v_side_new_1109304.awb")

						arg_231_1:RecordAudio("1109304059", var_234_9)
						arg_231_1:RecordAudio("1109304059", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304059", "story_v_side_new_1109304.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304059", "story_v_side_new_1109304.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1109304060 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1109304060
		arg_235_1.duration_ = 8.43

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1109304061(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action443")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_238_0 = 0
			local var_238_1 = 0.975

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(1109304060)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 39 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 39)

				if (39 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 39)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304060", "story_v_side_new_1109304.awb") ~= 0 then
					local var_238_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304060", "story_v_side_new_1109304.awb") / 1000

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end

					if var_238_2.prefab_name ~= "" and arg_235_1.actors_[var_238_2.prefab_name] ~= nil then
						local var_238_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_2.prefab_name].transform, "story_v_side_new_1109304", "1109304060", "story_v_side_new_1109304.awb")

						arg_235_1:RecordAudio("1109304060", var_238_7)
						arg_235_1:RecordAudio("1109304060", var_238_7)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304060", "story_v_side_new_1109304.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304060", "story_v_side_new_1109304.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1109304061 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109304061
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109304062(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1093ui_story"]) and arg_239_1.var_.characterEffect1093ui_story == nil then
				arg_239_1.var_.characterEffect1093ui_story = arg_239_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1093ui_story"]) then
				if arg_239_1.var_.characterEffect1093ui_story and not isNil(arg_239_1.actors_["1093ui_story"]) then
					arg_239_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1093ui_story"]) and arg_239_1.var_.characterEffect1093ui_story then
				arg_239_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.425

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(1109304061).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 17 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 17)

				if (17 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 17)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1109304062 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109304062
		arg_243_1.duration_ = 5.6

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109304063(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1093ui_story"]) and arg_243_1.var_.characterEffect1093ui_story == nil then
				arg_243_1.var_.characterEffect1093ui_story = arg_243_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1093ui_story"]) then
				if arg_243_1.var_.characterEffect1093ui_story and not isNil(arg_243_1.actors_["1093ui_story"]) then
					arg_243_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1093ui_story"]) and arg_243_1.var_.characterEffect1093ui_story then
				arg_243_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action437")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_246_2 = 0
			local var_246_3 = 0.325

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(1109304062)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 13 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 13)

				if (13 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 13)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304062", "story_v_side_new_1109304.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304062", "story_v_side_new_1109304.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_side_new_1109304", "1109304062", "story_v_side_new_1109304.awb")

						arg_243_1:RecordAudio("1109304062", var_246_9)
						arg_243_1:RecordAudio("1109304062", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304062", "story_v_side_new_1109304.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304062", "story_v_side_new_1109304.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109304063 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109304063
		arg_247_1.duration_ = 11.47

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1109304064(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action473")
			end

			local var_250_0 = 0
			local var_250_1 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(1109304063)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 44 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 44)

				if (44 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 44)) > 0 and var_250_1 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304063", "story_v_side_new_1109304.awb") ~= 0 then
					local var_250_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304063", "story_v_side_new_1109304.awb") / 1000

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end

					if var_250_2.prefab_name ~= "" and arg_247_1.actors_[var_250_2.prefab_name] ~= nil then
						local var_250_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_2.prefab_name].transform, "story_v_side_new_1109304", "1109304063", "story_v_side_new_1109304.awb")

						arg_247_1:RecordAudio("1109304063", var_250_7)
						arg_247_1:RecordAudio("1109304063", var_250_7)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304063", "story_v_side_new_1109304.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304063", "story_v_side_new_1109304.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1109304064 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109304064
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109304065(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) and arg_251_1.var_.characterEffect1093ui_story == nil then
				arg_251_1.var_.characterEffect1093ui_story = arg_251_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) then
				if arg_251_1.var_.characterEffect1093ui_story and not isNil(arg_251_1.actors_["1093ui_story"]) then
					arg_251_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) and arg_251_1.var_.characterEffect1093ui_story then
				arg_251_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.25

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1109304064).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 10 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 10)

				if (10 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 10)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1109304065 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1109304065
		arg_255_1.duration_ = 7

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1109304066(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				local var_258_0 = arg_255_1.bgs_.STblack

				arg_255_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_258_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_1 = var_258_0:GetComponent("SpriteRenderer")

				if var_258_1 and var_258_1.sprite then
					local var_258_2 = 2 * (var_258_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_258_0.transform.localScale = Vector3.New(var_258_2 / var_258_1.sprite.bounds.size.y < var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x and var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x or var_258_2 / var_258_1.sprite.bounds.size.y, var_258_2 / var_258_1.sprite.bounds.size.y < var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x and var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x or var_258_2 / var_258_1.sprite.bounds.size.y, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "STblack" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_3 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_4 = 2

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_4 then
				local var_258_5 = Color.New(0, 0, 0)

				var_258_5.a = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_3) / var_258_4)
				arg_255_1.mask_.color = var_258_5
			end

			if arg_255_1.time_ >= var_258_3 + var_258_4 and arg_255_1.time_ < var_258_3 + var_258_4 + arg_258_0 then
				local var_258_6 = Color.New(0, 0, 0)

				var_258_6.a = 1
				arg_255_1.mask_.color = var_258_6
			end

			local var_258_7 = 2

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_8 = 2

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 then
				local var_258_9 = Color.New(0, 0, 0)

				var_258_9.a = Mathf.Lerp(1, 0, (arg_255_1.time_ - var_258_7) / var_258_8)
				arg_255_1.mask_.color = var_258_9
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 then
				local var_258_10 = Color.New(0, 0, 0)

				arg_255_1.mask_.enabled = false
				var_258_10.a = 0
				arg_255_1.mask_.color = var_258_10
			end

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				arg_255_1.fswbg_:SetActive(true)
				arg_255_1.dialog_:SetActive(false)

				arg_255_1.fswtw_.percent = 0
				arg_255_1.fswt_.text = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1109304065).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.fswt_)

				arg_255_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_255_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_255_1.fswtw_:SetDirty()

				arg_255_1.typewritterCharCountI18N = 0

				SetActive(arg_255_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_255_1:ShowNextGo(false)
			end

			local var_258_11 = 2.01666666666667

			if 2.01666666666667 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				arg_255_1.var_.oldValueTypewriter = arg_255_1.fswtw_.percent

				SetActive(arg_255_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_255_1:ShowNextGo(false)
			end

			local var_258_12 = 37
			local var_258_13 = 2.46666666666667
			local var_258_14, var_258_15 = arg_255_1:GetPercentByPara(arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1109304065).content), 1)

			if var_258_11 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				local var_258_16 = var_258_12 <= 0 and var_258_13 or var_258_13 * ((var_258_15 - arg_255_1.typewritterCharCountI18N) / var_258_12)

				if (var_258_12 <= 0 and var_258_13 or var_258_13 * ((var_258_15 - arg_255_1.typewritterCharCountI18N) / var_258_12)) > 0 and var_258_13 < var_258_16 then
					arg_255_1.talkMaxDuration = var_258_16

					if var_258_16 + var_258_11 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_16 + var_258_11
					end
				end
			end

			local var_258_17 = math.max(2.46666666666667, arg_255_1.talkMaxDuration)

			if var_258_11 <= arg_255_1.time_ and arg_255_1.time_ < var_258_11 + var_258_17 then
				arg_255_1.fswtw_.percent = Mathf.Lerp(arg_255_1.var_.oldValueTypewriter, var_258_14, (arg_255_1.time_ - var_258_11) / var_258_17)
				arg_255_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_255_1.fswtw_:SetDirty()
			end

			if arg_255_1.time_ >= var_258_11 + var_258_17 and arg_255_1.time_ < var_258_11 + var_258_17 + arg_258_0 then
				arg_255_1.fswtw_.percent = var_258_14

				arg_255_1.fswtw_:SetDirty()
				arg_255_1:ShowNextGo(true)

				arg_255_1.typewritterCharCountI18N = var_258_15
			end

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				local var_258_18 = arg_255_1.fswbg_.transform:Find("textbox/adapt/content") or arg_255_1.fswbg_.transform:Find("textbox/content")
				local var_258_19 = arg_255_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_258_20 = var_258_18:GetComponent("RectTransform")

				var_258_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_258_20.offsetMin = Vector2.New(0, 0)
				var_258_20.offsetMax = Vector2.New(0, 0)
			end

			local var_258_21 = arg_255_1.actors_["1093ui_story"].transform

			if 1.966 < arg_255_1.time_ and arg_255_1.time_ <= 1.966 + arg_258_0 then
				arg_255_1.var_.moveOldPos1093ui_story = var_258_21.localPosition
			end

			local var_258_22 = 0.001

			if 1.966 <= arg_255_1.time_ and arg_255_1.time_ < 1.966 + var_258_22 then
				var_258_21.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 1.966) / var_258_22)
				var_258_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_21.position).x, (manager.ui.mainCamera.transform.position - var_258_21.position).y, (manager.ui.mainCamera.transform.position - var_258_21.position).z)
				var_258_21.localEulerAngles.z = 0
				var_258_21.localEulerAngles.x = 0
				var_258_21.localEulerAngles = var_258_21.localEulerAngles
			end

			if arg_255_1.time_ >= 1.966 + var_258_22 and arg_255_1.time_ < 1.966 + var_258_22 + arg_258_0 then
				var_258_21.localPosition = Vector3.New(0, 100, 0)
				var_258_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_21.position).x, (manager.ui.mainCamera.transform.position - var_258_21.position).y, (manager.ui.mainCamera.transform.position - var_258_21.position).z)
				var_258_21.localEulerAngles.z = 0
				var_258_21.localEulerAngles.x = 0
				var_258_21.localEulerAngles = var_258_21.localEulerAngles
			end

			if 2.01666666666667 < arg_255_1.time_ and arg_255_1.time_ <= 2.01666666666667 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_policesiren_loop", "")
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play1109304066 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1109304066
		arg_259_1.duration_ = 3.4

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1109304067(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.oldValueTypewriter = arg_259_1.fswtw_.percent

				SetActive(arg_259_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_259_1:ShowNextGo(false)
			end

			local var_262_0 = 51
			local var_262_1 = 3.4
			local var_262_2, var_262_3 = arg_259_1:GetPercentByPara(arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1109304065).content), 2)

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				local var_262_4 = var_262_0 <= 0 and var_262_1 or var_262_1 * ((var_262_3 - arg_259_1.typewritterCharCountI18N) / var_262_0)

				if (var_262_0 <= 0 and var_262_1 or var_262_1 * ((var_262_3 - arg_259_1.typewritterCharCountI18N) / var_262_0)) > 0 and var_262_1 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end
			end

			local var_262_5 = math.max(3.4, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 then
				arg_259_1.fswtw_.percent = Mathf.Lerp(arg_259_1.var_.oldValueTypewriter, var_262_2, (arg_259_1.time_ - 0) / var_262_5)
				arg_259_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_259_1.fswtw_:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 then
				arg_259_1.fswtw_.percent = var_262_2

				arg_259_1.fswtw_:SetDirty()
				arg_259_1:ShowNextGo(true)

				arg_259_1.typewritterCharCountI18N = var_262_3
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_police", "")
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1109304067 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109304067
		arg_263_1.duration_ = 7

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109304068(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				local var_266_0 = arg_263_1.bgs_.ST11a

				arg_263_1.bgs_.ST11a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_1 = var_266_0:GetComponent("SpriteRenderer")

				if var_266_1 and var_266_1.sprite then
					local var_266_2 = 2 * (var_266_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_0.transform.localScale = Vector3.New(var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "ST11a" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_3 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_4 = 2

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_4 then
				local var_266_5 = Color.New(0, 0, 0)

				var_266_5.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_3) / var_266_4)
				arg_263_1.mask_.color = var_266_5
			end

			if arg_263_1.time_ >= var_266_3 + var_266_4 and arg_263_1.time_ < var_266_3 + var_266_4 + arg_266_0 then
				local var_266_6 = Color.New(0, 0, 0)

				var_266_6.a = 1
				arg_263_1.mask_.color = var_266_6
			end

			local var_266_7 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_8 = 2

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_8 then
				local var_266_9 = Color.New(0, 0, 0)

				var_266_9.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_7) / var_266_8)
				arg_263_1.mask_.color = var_266_9
			end

			if arg_263_1.time_ >= var_266_7 + var_266_8 and arg_263_1.time_ < var_266_7 + var_266_8 + arg_266_0 then
				local var_266_10 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_10.a = 0
				arg_263_1.mask_.color = var_266_10
			end

			if 1.98333333333333 < arg_263_1.time_ and arg_263_1.time_ <= 1.98333333333333 + arg_266_0 then
				arg_263_1.fswbg_:SetActive(false)
				arg_263_1.dialog_:SetActive(false)
				SetActive(arg_263_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_263_1:ShowNextGo(false)
			end

			local var_266_11 = arg_263_1.actors_["1093ui_story"].transform

			if 3.8 < arg_263_1.time_ and arg_263_1.time_ <= 3.8 + arg_266_0 then
				arg_263_1.var_.moveOldPos1093ui_story = var_266_11.localPosition
			end

			local var_266_12 = 0.001

			if 3.8 <= arg_263_1.time_ and arg_263_1.time_ < 3.8 + var_266_12 then
				var_266_11.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_263_1.time_ - 3.8) / var_266_12)
				var_266_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_11.position).x, (manager.ui.mainCamera.transform.position - var_266_11.position).y, (manager.ui.mainCamera.transform.position - var_266_11.position).z)
				var_266_11.localEulerAngles.z = 0
				var_266_11.localEulerAngles.x = 0
				var_266_11.localEulerAngles = var_266_11.localEulerAngles
			end

			if arg_263_1.time_ >= 3.8 + var_266_12 and arg_263_1.time_ < 3.8 + var_266_12 + arg_266_0 then
				var_266_11.localPosition = Vector3.New(0, -1.11, -5.88)
				var_266_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_11.position).x, (manager.ui.mainCamera.transform.position - var_266_11.position).y, (manager.ui.mainCamera.transform.position - var_266_11.position).z)
				var_266_11.localEulerAngles.z = 0
				var_266_11.localEulerAngles.x = 0
				var_266_11.localEulerAngles = var_266_11.localEulerAngles
			end

			local var_266_13 = arg_263_1.actors_["1093ui_story"]

			if 3.8 < arg_263_1.time_ and arg_263_1.time_ <= 3.8 + arg_266_0 and not isNil(var_266_13) and arg_263_1.var_.characterEffect1093ui_story == nil then
				arg_263_1.var_.characterEffect1093ui_story = var_266_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_14 = 0.2

			if 3.8 <= arg_263_1.time_ and arg_263_1.time_ < 3.8 + var_266_14 and not isNil(var_266_13) then
				if arg_263_1.var_.characterEffect1093ui_story and not isNil(var_266_13) then
					arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 3.8 + var_266_14 and arg_263_1.time_ < 3.8 + var_266_14 + arg_266_0 and not isNil(var_266_13) and arg_263_1.var_.characterEffect1093ui_story then
				arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 3.8 < arg_263_1.time_ and arg_263_1.time_ <= 3.8 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			if 3.8 < arg_263_1.time_ and arg_263_1.time_ <= 3.8 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("stop", "effect", "se_story_side_1093", "se_story_1093_policesiren_loop", "")
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_17 = 4
			local var_266_18 = 0.2

			if 4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_17 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_19 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_19:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_20 = arg_263_1:GetWordFromCfg(1109304067)
				local var_266_21 = arg_263_1:FormatText(var_266_20.content)

				arg_263_1.text_.text = var_266_21

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_23 = 8 <= 0 and var_266_18 or var_266_18 * (utf8.len(var_266_21) / 8)

				if (8 <= 0 and var_266_18 or var_266_18 * (utf8.len(var_266_21) / 8)) > 0 and var_266_18 < var_266_23 then
					arg_263_1.talkMaxDuration = var_266_23
					var_266_17 = var_266_17 + 0.3

					if var_266_23 + var_266_17 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_17
					end
				end

				arg_263_1.text_.text = var_266_21
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304067", "story_v_side_new_1109304.awb") ~= 0 then
					local var_266_24 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304067", "story_v_side_new_1109304.awb") / 1000

					if var_266_24 + var_266_17 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_24 + var_266_17
					end

					if var_266_20.prefab_name ~= "" and arg_263_1.actors_[var_266_20.prefab_name] ~= nil then
						local var_266_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_20.prefab_name].transform, "story_v_side_new_1109304", "1109304067", "story_v_side_new_1109304.awb")

						arg_263_1:RecordAudio("1109304067", var_266_25)
						arg_263_1:RecordAudio("1109304067", var_266_25)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304067", "story_v_side_new_1109304.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304067", "story_v_side_new_1109304.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_26 = var_266_17 + 0.3
			local var_266_27 = math.max(var_266_18, arg_263_1.talkMaxDuration)

			if var_266_17 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_26 + var_266_27 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_26) / var_266_27

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_26 + var_266_27 and arg_263_1.time_ < var_266_26 + var_266_27 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109304068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1109304068
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1109304069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1093ui_story"]) and arg_269_1.var_.characterEffect1093ui_story == nil then
				arg_269_1.var_.characterEffect1093ui_story = arg_269_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1093ui_story"]) then
				if arg_269_1.var_.characterEffect1093ui_story and not isNil(arg_269_1.actors_["1093ui_story"]) then
					arg_269_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1093ui_story"]) and arg_269_1.var_.characterEffect1093ui_story then
				arg_269_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.85

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1109304068).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 34 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 34)

				if (34 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 34)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1109304069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1109304069
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1109304070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1093ui_story = arg_273_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1093ui_story"].transform.position).z)
				arg_273_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1093ui_story"].transform.localEulerAngles = arg_273_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1093ui_story"].transform.position).z)
				arg_273_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1093ui_story"].transform.localEulerAngles = arg_273_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 0.9

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1109304069).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 36 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 36)

				if (36 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 36)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1109304070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1109304070
		arg_277_1.duration_ = 9.37

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1109304071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.2

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[375].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(1109304070)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 50 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 50)

				if (50 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 50)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304070", "story_v_side_new_1109304.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304070", "story_v_side_new_1109304.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_side_new_1109304", "1109304070", "story_v_side_new_1109304.awb")

						arg_277_1:RecordAudio("1109304070", var_280_6)
						arg_277_1:RecordAudio("1109304070", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304070", "story_v_side_new_1109304.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304070", "story_v_side_new_1109304.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1109304071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1109304071
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1109304072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.125

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1109304071).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 5 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 5)

				if (5 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 5)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1109304072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1109304072
		arg_285_1.duration_ = 3.83

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1109304073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.325

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[375].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(1109304072)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 13 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 13)

				if (13 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 13)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304072", "story_v_side_new_1109304.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304072", "story_v_side_new_1109304.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_side_new_1109304", "1109304072", "story_v_side_new_1109304.awb")

						arg_285_1:RecordAudio("1109304072", var_288_6)
						arg_285_1:RecordAudio("1109304072", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304072", "story_v_side_new_1109304.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304072", "story_v_side_new_1109304.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1109304073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109304073
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109304074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.05

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1109304073).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 2 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 2)

				if (2 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 2)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1109304074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1109304074
		arg_293_1.duration_ = 3.03

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1109304075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.2

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[375].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_1 = arg_293_1:GetWordFromCfg(1109304074)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 8 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 8)

				if (8 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 8)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304074", "story_v_side_new_1109304.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304074", "story_v_side_new_1109304.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_side_new_1109304", "1109304074", "story_v_side_new_1109304.awb")

						arg_293_1:RecordAudio("1109304074", var_296_6)
						arg_293_1:RecordAudio("1109304074", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304074", "story_v_side_new_1109304.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304074", "story_v_side_new_1109304.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1109304075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1109304075
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1109304076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.475

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1109304075).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 19 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 19)

				if (19 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 19)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1109304076 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1109304076
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1109304077(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.9

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1109304076).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 36 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 36)

				if (36 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 36)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1109304077 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1109304077
		arg_305_1.duration_ = 1

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1109304078(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.05

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[375].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(1109304077)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 2 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 2)

				if (2 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 2)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304077", "story_v_side_new_1109304.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304077", "story_v_side_new_1109304.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_side_new_1109304", "1109304077", "story_v_side_new_1109304.awb")

						arg_305_1:RecordAudio("1109304077", var_308_6)
						arg_305_1:RecordAudio("1109304077", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304077", "story_v_side_new_1109304.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304077", "story_v_side_new_1109304.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1109304078 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109304078
		arg_309_1.duration_ = 5.87

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109304079(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.4

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[375].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:GetWordFromCfg(1109304078)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 16 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 16)

				if (16 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 16)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304078", "story_v_side_new_1109304.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304078", "story_v_side_new_1109304.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_side_new_1109304", "1109304078", "story_v_side_new_1109304.awb")

						arg_309_1:RecordAudio("1109304078", var_312_6)
						arg_309_1:RecordAudio("1109304078", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304078", "story_v_side_new_1109304.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304078", "story_v_side_new_1109304.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1109304079 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109304079
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109304080(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.875

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(1109304079).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 35 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 35)

				if (35 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 35)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1109304080 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109304080
		arg_317_1.duration_ = 4.93

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109304081(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1093ui_story = arg_317_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1093ui_story"].transform.position).z)
				arg_317_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1093ui_story"].transform.localEulerAngles = arg_317_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_317_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1093ui_story"].transform.position).z)
				arg_317_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1093ui_story"].transform.localEulerAngles = arg_317_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_320_1 = arg_317_1.actors_["1093ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1093ui_story == nil then
				arg_317_1.var_.characterEffect1093ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1093ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1093ui_story then
				arg_317_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_320_4 = 0
			local var_320_5 = 0.475

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(1109304080)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 19 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 19)

				if (19 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 19)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304080", "story_v_side_new_1109304.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304080", "story_v_side_new_1109304.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_side_new_1109304", "1109304080", "story_v_side_new_1109304.awb")

						arg_317_1:RecordAudio("1109304080", var_320_11)
						arg_317_1:RecordAudio("1109304080", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304080", "story_v_side_new_1109304.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304080", "story_v_side_new_1109304.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play1109304081 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109304081
		arg_321_1.duration_ = 0.2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"

			SetActive(arg_321_1.choicesGo_, true)

			for iter_322_0, iter_322_1 in ipairs(arg_321_1.choices_) do
				SetActive(iter_322_1.go, iter_322_0 <= 2)
			end

			arg_321_1.choices_[1].txt.text = arg_321_1:FormatText(StoryChoiceCfg[358].name)
			arg_321_1.choices_[2].txt.text = arg_321_1:FormatText(StoryChoiceCfg[359].name)
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109304082(arg_321_1)
			end

			if arg_323_0 == 2 then
				arg_321_0:Play1109304084(arg_321_1)
			end

			arg_321_1:RecordChoiceLog(1109304081, 358, 359)
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1093ui_story"]) and arg_321_1.var_.characterEffect1093ui_story == nil then
				arg_321_1.var_.characterEffect1093ui_story = arg_321_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1093ui_story"]) then
				if arg_321_1.var_.characterEffect1093ui_story and not isNil(arg_321_1.actors_["1093ui_story"]) then
					arg_321_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1093ui_story"]) and arg_321_1.var_.characterEffect1093ui_story then
				arg_321_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1109304082 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109304082
		arg_325_1.duration_ = 6.8

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1109304083(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1093ui_story"]) and arg_325_1.var_.characterEffect1093ui_story == nil then
				arg_325_1.var_.characterEffect1093ui_story = arg_325_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1093ui_story"]) then
				if arg_325_1.var_.characterEffect1093ui_story and not isNil(arg_325_1.actors_["1093ui_story"]) then
					arg_325_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1093ui_story"]) and arg_325_1.var_.characterEffect1093ui_story then
				arg_325_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action447")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_328_2 = 0
			local var_328_3 = 0.15

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(1109304082)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 6 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 6)

				if (6 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 6)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304082", "story_v_side_new_1109304.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304082", "story_v_side_new_1109304.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_side_new_1109304", "1109304082", "story_v_side_new_1109304.awb")

						arg_325_1:RecordAudio("1109304082", var_328_9)
						arg_325_1:RecordAudio("1109304082", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304082", "story_v_side_new_1109304.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304082", "story_v_side_new_1109304.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1109304083 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109304083
		arg_329_1.duration_ = 4.73

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109304086(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_332_0 = 0
			local var_332_1 = 0.55

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(1109304083)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 22 <= 0 and var_332_1 or var_332_1 * (utf8.len(var_332_3) / 22)

				if (22 <= 0 and var_332_1 or var_332_1 * (utf8.len(var_332_3) / 22)) > 0 and var_332_1 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304083", "story_v_side_new_1109304.awb") ~= 0 then
					local var_332_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304083", "story_v_side_new_1109304.awb") / 1000

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end

					if var_332_2.prefab_name ~= "" and arg_329_1.actors_[var_332_2.prefab_name] ~= nil then
						local var_332_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_2.prefab_name].transform, "story_v_side_new_1109304", "1109304083", "story_v_side_new_1109304.awb")

						arg_329_1:RecordAudio("1109304083", var_332_7)
						arg_329_1:RecordAudio("1109304083", var_332_7)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304083", "story_v_side_new_1109304.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304083", "story_v_side_new_1109304.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1109304086 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109304086
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109304087(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1093ui_story"]) and arg_333_1.var_.characterEffect1093ui_story == nil then
				arg_333_1.var_.characterEffect1093ui_story = arg_333_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1093ui_story"]) then
				if arg_333_1.var_.characterEffect1093ui_story and not isNil(arg_333_1.actors_["1093ui_story"]) then
					arg_333_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1093ui_story"]) and arg_333_1.var_.characterEffect1093ui_story then
				arg_333_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.125

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1109304086).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 5 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 5)

				if (5 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 5)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109304087 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109304087
		arg_337_1.duration_ = 2

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109304088(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1093ui_story"]) and arg_337_1.var_.characterEffect1093ui_story == nil then
				arg_337_1.var_.characterEffect1093ui_story = arg_337_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1093ui_story"]) then
				if arg_337_1.var_.characterEffect1093ui_story and not isNil(arg_337_1.actors_["1093ui_story"]) then
					arg_337_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1093ui_story"]) and arg_337_1.var_.characterEffect1093ui_story then
				arg_337_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action475")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_340_2 = 0
			local var_340_3 = 0.175

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(1109304087)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 7 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 7)

				if (7 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 7)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304087", "story_v_side_new_1109304.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304087", "story_v_side_new_1109304.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_side_new_1109304", "1109304087", "story_v_side_new_1109304.awb")

						arg_337_1:RecordAudio("1109304087", var_340_9)
						arg_337_1:RecordAudio("1109304087", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304087", "story_v_side_new_1109304.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304087", "story_v_side_new_1109304.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1109304088 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109304088
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109304089(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1093ui_story = arg_341_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).z)
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles = arg_341_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1093ui_story"].transform.position).z)
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1093ui_story"].transform.localEulerAngles = arg_341_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_344_1 = 0

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_2 = 2

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = Color.New(1, 1, 1)

				var_344_3.a = Mathf.Lerp(1, 0, (arg_341_1.time_ - var_344_1) / var_344_2)
				arg_341_1.mask_.color = var_344_3
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				local var_344_4 = Color.New(1, 1, 1)

				arg_341_1.mask_.enabled = false
				var_344_4.a = 0
				arg_341_1.mask_.color = var_344_4
			end

			local var_344_5 = 0
			local var_344_6 = 0.725

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_7 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1109304088).content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 29 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_7) / 29)

				if (29 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_7) / 29)) > 0 and var_344_6 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_5
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_6, arg_341_1.talkMaxDuration)

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_5) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_5 + var_344_10 and arg_341_1.time_ < var_344_5 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play1109304089 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109304089
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109304090(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_hit", "")
			end

			local var_348_1 = 0
			local var_348_2 = 0.9

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1109304089).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 36 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 36)

				if (36 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 36)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109304090 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1109304090
		arg_349_1.duration_ = 3.17

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1109304091(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.15

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:GetWordFromCfg(1109304090)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 6 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 6)

				if (6 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 6)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304090", "story_v_side_new_1109304.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304090", "story_v_side_new_1109304.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_side_new_1109304", "1109304090", "story_v_side_new_1109304.awb")

						arg_349_1:RecordAudio("1109304090", var_352_6)
						arg_349_1:RecordAudio("1109304090", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304090", "story_v_side_new_1109304.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304090", "story_v_side_new_1109304.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1109304091 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109304091
		arg_353_1.duration_ = 9

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109304092(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if arg_353_1.bgs_.ST06a == nil then
				local var_356_0 = Object.Instantiate(arg_353_1.paintGo_)

				var_356_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06a")
				var_356_0.name = "ST06a"
				var_356_0.transform.parent = arg_353_1.stage_.transform
				var_356_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.bgs_.ST06a = var_356_0
			end

			if 2 < arg_353_1.time_ and arg_353_1.time_ <= 2 + arg_356_0 then
				local var_356_1 = arg_353_1.bgs_.ST06a

				arg_353_1.bgs_.ST06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_356_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_356_2 = var_356_1:GetComponent("SpriteRenderer")

				if var_356_2 and var_356_2.sprite then
					local var_356_3 = 2 * (var_356_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_356_1.transform.localScale = Vector3.New(var_356_3 / var_356_2.sprite.bounds.size.y < var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x and var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x or var_356_3 / var_356_2.sprite.bounds.size.y, var_356_3 / var_356_2.sprite.bounds.size.y < var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x and var_356_3 * manager.ui.mainCameraCom_.aspect / var_356_2.sprite.bounds.size.x or var_356_3 / var_356_2.sprite.bounds.size.y, 0)
				end

				for iter_356_0, iter_356_1 in pairs(arg_353_1.bgs_) do
					if iter_356_0 ~= "ST06a" then
						iter_356_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_356_4 = 0

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_5 = 2

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_5 then
				local var_356_6 = Color.New(0, 0, 0)

				var_356_6.a = Mathf.Lerp(0, 1, (arg_353_1.time_ - var_356_4) / var_356_5)
				arg_353_1.mask_.color = var_356_6
			end

			if arg_353_1.time_ >= var_356_4 + var_356_5 and arg_353_1.time_ < var_356_4 + var_356_5 + arg_356_0 then
				local var_356_7 = Color.New(0, 0, 0)

				var_356_7.a = 1
				arg_353_1.mask_.color = var_356_7
			end

			local var_356_8 = 2

			if 2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_9 = 2

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_9 then
				local var_356_10 = Color.New(0, 0, 0)

				var_356_10.a = Mathf.Lerp(1, 0, (arg_353_1.time_ - var_356_8) / var_356_9)
				arg_353_1.mask_.color = var_356_10
			end

			if arg_353_1.time_ >= var_356_8 + var_356_9 and arg_353_1.time_ < var_356_8 + var_356_9 + arg_356_0 then
				local var_356_11 = Color.New(0, 0, 0)

				arg_353_1.mask_.enabled = false
				var_356_11.a = 0
				arg_353_1.mask_.color = var_356_11
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_356_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_353_1.bgmTxt_.text ~= var_356_14 and arg_353_1.bgmTxt_.text ~= "" then
						if arg_353_1.bgmTxt2_.text ~= "" then
							arg_353_1.bgmTxt_.text = arg_353_1.bgmTxt2_.text
						end

						arg_353_1.bgmTxt2_.text = var_356_14

						arg_353_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_353_1.bgmTxt_.text = var_356_14
						arg_353_1.bgmTxt2_.text = var_356_14
					end

					if arg_353_1.bgmTimer then
						arg_353_1.bgmTimer:Stop()

						arg_353_1.bgmTimer = nil
					end

					if arg_353_1.settingData.show_music_name == 1 then
						arg_353_1.musicController:SetSelectedState("show")
						arg_353_1.musicAnimator_:Play("open", 0, 0)

						if arg_353_1.settingData.music_time ~= 0 then
							arg_353_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_353_1.settingData.music_time), function()
								if arg_353_1 == nil or isNil(arg_353_1.bgmTxt_) then
									return
								end

								arg_353_1.musicController:SetSelectedState("hide")
								arg_353_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_15 = 4
			local var_356_16 = 0.05

			if 4 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_17 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_17:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_353_1.dialogCg_.alpha = arg_358_0
				end))
				var_356_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_18 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1109304091).content)

				arg_353_1.text_.text = var_356_18

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_20 = 2 <= 0 and var_356_16 or var_356_16 * (utf8.len(var_356_18) / 2)

				if (2 <= 0 and var_356_16 or var_356_16 * (utf8.len(var_356_18) / 2)) > 0 and var_356_16 < var_356_20 then
					arg_353_1.talkMaxDuration = var_356_20
					var_356_15 = var_356_15 + 0.3

					if var_356_20 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_20 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_18
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_21 = var_356_15 + 0.3
			local var_356_22 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 + 0.3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_21 + var_356_22 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_21) / var_356_22

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_21 + var_356_22 and arg_353_1.time_ < var_356_21 + var_356_22 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1109304092 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1109304092
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1109304093(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_363_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_360_1.bgmTxt_.text ~= var_363_2 and arg_360_1.bgmTxt_.text ~= "" then
						if arg_360_1.bgmTxt2_.text ~= "" then
							arg_360_1.bgmTxt_.text = arg_360_1.bgmTxt2_.text
						end

						arg_360_1.bgmTxt2_.text = var_363_2

						arg_360_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_360_1.bgmTxt_.text = var_363_2
						arg_360_1.bgmTxt2_.text = var_363_2
					end

					if arg_360_1.bgmTimer then
						arg_360_1.bgmTimer:Stop()

						arg_360_1.bgmTimer = nil
					end

					if arg_360_1.settingData.show_music_name == 1 then
						arg_360_1.musicController:SetSelectedState("show")
						arg_360_1.musicAnimator_:Play("open", 0, 0)

						if arg_360_1.settingData.music_time ~= 0 then
							arg_360_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_360_1.settingData.music_time), function()
								if arg_360_1 == nil or isNil(arg_360_1.bgmTxt_) then
									return
								end

								arg_360_1.musicController:SetSelectedState("hide")
								arg_360_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_360_1.time_ and arg_360_1.time_ <= 0.233333333333333 + arg_363_0 then
				arg_360_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_363_5 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_360_1.bgmTxt_.text ~= var_363_5 and arg_360_1.bgmTxt_.text ~= "" then
						if arg_360_1.bgmTxt2_.text ~= "" then
							arg_360_1.bgmTxt_.text = arg_360_1.bgmTxt2_.text
						end

						arg_360_1.bgmTxt2_.text = var_363_5

						arg_360_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_360_1.bgmTxt_.text = var_363_5
						arg_360_1.bgmTxt2_.text = var_363_5
					end

					if arg_360_1.bgmTimer then
						arg_360_1.bgmTimer:Stop()

						arg_360_1.bgmTimer = nil
					end

					if arg_360_1.settingData.show_music_name == 1 then
						arg_360_1.musicController:SetSelectedState("show")
						arg_360_1.musicAnimator_:Play("open", 0, 0)

						if arg_360_1.settingData.music_time ~= 0 then
							arg_360_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_360_1.settingData.music_time), function()
								if arg_360_1 == nil or isNil(arg_360_1.bgmTxt_) then
									return
								end

								arg_360_1.musicController:SetSelectedState("hide")
								arg_360_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_363_6 = 0
			local var_363_7 = 0.125

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_8 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(1109304092).content)

				arg_360_1.text_.text = var_363_8

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_10 = 5 <= 0 and var_363_7 or var_363_7 * (utf8.len(var_363_8) / 5)

				if (5 <= 0 and var_363_7 or var_363_7 * (utf8.len(var_363_8) / 5)) > 0 and var_363_7 < var_363_10 then
					arg_360_1.talkMaxDuration = var_363_10

					if var_363_10 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_8
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_11 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_11 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_11

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_11 and arg_360_1.time_ < var_363_6 + var_363_11 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1109304093 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1109304093
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1109304094(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.175

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1109304093).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 7 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 7)

				if (7 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 7)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1109304094 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1109304094
		arg_370_1.duration_ = 6.2

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1109304095(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1093ui_story = arg_370_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_373_0 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 then
				arg_370_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_370_1.time_ - 0) / var_373_0)
				arg_370_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1093ui_story"].transform.position).z)
				arg_370_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1093ui_story"].transform.localEulerAngles = arg_370_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 then
				arg_370_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_370_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1093ui_story"].transform.position).z)
				arg_370_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1093ui_story"].transform.localEulerAngles = arg_370_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_373_1 = arg_370_1.actors_["1093ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1093ui_story == nil then
				arg_370_1.var_.characterEffect1093ui_story = var_373_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_2 and not isNil(var_373_1) then
				if arg_370_1.var_.characterEffect1093ui_story and not isNil(var_373_1) then
					arg_370_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_2 and arg_370_1.time_ < 0 + var_373_2 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1093ui_story then
				arg_370_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_373_4 = 0
			local var_373_5 = 0.5

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_6 = arg_370_1:GetWordFromCfg(1109304094)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 20 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 20)

				if (20 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 20)) > 0 and var_373_5 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304094", "story_v_side_new_1109304.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304094", "story_v_side_new_1109304.awb") / 1000

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end

					if var_373_6.prefab_name ~= "" and arg_370_1.actors_[var_373_6.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_6.prefab_name].transform, "story_v_side_new_1109304", "1109304094", "story_v_side_new_1109304.awb")

						arg_370_1:RecordAudio("1109304094", var_373_11)
						arg_370_1:RecordAudio("1109304094", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304094", "story_v_side_new_1109304.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304094", "story_v_side_new_1109304.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_12 and arg_370_1.time_ < var_373_4 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play1109304095 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1109304095
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1109304096(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1093ui_story"]) and arg_374_1.var_.characterEffect1093ui_story == nil then
				arg_374_1.var_.characterEffect1093ui_story = arg_374_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1093ui_story"]) then
				if arg_374_1.var_.characterEffect1093ui_story and not isNil(arg_374_1.actors_["1093ui_story"]) then
					arg_374_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_0)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1093ui_story"]) and arg_374_1.var_.characterEffect1093ui_story then
				arg_374_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_377_1 = 0
			local var_377_2 = 0.225

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(1109304095).content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 9 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_3) / 9)

				if (9 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_3) / 9)) > 0 and var_377_2 < var_377_5 then
					arg_374_1.talkMaxDuration = var_377_5

					if var_377_5 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + var_377_1
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_6 = math.max(var_377_2, arg_374_1.talkMaxDuration)

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_6 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_1) / var_377_6

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_1 + var_377_6 and arg_374_1.time_ < var_377_1 + var_377_6 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1109304096 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1109304096
		arg_378_1.duration_ = 3.9

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1109304097(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1093ui_story"]) and arg_378_1.var_.characterEffect1093ui_story == nil then
				arg_378_1.var_.characterEffect1093ui_story = arg_378_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1093ui_story"]) then
				if arg_378_1.var_.characterEffect1093ui_story and not isNil(arg_378_1.actors_["1093ui_story"]) then
					arg_378_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1093ui_story"]) and arg_378_1.var_.characterEffect1093ui_story then
				arg_378_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action467")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_381_2 = 0
			local var_381_3 = 0.4

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:GetWordFromCfg(1109304096)
				local var_381_5 = arg_378_1:FormatText(var_381_4.content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 16 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 16)

				if (16 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 16)) > 0 and var_381_3 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304096", "story_v_side_new_1109304.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304096", "story_v_side_new_1109304.awb") / 1000

					if var_381_8 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_2
					end

					if var_381_4.prefab_name ~= "" and arg_378_1.actors_[var_381_4.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_4.prefab_name].transform, "story_v_side_new_1109304", "1109304096", "story_v_side_new_1109304.awb")

						arg_378_1:RecordAudio("1109304096", var_381_9)
						arg_378_1:RecordAudio("1109304096", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304096", "story_v_side_new_1109304.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304096", "story_v_side_new_1109304.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_10 and arg_378_1.time_ < var_381_2 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1109304097 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1109304097
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1109304098(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1093ui_story"]) and arg_382_1.var_.characterEffect1093ui_story == nil then
				arg_382_1.var_.characterEffect1093ui_story = arg_382_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1093ui_story"]) then
				if arg_382_1.var_.characterEffect1093ui_story and not isNil(arg_382_1.actors_["1093ui_story"]) then
					arg_382_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1093ui_story"]) and arg_382_1.var_.characterEffect1093ui_story then
				arg_382_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.475

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1109304097).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 19 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 19)

				if (19 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 19)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1109304098 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1109304098
		arg_386_1.duration_ = 3.13

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1109304099(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1093ui_story"]) and arg_386_1.var_.characterEffect1093ui_story == nil then
				arg_386_1.var_.characterEffect1093ui_story = arg_386_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.2

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1093ui_story"]) then
				if arg_386_1.var_.characterEffect1093ui_story and not isNil(arg_386_1.actors_["1093ui_story"]) then
					arg_386_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1093ui_story"]) and arg_386_1.var_.characterEffect1093ui_story then
				arg_386_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_389_2 = 0
			local var_389_3 = 0.225

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_4 = arg_386_1:GetWordFromCfg(1109304098)
				local var_389_5 = arg_386_1:FormatText(var_389_4.content)

				arg_386_1.text_.text = var_389_5

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_7 = 9 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 9)

				if (9 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 9)) > 0 and var_389_3 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_5
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304098", "story_v_side_new_1109304.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304098", "story_v_side_new_1109304.awb") / 1000

					if var_389_8 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_2
					end

					if var_389_4.prefab_name ~= "" and arg_386_1.actors_[var_389_4.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_4.prefab_name].transform, "story_v_side_new_1109304", "1109304098", "story_v_side_new_1109304.awb")

						arg_386_1:RecordAudio("1109304098", var_389_9)
						arg_386_1:RecordAudio("1109304098", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304098", "story_v_side_new_1109304.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304098", "story_v_side_new_1109304.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_10 and arg_386_1.time_ < var_389_2 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1109304099 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1109304099
		arg_390_1.duration_ = 6.23

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1109304100(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action474")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_393_0 = 0
			local var_393_1 = 0.35

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(1109304099)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 14 <= 0 and var_393_1 or var_393_1 * (utf8.len(var_393_3) / 14)

				if (14 <= 0 and var_393_1 or var_393_1 * (utf8.len(var_393_3) / 14)) > 0 and var_393_1 < var_393_5 then
					arg_390_1.talkMaxDuration = var_393_5

					if var_393_5 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304099", "story_v_side_new_1109304.awb") ~= 0 then
					local var_393_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304099", "story_v_side_new_1109304.awb") / 1000

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end

					if var_393_2.prefab_name ~= "" and arg_390_1.actors_[var_393_2.prefab_name] ~= nil then
						local var_393_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_2.prefab_name].transform, "story_v_side_new_1109304", "1109304099", "story_v_side_new_1109304.awb")

						arg_390_1:RecordAudio("1109304099", var_393_7)
						arg_390_1:RecordAudio("1109304099", var_393_7)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304099", "story_v_side_new_1109304.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304099", "story_v_side_new_1109304.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_8 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_8 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_8

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_8 and arg_390_1.time_ < var_393_0 + var_393_8 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1109304100 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1109304100
		arg_394_1.duration_ = 0.2

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"

			SetActive(arg_394_1.choicesGo_, true)

			for iter_395_0, iter_395_1 in ipairs(arg_394_1.choices_) do
				SetActive(iter_395_1.go, iter_395_0 <= 2)
			end

			arg_394_1.choices_[1].txt.text = arg_394_1:FormatText(StoryChoiceCfg[360].name)
			arg_394_1.choices_[2].txt.text = arg_394_1:FormatText(StoryChoiceCfg[361].name)
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1109304101(arg_394_1)
			end

			if arg_396_0 == 2 then
				arg_394_0:Play1109304103(arg_394_1)
			end

			arg_394_1:RecordChoiceLog(1109304100, 360, 361)
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1093ui_story"]) and arg_394_1.var_.characterEffect1093ui_story == nil then
				arg_394_1.var_.characterEffect1093ui_story = arg_394_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1093ui_story"]) then
				if arg_394_1.var_.characterEffect1093ui_story and not isNil(arg_394_1.actors_["1093ui_story"]) then
					arg_394_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1093ui_story"]) and arg_394_1.var_.characterEffect1093ui_story then
				arg_394_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1109304101 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1109304101
		arg_398_1.duration_ = 4.6

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1109304102(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1093ui_story"]) and arg_398_1.var_.characterEffect1093ui_story == nil then
				arg_398_1.var_.characterEffect1093ui_story = arg_398_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1093ui_story"]) then
				if arg_398_1.var_.characterEffect1093ui_story and not isNil(arg_398_1.actors_["1093ui_story"]) then
					arg_398_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1093ui_story"]) and arg_398_1.var_.characterEffect1093ui_story then
				arg_398_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_401_2 = 0
			local var_401_3 = 0.35

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_4 = arg_398_1:GetWordFromCfg(1109304101)
				local var_401_5 = arg_398_1:FormatText(var_401_4.content)

				arg_398_1.text_.text = var_401_5

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 14 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 14)

				if (14 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 14)) > 0 and var_401_3 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_5
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304101", "story_v_side_new_1109304.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304101", "story_v_side_new_1109304.awb") / 1000

					if var_401_8 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_2
					end

					if var_401_4.prefab_name ~= "" and arg_398_1.actors_[var_401_4.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_4.prefab_name].transform, "story_v_side_new_1109304", "1109304101", "story_v_side_new_1109304.awb")

						arg_398_1:RecordAudio("1109304101", var_401_9)
						arg_398_1:RecordAudio("1109304101", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304101", "story_v_side_new_1109304.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304101", "story_v_side_new_1109304.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_10 and arg_398_1.time_ < var_401_2 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1109304102 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1109304102
		arg_402_1.duration_ = 8.83

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1109304105(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_405_0 = 0
			local var_405_1 = 0.775

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_2 = arg_402_1:GetWordFromCfg(1109304102)
				local var_405_3 = arg_402_1:FormatText(var_405_2.content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 31 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_3) / 31)

				if (31 <= 0 and var_405_1 or var_405_1 * (utf8.len(var_405_3) / 31)) > 0 and var_405_1 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304102", "story_v_side_new_1109304.awb") ~= 0 then
					local var_405_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304102", "story_v_side_new_1109304.awb") / 1000

					if var_405_6 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_0
					end

					if var_405_2.prefab_name ~= "" and arg_402_1.actors_[var_405_2.prefab_name] ~= nil then
						local var_405_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_2.prefab_name].transform, "story_v_side_new_1109304", "1109304102", "story_v_side_new_1109304.awb")

						arg_402_1:RecordAudio("1109304102", var_405_7)
						arg_402_1:RecordAudio("1109304102", var_405_7)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304102", "story_v_side_new_1109304.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304102", "story_v_side_new_1109304.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1109304105 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1109304105
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1109304106(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1093ui_story"]) and arg_406_1.var_.characterEffect1093ui_story == nil then
				arg_406_1.var_.characterEffect1093ui_story = arg_406_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1093ui_story"]) then
				if arg_406_1.var_.characterEffect1093ui_story and not isNil(arg_406_1.actors_["1093ui_story"]) then
					arg_406_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_0)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1093ui_story"]) and arg_406_1.var_.characterEffect1093ui_story then
				arg_406_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_409_1 = 0
			local var_409_2 = 0.55

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(1109304105).content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 22 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 22)

				if (22 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 22)) > 0 and var_409_2 < var_409_5 then
					arg_406_1.talkMaxDuration = var_409_5

					if var_409_5 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + var_409_1
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_6 = math.max(var_409_2, arg_406_1.talkMaxDuration)

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_6 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_1) / var_409_6

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_1 + var_409_6 and arg_406_1.time_ < var_409_1 + var_409_6 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1109304106 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1109304106
		arg_410_1.duration_ = 10.47

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1109304107(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1093ui_story"]) and arg_410_1.var_.characterEffect1093ui_story == nil then
				arg_410_1.var_.characterEffect1093ui_story = arg_410_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1093ui_story"]) then
				if arg_410_1.var_.characterEffect1093ui_story and not isNil(arg_410_1.actors_["1093ui_story"]) then
					arg_410_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1093ui_story"]) and arg_410_1.var_.characterEffect1093ui_story then
				arg_410_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_413_2 = 0
			local var_413_3 = 0.725

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_2 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(1109304106)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_7 = 29 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 29)

				if (29 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 29)) > 0 and var_413_3 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_2
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304106", "story_v_side_new_1109304.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304106", "story_v_side_new_1109304.awb") / 1000

					if var_413_8 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_2
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_side_new_1109304", "1109304106", "story_v_side_new_1109304.awb")

						arg_410_1:RecordAudio("1109304106", var_413_9)
						arg_410_1:RecordAudio("1109304106", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304106", "story_v_side_new_1109304.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304106", "story_v_side_new_1109304.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_3, arg_410_1.talkMaxDuration)

			if var_413_2 <= arg_410_1.time_ and arg_410_1.time_ < var_413_2 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_2) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_2 + var_413_10 and arg_410_1.time_ < var_413_2 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1109304107 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1109304107
		arg_414_1.duration_ = 12.37

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1109304108(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action467")
			end

			local var_417_0 = 0
			local var_417_1 = 0.725

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_2 = arg_414_1:GetWordFromCfg(1109304107)
				local var_417_3 = arg_414_1:FormatText(var_417_2.content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 29 <= 0 and var_417_1 or var_417_1 * (utf8.len(var_417_3) / 29)

				if (29 <= 0 and var_417_1 or var_417_1 * (utf8.len(var_417_3) / 29)) > 0 and var_417_1 < var_417_5 then
					arg_414_1.talkMaxDuration = var_417_5

					if var_417_5 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_3
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304107", "story_v_side_new_1109304.awb") ~= 0 then
					local var_417_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304107", "story_v_side_new_1109304.awb") / 1000

					if var_417_6 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_0
					end

					if var_417_2.prefab_name ~= "" and arg_414_1.actors_[var_417_2.prefab_name] ~= nil then
						local var_417_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_2.prefab_name].transform, "story_v_side_new_1109304", "1109304107", "story_v_side_new_1109304.awb")

						arg_414_1:RecordAudio("1109304107", var_417_7)
						arg_414_1:RecordAudio("1109304107", var_417_7)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304107", "story_v_side_new_1109304.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304107", "story_v_side_new_1109304.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1109304108 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1109304108
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1109304109(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1093ui_story"]) and arg_418_1.var_.characterEffect1093ui_story == nil then
				arg_418_1.var_.characterEffect1093ui_story = arg_418_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1093ui_story"]) then
				if arg_418_1.var_.characterEffect1093ui_story and not isNil(arg_418_1.actors_["1093ui_story"]) then
					arg_418_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1093ui_story"]) and arg_418_1.var_.characterEffect1093ui_story then
				arg_418_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_421_1 = 0
			local var_421_2 = 0.275

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(1109304108).content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 11 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 11)

				if (11 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 11)) > 0 and var_421_2 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_6 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_6 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_6

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_6 and arg_418_1.time_ < var_421_1 + var_421_6 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1109304109 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1109304109
		arg_422_1.duration_ = 12.47

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1109304110(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1093ui_story"]) and arg_422_1.var_.characterEffect1093ui_story == nil then
				arg_422_1.var_.characterEffect1093ui_story = arg_422_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1093ui_story"]) then
				if arg_422_1.var_.characterEffect1093ui_story and not isNil(arg_422_1.actors_["1093ui_story"]) then
					arg_422_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1093ui_story"]) and arg_422_1.var_.characterEffect1093ui_story then
				arg_422_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action478")
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_425_2 = 0
			local var_425_3 = 1.05

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_4 = arg_422_1:GetWordFromCfg(1109304109)
				local var_425_5 = arg_422_1:FormatText(var_425_4.content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_7 = 42 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 42)

				if (42 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 42)) > 0 and var_425_3 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_2
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304109", "story_v_side_new_1109304.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304109", "story_v_side_new_1109304.awb") / 1000

					if var_425_8 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_2
					end

					if var_425_4.prefab_name ~= "" and arg_422_1.actors_[var_425_4.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_4.prefab_name].transform, "story_v_side_new_1109304", "1109304109", "story_v_side_new_1109304.awb")

						arg_422_1:RecordAudio("1109304109", var_425_9)
						arg_422_1:RecordAudio("1109304109", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304109", "story_v_side_new_1109304.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304109", "story_v_side_new_1109304.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_3, arg_422_1.talkMaxDuration)

			if var_425_2 <= arg_422_1.time_ and arg_422_1.time_ < var_425_2 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_2) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_2 + var_425_10 and arg_422_1.time_ < var_425_2 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1109304110 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1109304110
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1109304111(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1093ui_story"]) and arg_426_1.var_.characterEffect1093ui_story == nil then
				arg_426_1.var_.characterEffect1093ui_story = arg_426_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1093ui_story"]) then
				if arg_426_1.var_.characterEffect1093ui_story and not isNil(arg_426_1.actors_["1093ui_story"]) then
					arg_426_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_0)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1093ui_story"]) and arg_426_1.var_.characterEffect1093ui_story then
				arg_426_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_429_1 = 0
			local var_429_2 = 0.525

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1109304110).content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 21 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 21)

				if (21 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 21)) > 0 and var_429_2 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_1 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_1
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_6 = math.max(var_429_2, arg_426_1.talkMaxDuration)

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_6 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_1) / var_429_6

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_1 + var_429_6 and arg_426_1.time_ < var_429_1 + var_429_6 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1109304111 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1109304111
		arg_430_1.duration_ = 3.13

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1109304112(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1093ui_story"]) and arg_430_1.var_.characterEffect1093ui_story == nil then
				arg_430_1.var_.characterEffect1093ui_story = arg_430_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1093ui_story"]) then
				if arg_430_1.var_.characterEffect1093ui_story and not isNil(arg_430_1.actors_["1093ui_story"]) then
					arg_430_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1093ui_story"]) and arg_430_1.var_.characterEffect1093ui_story then
				arg_430_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action487")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_433_2 = 0
			local var_433_3 = 0.2

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_2 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_4 = arg_430_1:GetWordFromCfg(1109304111)
				local var_433_5 = arg_430_1:FormatText(var_433_4.content)

				arg_430_1.text_.text = var_433_5

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_7 = 8 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 8)

				if (8 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 8)) > 0 and var_433_3 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_2
					end
				end

				arg_430_1.text_.text = var_433_5
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304111", "story_v_side_new_1109304.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304111", "story_v_side_new_1109304.awb") / 1000

					if var_433_8 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_2
					end

					if var_433_4.prefab_name ~= "" and arg_430_1.actors_[var_433_4.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_4.prefab_name].transform, "story_v_side_new_1109304", "1109304111", "story_v_side_new_1109304.awb")

						arg_430_1:RecordAudio("1109304111", var_433_9)
						arg_430_1:RecordAudio("1109304111", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304111", "story_v_side_new_1109304.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304111", "story_v_side_new_1109304.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_3, arg_430_1.talkMaxDuration)

			if var_433_2 <= arg_430_1.time_ and arg_430_1.time_ < var_433_2 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_2) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_2 + var_433_10 and arg_430_1.time_ < var_433_2 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1109304112 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1109304112
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1109304113(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1093ui_story"]) and arg_434_1.var_.characterEffect1093ui_story == nil then
				arg_434_1.var_.characterEffect1093ui_story = arg_434_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1093ui_story"]) then
				if arg_434_1.var_.characterEffect1093ui_story and not isNil(arg_434_1.actors_["1093ui_story"]) then
					arg_434_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1093ui_story"]) and arg_434_1.var_.characterEffect1093ui_story then
				arg_434_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_437_1 = 0
			local var_437_2 = 0.65

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(1109304112).content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 26 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 26)

				if (26 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 26)) > 0 and var_437_2 < var_437_5 then
					arg_434_1.talkMaxDuration = var_437_5

					if var_437_5 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_6 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_6 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_6

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_6 and arg_434_1.time_ < var_437_1 + var_437_6 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1109304113 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1109304113
		arg_438_1.duration_ = 8.4

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1109304114(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1093ui_story"]) and arg_438_1.var_.characterEffect1093ui_story == nil then
				arg_438_1.var_.characterEffect1093ui_story = arg_438_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1093ui_story"]) then
				if arg_438_1.var_.characterEffect1093ui_story and not isNil(arg_438_1.actors_["1093ui_story"]) then
					arg_438_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1093ui_story"]) and arg_438_1.var_.characterEffect1093ui_story then
				arg_438_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action476")
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_441_2 = 0
			local var_441_3 = 0.95

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_4 = arg_438_1:GetWordFromCfg(1109304113)
				local var_441_5 = arg_438_1:FormatText(var_441_4.content)

				arg_438_1.text_.text = var_441_5

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_7 = 38 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 38)

				if (38 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 38)) > 0 and var_441_3 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_2
					end
				end

				arg_438_1.text_.text = var_441_5
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304113", "story_v_side_new_1109304.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304113", "story_v_side_new_1109304.awb") / 1000

					if var_441_8 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_2
					end

					if var_441_4.prefab_name ~= "" and arg_438_1.actors_[var_441_4.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_4.prefab_name].transform, "story_v_side_new_1109304", "1109304113", "story_v_side_new_1109304.awb")

						arg_438_1:RecordAudio("1109304113", var_441_9)
						arg_438_1:RecordAudio("1109304113", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304113", "story_v_side_new_1109304.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304113", "story_v_side_new_1109304.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_3, arg_438_1.talkMaxDuration)

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_2) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_2 + var_441_10 and arg_438_1.time_ < var_441_2 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1109304114 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1109304114
		arg_442_1.duration_ = 7.23

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1109304115(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_445_0 = 0
			local var_445_1 = 0.8

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_2 = arg_442_1:GetWordFromCfg(1109304114)
				local var_445_3 = arg_442_1:FormatText(var_445_2.content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 32 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 32)

				if (32 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 32)) > 0 and var_445_1 < var_445_5 then
					arg_442_1.talkMaxDuration = var_445_5

					if var_445_5 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304114", "story_v_side_new_1109304.awb") ~= 0 then
					local var_445_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304114", "story_v_side_new_1109304.awb") / 1000

					if var_445_6 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_0
					end

					if var_445_2.prefab_name ~= "" and arg_442_1.actors_[var_445_2.prefab_name] ~= nil then
						local var_445_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_2.prefab_name].transform, "story_v_side_new_1109304", "1109304114", "story_v_side_new_1109304.awb")

						arg_442_1:RecordAudio("1109304114", var_445_7)
						arg_442_1:RecordAudio("1109304114", var_445_7)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304114", "story_v_side_new_1109304.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304114", "story_v_side_new_1109304.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1109304115 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1109304115
		arg_446_1.duration_ = 3.73

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1109304116(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_449_0 = 0
			local var_449_1 = 0.55

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(1109304115)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 22 <= 0 and var_449_1 or var_449_1 * (utf8.len(var_449_3) / 22)

				if (22 <= 0 and var_449_1 or var_449_1 * (utf8.len(var_449_3) / 22)) > 0 and var_449_1 < var_449_5 then
					arg_446_1.talkMaxDuration = var_449_5

					if var_449_5 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304115", "story_v_side_new_1109304.awb") ~= 0 then
					local var_449_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304115", "story_v_side_new_1109304.awb") / 1000

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end

					if var_449_2.prefab_name ~= "" and arg_446_1.actors_[var_449_2.prefab_name] ~= nil then
						local var_449_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_2.prefab_name].transform, "story_v_side_new_1109304", "1109304115", "story_v_side_new_1109304.awb")

						arg_446_1:RecordAudio("1109304115", var_449_7)
						arg_446_1:RecordAudio("1109304115", var_449_7)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304115", "story_v_side_new_1109304.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304115", "story_v_side_new_1109304.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_8 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_8 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_8

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_8 and arg_446_1.time_ < var_449_0 + var_449_8 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1109304116 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1109304116
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1109304117(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1093ui_story"]) and arg_450_1.var_.characterEffect1093ui_story == nil then
				arg_450_1.var_.characterEffect1093ui_story = arg_450_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1093ui_story"]) then
				if arg_450_1.var_.characterEffect1093ui_story and not isNil(arg_450_1.actors_["1093ui_story"]) then
					arg_450_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_0)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1093ui_story"]) and arg_450_1.var_.characterEffect1093ui_story then
				arg_450_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_453_1 = 0
			local var_453_2 = 0.375

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(1109304116).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 15 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 15)

				if (15 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 15)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1109304117 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1109304117
		arg_454_1.duration_ = 8.8

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1109304118(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1093ui_story"]) and arg_454_1.var_.characterEffect1093ui_story == nil then
				arg_454_1.var_.characterEffect1093ui_story = arg_454_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1093ui_story"]) then
				if arg_454_1.var_.characterEffect1093ui_story and not isNil(arg_454_1.actors_["1093ui_story"]) then
					arg_454_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1093ui_story"]) and arg_454_1.var_.characterEffect1093ui_story then
				arg_454_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_457_2 = 0
			local var_457_3 = 0.75

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_4 = arg_454_1:GetWordFromCfg(1109304117)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 30 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 30)

				if (30 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 30)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304117", "story_v_side_new_1109304.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304117", "story_v_side_new_1109304.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_side_new_1109304", "1109304117", "story_v_side_new_1109304.awb")

						arg_454_1:RecordAudio("1109304117", var_457_9)
						arg_454_1:RecordAudio("1109304117", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304117", "story_v_side_new_1109304.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304117", "story_v_side_new_1109304.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1109304118 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1109304118
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1109304119(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1093ui_story"]) and arg_458_1.var_.characterEffect1093ui_story == nil then
				arg_458_1.var_.characterEffect1093ui_story = arg_458_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.2

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1093ui_story"]) then
				if arg_458_1.var_.characterEffect1093ui_story and not isNil(arg_458_1.actors_["1093ui_story"]) then
					arg_458_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1093ui_story"]) and arg_458_1.var_.characterEffect1093ui_story then
				arg_458_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.55

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(1109304118).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 22 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 22)

				if (22 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 22)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1109304119 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1109304119
		arg_462_1.duration_ = 1.27

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1109304120(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1093ui_story"]) and arg_462_1.var_.characterEffect1093ui_story == nil then
				arg_462_1.var_.characterEffect1093ui_story = arg_462_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.2

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1093ui_story"]) then
				if arg_462_1.var_.characterEffect1093ui_story and not isNil(arg_462_1.actors_["1093ui_story"]) then
					arg_462_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1093ui_story"]) and arg_462_1.var_.characterEffect1093ui_story then
				arg_462_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_465_2 = 0
			local var_465_3 = 0.05

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(1109304119)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_7 = 2 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 2)

				if (2 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 2)) > 0 and var_465_3 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304119", "story_v_side_new_1109304.awb") ~= 0 then
					local var_465_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304119", "story_v_side_new_1109304.awb") / 1000

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_side_new_1109304", "1109304119", "story_v_side_new_1109304.awb")

						arg_462_1:RecordAudio("1109304119", var_465_9)
						arg_462_1:RecordAudio("1109304119", var_465_9)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304119", "story_v_side_new_1109304.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304119", "story_v_side_new_1109304.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_10 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_10 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_10

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_10 and arg_462_1.time_ < var_465_2 + var_465_10 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1109304120 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1109304120
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1109304121(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1093ui_story"]) and arg_466_1.var_.characterEffect1093ui_story == nil then
				arg_466_1.var_.characterEffect1093ui_story = arg_466_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.2

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1093ui_story"]) then
				if arg_466_1.var_.characterEffect1093ui_story and not isNil(arg_466_1.actors_["1093ui_story"]) then
					arg_466_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1093ui_story"]) and arg_466_1.var_.characterEffect1093ui_story then
				arg_466_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 0.65

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(1109304120).content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 26 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 26)

				if (26 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 26)) > 0 and var_469_2 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_6 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_6 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_6

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_6 and arg_466_1.time_ < var_469_1 + var_469_6 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1109304121 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1109304121
		arg_470_1.duration_ = 3.77

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1109304122(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["1093ui_story"]) and arg_470_1.var_.characterEffect1093ui_story == nil then
				arg_470_1.var_.characterEffect1093ui_story = arg_470_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_0 = 0.2

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["1093ui_story"]) then
				if arg_470_1.var_.characterEffect1093ui_story and not isNil(arg_470_1.actors_["1093ui_story"]) then
					arg_470_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["1093ui_story"]) and arg_470_1.var_.characterEffect1093ui_story then
				arg_470_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action464")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_473_2 = 0
			local var_473_3 = 0.25

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_2 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_4 = arg_470_1:GetWordFromCfg(1109304121)
				local var_473_5 = arg_470_1:FormatText(var_473_4.content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 10 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_5) / 10)

				if (10 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_5) / 10)) > 0 and var_473_3 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_2
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304121", "story_v_side_new_1109304.awb") ~= 0 then
					local var_473_8 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304121", "story_v_side_new_1109304.awb") / 1000

					if var_473_8 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_2
					end

					if var_473_4.prefab_name ~= "" and arg_470_1.actors_[var_473_4.prefab_name] ~= nil then
						local var_473_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_4.prefab_name].transform, "story_v_side_new_1109304", "1109304121", "story_v_side_new_1109304.awb")

						arg_470_1:RecordAudio("1109304121", var_473_9)
						arg_470_1:RecordAudio("1109304121", var_473_9)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304121", "story_v_side_new_1109304.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304121", "story_v_side_new_1109304.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_10 = math.max(var_473_3, arg_470_1.talkMaxDuration)

			if var_473_2 <= arg_470_1.time_ and arg_470_1.time_ < var_473_2 + var_473_10 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_2) / var_473_10

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_2 + var_473_10 and arg_470_1.time_ < var_473_2 + var_473_10 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1109304122 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1109304122
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1109304123(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["1093ui_story"]) and arg_474_1.var_.characterEffect1093ui_story == nil then
				arg_474_1.var_.characterEffect1093ui_story = arg_474_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_0 = 0.2

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["1093ui_story"]) then
				if arg_474_1.var_.characterEffect1093ui_story and not isNil(arg_474_1.actors_["1093ui_story"]) then
					arg_474_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_474_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_0)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["1093ui_story"]) and arg_474_1.var_.characterEffect1093ui_story then
				arg_474_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_474_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_477_1 = arg_474_1.actors_["1093ui_story"].transform

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1093ui_story = var_477_1.localPosition
			end

			local var_477_2 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_2 then
				var_477_1.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_474_1.time_ - 0) / var_477_2)
				var_477_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_1.position).x, (manager.ui.mainCamera.transform.position - var_477_1.position).y, (manager.ui.mainCamera.transform.position - var_477_1.position).z)
				var_477_1.localEulerAngles.z = 0
				var_477_1.localEulerAngles.x = 0
				var_477_1.localEulerAngles = var_477_1.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_2 and arg_474_1.time_ < 0 + var_477_2 + arg_477_0 then
				var_477_1.localPosition = Vector3.New(0, 100, 0)
				var_477_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_1.position).x, (manager.ui.mainCamera.transform.position - var_477_1.position).y, (manager.ui.mainCamera.transform.position - var_477_1.position).z)
				var_477_1.localEulerAngles.z = 0
				var_477_1.localEulerAngles.x = 0
				var_477_1.localEulerAngles = var_477_1.localEulerAngles
			end

			local var_477_3 = 0
			local var_477_4 = 0.725

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_3 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_5 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(1109304122).content)

				arg_474_1.text_.text = var_477_5

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_7 = 29 <= 0 and var_477_4 or var_477_4 * (utf8.len(var_477_5) / 29)

				if (29 <= 0 and var_477_4 or var_477_4 * (utf8.len(var_477_5) / 29)) > 0 and var_477_4 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_3 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_3
					end
				end

				arg_474_1.text_.text = var_477_5
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_8 = math.max(var_477_4, arg_474_1.talkMaxDuration)

			if var_477_3 <= arg_474_1.time_ and arg_474_1.time_ < var_477_3 + var_477_8 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_3) / var_477_8

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_3 + var_477_8 and arg_474_1.time_ < var_477_3 + var_477_8 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play1109304123 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1109304123
		arg_478_1.duration_ = 7.4

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1109304124(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if arg_478_1.bgs_.R9301 == nil then
				local var_481_0 = Object.Instantiate(arg_478_1.paintGo_)

				var_481_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R9301")
				var_481_0.name = "R9301"
				var_481_0.transform.parent = arg_478_1.stage_.transform
				var_481_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_478_1.bgs_.R9301 = var_481_0
			end

			if 2 < arg_478_1.time_ and arg_478_1.time_ <= 2 + arg_481_0 then
				local var_481_1 = arg_478_1.bgs_.R9301

				arg_478_1.bgs_.R9301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_481_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_481_2 = var_481_1:GetComponent("SpriteRenderer")

				if var_481_2 and var_481_2.sprite then
					local var_481_3 = 2 * (var_481_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_481_1.transform.localScale = Vector3.New(var_481_3 / var_481_2.sprite.bounds.size.y < var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x and var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x or var_481_3 / var_481_2.sprite.bounds.size.y, var_481_3 / var_481_2.sprite.bounds.size.y < var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x and var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x or var_481_3 / var_481_2.sprite.bounds.size.y, 0)
				end

				for iter_481_0, iter_481_1 in pairs(arg_478_1.bgs_) do
					if iter_481_0 ~= "R9301" then
						iter_481_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_481_4 = 0

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1.mask_.enabled = true
				arg_478_1.mask_.raycastTarget = true

				arg_478_1:SetGaussion(false)
			end

			local var_481_5 = 2

			if var_481_4 <= arg_478_1.time_ and arg_478_1.time_ < var_481_4 + var_481_5 then
				local var_481_6 = Color.New(0, 0, 0)

				var_481_6.a = Mathf.Lerp(0, 1, (arg_478_1.time_ - var_481_4) / var_481_5)
				arg_478_1.mask_.color = var_481_6
			end

			if arg_478_1.time_ >= var_481_4 + var_481_5 and arg_478_1.time_ < var_481_4 + var_481_5 + arg_481_0 then
				local var_481_7 = Color.New(0, 0, 0)

				var_481_7.a = 1
				arg_478_1.mask_.color = var_481_7
			end

			local var_481_8 = 2

			if 2 < arg_478_1.time_ and arg_478_1.time_ <= var_481_8 + arg_481_0 then
				arg_478_1.mask_.enabled = true
				arg_478_1.mask_.raycastTarget = true

				arg_478_1:SetGaussion(false)
			end

			local var_481_9 = 2

			if var_481_8 <= arg_478_1.time_ and arg_478_1.time_ < var_481_8 + var_481_9 then
				local var_481_10 = Color.New(0, 0, 0)

				var_481_10.a = Mathf.Lerp(1, 0, (arg_478_1.time_ - var_481_8) / var_481_9)
				arg_478_1.mask_.color = var_481_10
			end

			if arg_478_1.time_ >= var_481_8 + var_481_9 and arg_478_1.time_ < var_481_8 + var_481_9 + arg_481_0 then
				local var_481_11 = Color.New(0, 0, 0)

				arg_478_1.mask_.enabled = false
				var_481_11.a = 0
				arg_478_1.mask_.color = var_481_11
			end

			local var_481_12 = arg_478_1.bgs_.R9301.transform

			if 2 < arg_478_1.time_ and arg_478_1.time_ <= 2 + arg_481_0 then
				arg_478_1.var_.moveOldPosR9301 = var_481_12.localPosition
			end

			local var_481_13 = 0.001

			if 2 <= arg_478_1.time_ and arg_478_1.time_ < 2 + var_481_13 then
				var_481_12.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPosR9301, Vector3.New(7, -2.58, -4.15), (arg_478_1.time_ - 2) / var_481_13)
			end

			if arg_478_1.time_ >= 2 + var_481_13 and arg_478_1.time_ < 2 + var_481_13 + arg_481_0 then
				var_481_12.localPosition = Vector3.New(7, -2.58, -4.15)
			end

			local var_481_14 = arg_478_1.bgs_.R9301.transform

			if 2.01666666666667 < arg_478_1.time_ and arg_478_1.time_ <= 2.01666666666667 + arg_481_0 then
				arg_478_1.var_.moveOldPosR9301 = var_481_14.localPosition
			end

			local var_481_15 = 4

			if 2.01666666666667 <= arg_478_1.time_ and arg_478_1.time_ < 2.01666666666667 + var_481_15 then
				var_481_14.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPosR9301, Vector3.New(6.3, -2.58, -4.15), (arg_478_1.time_ - 2.01666666666667) / var_481_15)
			end

			if arg_478_1.time_ >= 2.01666666666667 + var_481_15 and arg_478_1.time_ < 2.01666666666667 + var_481_15 + arg_481_0 then
				var_481_14.localPosition = Vector3.New(6.3, -2.58, -4.15)
			end

			if arg_478_1.frameCnt_ <= 1 then
				arg_478_1.dialog_:SetActive(false)
			end

			local var_481_16 = 2.01666666666667
			local var_481_17 = 0.925

			if 2.01666666666667 < arg_478_1.time_ and arg_478_1.time_ <= var_481_16 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0

				arg_478_1.dialog_:SetActive(true)

				arg_478_1.dialogCg_.alpha = 0

				local var_481_18 = LeanTween.value(arg_478_1.dialog_, 0, 1, 0.3)

				var_481_18:setOnUpdate(LuaHelper.FloatAction(function(arg_482_0)
					arg_478_1.dialogCg_.alpha = arg_482_0
				end))
				var_481_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_478_1.dialog_)
					var_481_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_478_1.duration_ = arg_478_1.duration_ + 0.3

				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_19 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(1109304123).content)

				arg_478_1.text_.text = var_481_19

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_21 = 37 <= 0 and var_481_17 or var_481_17 * (utf8.len(var_481_19) / 37)

				if (37 <= 0 and var_481_17 or var_481_17 * (utf8.len(var_481_19) / 37)) > 0 and var_481_17 < var_481_21 then
					arg_478_1.talkMaxDuration = var_481_21
					var_481_16 = var_481_16 + 0.3

					if var_481_21 + var_481_16 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_21 + var_481_16
					end
				end

				arg_478_1.text_.text = var_481_19
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_22 = var_481_16 + 0.3
			local var_481_23 = math.max(var_481_17, arg_478_1.talkMaxDuration)

			if var_481_16 + 0.3 <= arg_478_1.time_ and arg_478_1.time_ < var_481_22 + var_481_23 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_22) / var_481_23

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_22 + var_481_23 and arg_478_1.time_ < var_481_22 + var_481_23 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play1109304124 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1109304124
		arg_484_1.duration_ = 5.73

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1109304125(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.6

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:GetWordFromCfg(1109304124)
				local var_487_2 = arg_484_1:FormatText(var_487_1.content)

				arg_484_1.text_.text = var_487_2

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_4 = 24 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 24)

				if (24 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 24)) > 0 and var_487_0 < var_487_4 then
					arg_484_1.talkMaxDuration = var_487_4

					if var_487_4 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_4 + 0
					end
				end

				arg_484_1.text_.text = var_487_2
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304124", "story_v_side_new_1109304.awb") ~= 0 then
					local var_487_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304124", "story_v_side_new_1109304.awb") / 1000

					if var_487_5 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + 0
					end

					if var_487_1.prefab_name ~= "" and arg_484_1.actors_[var_487_1.prefab_name] ~= nil then
						local var_487_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_1.prefab_name].transform, "story_v_side_new_1109304", "1109304124", "story_v_side_new_1109304.awb")

						arg_484_1:RecordAudio("1109304124", var_487_6)
						arg_484_1:RecordAudio("1109304124", var_487_6)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304124", "story_v_side_new_1109304.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304124", "story_v_side_new_1109304.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_7 and arg_484_1.time_ < 0 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1109304125 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1109304125
		arg_488_1.duration_ = 10.5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1109304126(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_0 = 2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				local var_491_1 = Color.New(0, 0, 0)

				var_491_1.a = Mathf.Lerp(0, 1, (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.mask_.color = var_491_1
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				local var_491_2 = Color.New(0, 0, 0)

				var_491_2.a = 1
				arg_488_1.mask_.color = var_491_2
			end

			local var_491_3 = 2

			if 2 < arg_488_1.time_ and arg_488_1.time_ <= var_491_3 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_4 = 2

			if var_491_3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_3 + var_491_4 then
				local var_491_5 = Color.New(0, 0, 0)

				var_491_5.a = Mathf.Lerp(1, 0, (arg_488_1.time_ - var_491_3) / var_491_4)
				arg_488_1.mask_.color = var_491_5
			end

			if arg_488_1.time_ >= var_491_3 + var_491_4 and arg_488_1.time_ < var_491_3 + var_491_4 + arg_491_0 then
				local var_491_6 = Color.New(0, 0, 0)

				arg_488_1.mask_.enabled = false
				var_491_6.a = 0
				arg_488_1.mask_.color = var_491_6
			end

			local var_491_7 = arg_488_1.bgs_.R9301.transform

			if 2 < arg_488_1.time_ and arg_488_1.time_ <= 2 + arg_491_0 then
				arg_488_1.var_.moveOldPosR9301 = var_491_7.localPosition
			end

			local var_491_8 = 0.001

			if 2 <= arg_488_1.time_ and arg_488_1.time_ < 2 + var_491_8 then
				var_491_7.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPosR9301, Vector3.New(0, -0.53, -1.07), (arg_488_1.time_ - 2) / var_491_8)
			end

			if arg_488_1.time_ >= 2 + var_491_8 and arg_488_1.time_ < 2 + var_491_8 + arg_491_0 then
				var_491_7.localPosition = Vector3.New(0, -0.53, -1.07)
			end

			local var_491_9 = arg_488_1.bgs_.R9301.transform

			if 2.01666666666667 < arg_488_1.time_ and arg_488_1.time_ <= 2.01666666666667 + arg_491_0 then
				arg_488_1.var_.moveOldPosR9301 = var_491_9.localPosition
			end

			local var_491_10 = 4

			if 2.01666666666667 <= arg_488_1.time_ and arg_488_1.time_ < 2.01666666666667 + var_491_10 then
				var_491_9.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPosR9301, Vector3.New(-0.73, -0.53, -1.07), (arg_488_1.time_ - 2.01666666666667) / var_491_10)
			end

			if arg_488_1.time_ >= 2.01666666666667 + var_491_10 and arg_488_1.time_ < 2.01666666666667 + var_491_10 + arg_491_0 then
				var_491_9.localPosition = Vector3.New(-0.73, -0.53, -1.07)
			end

			if arg_488_1.frameCnt_ <= 1 then
				arg_488_1.dialog_:SetActive(false)
			end

			local var_491_11 = 4
			local var_491_12 = 0.6

			if 4 < arg_488_1.time_ and arg_488_1.time_ <= var_491_11 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0

				arg_488_1.dialog_:SetActive(true)

				arg_488_1.dialogCg_.alpha = 0

				local var_491_13 = LeanTween.value(arg_488_1.dialog_, 0, 1, 0.3)

				var_491_13:setOnUpdate(LuaHelper.FloatAction(function(arg_492_0)
					arg_488_1.dialogCg_.alpha = arg_492_0
				end))
				var_491_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_488_1.dialog_)
					var_491_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_488_1.duration_ = arg_488_1.duration_ + 0.3

				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_14 = arg_488_1:GetWordFromCfg(1109304125)
				local var_491_15 = arg_488_1:FormatText(var_491_14.content)

				arg_488_1.text_.text = var_491_15

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_17 = 24 <= 0 and var_491_12 or var_491_12 * (utf8.len(var_491_15) / 24)

				if (24 <= 0 and var_491_12 or var_491_12 * (utf8.len(var_491_15) / 24)) > 0 and var_491_12 < var_491_17 then
					arg_488_1.talkMaxDuration = var_491_17
					var_491_11 = var_491_11 + 0.3

					if var_491_17 + var_491_11 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_17 + var_491_11
					end
				end

				arg_488_1.text_.text = var_491_15
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304125", "story_v_side_new_1109304.awb") ~= 0 then
					local var_491_18 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304125", "story_v_side_new_1109304.awb") / 1000

					if var_491_18 + var_491_11 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_18 + var_491_11
					end

					if var_491_14.prefab_name ~= "" and arg_488_1.actors_[var_491_14.prefab_name] ~= nil then
						local var_491_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_14.prefab_name].transform, "story_v_side_new_1109304", "1109304125", "story_v_side_new_1109304.awb")

						arg_488_1:RecordAudio("1109304125", var_491_19)
						arg_488_1:RecordAudio("1109304125", var_491_19)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304125", "story_v_side_new_1109304.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304125", "story_v_side_new_1109304.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_20 = var_491_11 + 0.3
			local var_491_21 = math.max(var_491_12, arg_488_1.talkMaxDuration)

			if var_491_11 + 0.3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_20 + var_491_21 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_20) / var_491_21

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_20 + var_491_21 and arg_488_1.time_ < var_491_20 + var_491_21 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play1109304126 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1109304126
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1109304127(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.2

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_1 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(1109304126).content)

				arg_494_1.text_.text = var_497_1

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_3 = 8 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 8)

				if (8 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 8)) > 0 and var_497_0 < var_497_3 then
					arg_494_1.talkMaxDuration = var_497_3

					if var_497_3 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_3 + 0
					end
				end

				arg_494_1.text_.text = var_497_1
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_4 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_4

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1109304127 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1109304127
		arg_498_1.duration_ = 3.67

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1109304128(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.35

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_1 = arg_498_1:GetWordFromCfg(1109304127)
				local var_501_2 = arg_498_1:FormatText(var_501_1.content)

				arg_498_1.text_.text = var_501_2

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_4 = 14 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 14)

				if (14 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 14)) > 0 and var_501_0 < var_501_4 then
					arg_498_1.talkMaxDuration = var_501_4

					if var_501_4 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_4 + 0
					end
				end

				arg_498_1.text_.text = var_501_2
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304127", "story_v_side_new_1109304.awb") ~= 0 then
					local var_501_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304127", "story_v_side_new_1109304.awb") / 1000

					if var_501_5 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + 0
					end

					if var_501_1.prefab_name ~= "" and arg_498_1.actors_[var_501_1.prefab_name] ~= nil then
						local var_501_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_1.prefab_name].transform, "story_v_side_new_1109304", "1109304127", "story_v_side_new_1109304.awb")

						arg_498_1:RecordAudio("1109304127", var_501_6)
						arg_498_1:RecordAudio("1109304127", var_501_6)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304127", "story_v_side_new_1109304.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304127", "story_v_side_new_1109304.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_7 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_7 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_7

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_7 and arg_498_1.time_ < 0 + var_501_7 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1109304128 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1109304128
		arg_502_1.duration_ = 11.73

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1109304129(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.mask_.enabled = true
				arg_502_1.mask_.raycastTarget = true

				arg_502_1:SetGaussion(false)
			end

			local var_505_0 = 2

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 then
				local var_505_1 = Color.New(0, 0, 0)

				var_505_1.a = Mathf.Lerp(0, 1, (arg_502_1.time_ - 0) / var_505_0)
				arg_502_1.mask_.color = var_505_1
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 then
				local var_505_2 = Color.New(0, 0, 0)

				var_505_2.a = 1
				arg_502_1.mask_.color = var_505_2
			end

			local var_505_3 = 2

			if 2 < arg_502_1.time_ and arg_502_1.time_ <= var_505_3 + arg_505_0 then
				arg_502_1.mask_.enabled = true
				arg_502_1.mask_.raycastTarget = true

				arg_502_1:SetGaussion(false)
			end

			local var_505_4 = 2

			if var_505_3 <= arg_502_1.time_ and arg_502_1.time_ < var_505_3 + var_505_4 then
				local var_505_5 = Color.New(0, 0, 0)

				var_505_5.a = Mathf.Lerp(1, 0, (arg_502_1.time_ - var_505_3) / var_505_4)
				arg_502_1.mask_.color = var_505_5
			end

			if arg_502_1.time_ >= var_505_3 + var_505_4 and arg_502_1.time_ < var_505_3 + var_505_4 + arg_505_0 then
				local var_505_6 = Color.New(0, 0, 0)

				arg_502_1.mask_.enabled = false
				var_505_6.a = 0
				arg_502_1.mask_.color = var_505_6
			end

			local var_505_7 = arg_502_1.bgs_.R9301.transform

			if 2 < arg_502_1.time_ and arg_502_1.time_ <= 2 + arg_505_0 then
				arg_502_1.var_.moveOldPosR9301 = var_505_7.localPosition
			end

			local var_505_8 = 0.001

			if 2 <= arg_502_1.time_ and arg_502_1.time_ < 2 + var_505_8 then
				var_505_7.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPosR9301, Vector3.New(5.15, 2.84, 1.05), (arg_502_1.time_ - 2) / var_505_8)
			end

			if arg_502_1.time_ >= 2 + var_505_8 and arg_502_1.time_ < 2 + var_505_8 + arg_505_0 then
				var_505_7.localPosition = Vector3.New(5.15, 2.84, 1.05)
			end

			local var_505_9 = arg_502_1.bgs_.R9301.transform

			if 2.01666666666667 < arg_502_1.time_ and arg_502_1.time_ <= 2.01666666666667 + arg_505_0 then
				arg_502_1.var_.moveOldPosR9301 = var_505_9.localPosition
			end

			local var_505_10 = 4

			if 2.01666666666667 <= arg_502_1.time_ and arg_502_1.time_ < 2.01666666666667 + var_505_10 then
				var_505_9.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPosR9301, Vector3.New(4.5, 2.84, 1.05), (arg_502_1.time_ - 2.01666666666667) / var_505_10)
			end

			if arg_502_1.time_ >= 2.01666666666667 + var_505_10 and arg_502_1.time_ < 2.01666666666667 + var_505_10 + arg_505_0 then
				var_505_9.localPosition = Vector3.New(4.5, 2.84, 1.05)
			end

			local var_505_11 = 4
			local var_505_12 = 0.4

			if 4 < arg_502_1.time_ and arg_502_1.time_ <= var_505_11 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_13 = arg_502_1:GetWordFromCfg(1109304128)
				local var_505_14 = arg_502_1:FormatText(var_505_13.content)

				arg_502_1.text_.text = var_505_14

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_16 = 16 <= 0 and var_505_12 or var_505_12 * (utf8.len(var_505_14) / 16)

				if (16 <= 0 and var_505_12 or var_505_12 * (utf8.len(var_505_14) / 16)) > 0 and var_505_12 < var_505_16 then
					arg_502_1.talkMaxDuration = var_505_16

					if var_505_16 + var_505_11 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_16 + var_505_11
					end
				end

				arg_502_1.text_.text = var_505_14
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304128", "story_v_side_new_1109304.awb") ~= 0 then
					local var_505_17 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304128", "story_v_side_new_1109304.awb") / 1000

					if var_505_17 + var_505_11 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_17 + var_505_11
					end

					if var_505_13.prefab_name ~= "" and arg_502_1.actors_[var_505_13.prefab_name] ~= nil then
						local var_505_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_13.prefab_name].transform, "story_v_side_new_1109304", "1109304128", "story_v_side_new_1109304.awb")

						arg_502_1:RecordAudio("1109304128", var_505_18)
						arg_502_1:RecordAudio("1109304128", var_505_18)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304128", "story_v_side_new_1109304.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304128", "story_v_side_new_1109304.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_19 = math.max(var_505_12, arg_502_1.talkMaxDuration)

			if var_505_11 <= arg_502_1.time_ and arg_502_1.time_ < var_505_11 + var_505_19 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_11) / var_505_19

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_11 + var_505_19 and arg_502_1.time_ < var_505_11 + var_505_19 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play1109304129 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1109304129
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1109304130(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.75

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(1109304129).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 30 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 30)

				if (30 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 30)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1109304130 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1109304130
		arg_510_1.duration_ = 8.5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1109304131(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.mask_.enabled = true
				arg_510_1.mask_.raycastTarget = true

				arg_510_1:SetGaussion(false)
			end

			local var_513_0 = 2

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				local var_513_1 = Color.New(0, 0, 0)

				var_513_1.a = Mathf.Lerp(0, 1, (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.mask_.color = var_513_1
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				local var_513_2 = Color.New(0, 0, 0)

				var_513_2.a = 1
				arg_510_1.mask_.color = var_513_2
			end

			local var_513_3 = 2

			if 2 < arg_510_1.time_ and arg_510_1.time_ <= var_513_3 + arg_513_0 then
				arg_510_1.mask_.enabled = true
				arg_510_1.mask_.raycastTarget = true

				arg_510_1:SetGaussion(false)
			end

			local var_513_4 = 2

			if var_513_3 <= arg_510_1.time_ and arg_510_1.time_ < var_513_3 + var_513_4 then
				local var_513_5 = Color.New(0, 0, 0)

				var_513_5.a = Mathf.Lerp(1, 0, (arg_510_1.time_ - var_513_3) / var_513_4)
				arg_510_1.mask_.color = var_513_5
			end

			if arg_510_1.time_ >= var_513_3 + var_513_4 and arg_510_1.time_ < var_513_3 + var_513_4 + arg_513_0 then
				local var_513_6 = Color.New(0, 0, 0)

				arg_510_1.mask_.enabled = false
				var_513_6.a = 0
				arg_510_1.mask_.color = var_513_6
			end

			local var_513_7 = arg_510_1.bgs_.R9301.transform

			if 2 < arg_510_1.time_ and arg_510_1.time_ <= 2 + arg_513_0 then
				arg_510_1.var_.moveOldPosR9301 = var_513_7.localPosition
			end

			local var_513_8 = 0.001

			if 2 <= arg_510_1.time_ and arg_510_1.time_ < 2 + var_513_8 then
				var_513_7.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPosR9301, Vector3.New(0, 1, 10), (arg_510_1.time_ - 2) / var_513_8)
			end

			if arg_510_1.time_ >= 2 + var_513_8 and arg_510_1.time_ < 2 + var_513_8 + arg_513_0 then
				var_513_7.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_510_1.frameCnt_ <= 1 then
				arg_510_1.dialog_:SetActive(false)
			end

			local var_513_9 = 4
			local var_513_10 = 0.275

			if 4 < arg_510_1.time_ and arg_510_1.time_ <= var_513_9 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0

				arg_510_1.dialog_:SetActive(true)

				arg_510_1.dialogCg_.alpha = 0

				local var_513_11 = LeanTween.value(arg_510_1.dialog_, 0, 1, 0.3)

				var_513_11:setOnUpdate(LuaHelper.FloatAction(function(arg_514_0)
					arg_510_1.dialogCg_.alpha = arg_514_0
				end))
				var_513_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_510_1.dialog_)
					var_513_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_510_1.duration_ = arg_510_1.duration_ + 0.3

				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_12 = arg_510_1:GetWordFromCfg(1109304130)
				local var_513_13 = arg_510_1:FormatText(var_513_12.content)

				arg_510_1.text_.text = var_513_13

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_15 = 11 <= 0 and var_513_10 or var_513_10 * (utf8.len(var_513_13) / 11)

				if (11 <= 0 and var_513_10 or var_513_10 * (utf8.len(var_513_13) / 11)) > 0 and var_513_10 < var_513_15 then
					arg_510_1.talkMaxDuration = var_513_15
					var_513_9 = var_513_9 + 0.3

					if var_513_15 + var_513_9 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_15 + var_513_9
					end
				end

				arg_510_1.text_.text = var_513_13
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304130", "story_v_side_new_1109304.awb") ~= 0 then
					local var_513_16 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304130", "story_v_side_new_1109304.awb") / 1000

					if var_513_16 + var_513_9 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_16 + var_513_9
					end

					if var_513_12.prefab_name ~= "" and arg_510_1.actors_[var_513_12.prefab_name] ~= nil then
						local var_513_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_12.prefab_name].transform, "story_v_side_new_1109304", "1109304130", "story_v_side_new_1109304.awb")

						arg_510_1:RecordAudio("1109304130", var_513_17)
						arg_510_1:RecordAudio("1109304130", var_513_17)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304130", "story_v_side_new_1109304.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304130", "story_v_side_new_1109304.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_18 = var_513_9 + 0.3
			local var_513_19 = math.max(var_513_10, arg_510_1.talkMaxDuration)

			if var_513_9 + 0.3 <= arg_510_1.time_ and arg_510_1.time_ < var_513_18 + var_513_19 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_18) / var_513_19

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_18 + var_513_19 and arg_510_1.time_ < var_513_18 + var_513_19 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play1109304131 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1109304131
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1109304132(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0.05

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_1 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(1109304131).content)

				arg_516_1.text_.text = var_519_1

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_3 = 2 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_1) / 2)

				if (2 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_1) / 2)) > 0 and var_519_0 < var_519_3 then
					arg_516_1.talkMaxDuration = var_519_3

					if var_519_3 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_3 + 0
					end
				end

				arg_516_1.text_.text = var_519_1
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_4 = math.max(var_519_0, arg_516_1.talkMaxDuration)

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_4 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - 0) / var_519_4

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= 0 + var_519_4 and arg_516_1.time_ < 0 + var_519_4 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1109304132 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1109304132
		arg_520_1.duration_ = 3.53

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1109304133(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.3

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_1 = arg_520_1:GetWordFromCfg(1109304132)
				local var_523_2 = arg_520_1:FormatText(var_523_1.content)

				arg_520_1.text_.text = var_523_2

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_4 = 12 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 12)

				if (12 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 12)) > 0 and var_523_0 < var_523_4 then
					arg_520_1.talkMaxDuration = var_523_4

					if var_523_4 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_4 + 0
					end
				end

				arg_520_1.text_.text = var_523_2
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304132", "story_v_side_new_1109304.awb") ~= 0 then
					local var_523_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304132", "story_v_side_new_1109304.awb") / 1000

					if var_523_5 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_5 + 0
					end

					if var_523_1.prefab_name ~= "" and arg_520_1.actors_[var_523_1.prefab_name] ~= nil then
						local var_523_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_1.prefab_name].transform, "story_v_side_new_1109304", "1109304132", "story_v_side_new_1109304.awb")

						arg_520_1:RecordAudio("1109304132", var_523_6)
						arg_520_1:RecordAudio("1109304132", var_523_6)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304132", "story_v_side_new_1109304.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304132", "story_v_side_new_1109304.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_7 and arg_520_1.time_ < 0 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1109304133 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1109304133
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1109304134(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.225

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_1 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(1109304133).content)

				arg_524_1.text_.text = var_527_1

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_3 = 9 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 9)

				if (9 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 9)) > 0 and var_527_0 < var_527_3 then
					arg_524_1.talkMaxDuration = var_527_3

					if var_527_3 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_3 + 0
					end
				end

				arg_524_1.text_.text = var_527_1
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_4 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_4

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play1109304134 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1109304134
		arg_528_1.duration_ = 2.27

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1109304135(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.2

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:GetWordFromCfg(1109304134)
				local var_531_2 = arg_528_1:FormatText(var_531_1.content)

				arg_528_1.text_.text = var_531_2

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 8 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 8)

				if (8 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 8)) > 0 and var_531_0 < var_531_4 then
					arg_528_1.talkMaxDuration = var_531_4

					if var_531_4 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_4 + 0
					end
				end

				arg_528_1.text_.text = var_531_2
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304134", "story_v_side_new_1109304.awb") ~= 0 then
					local var_531_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304134", "story_v_side_new_1109304.awb") / 1000

					if var_531_5 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_5 + 0
					end

					if var_531_1.prefab_name ~= "" and arg_528_1.actors_[var_531_1.prefab_name] ~= nil then
						local var_531_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_1.prefab_name].transform, "story_v_side_new_1109304", "1109304134", "story_v_side_new_1109304.awb")

						arg_528_1:RecordAudio("1109304134", var_531_6)
						arg_528_1:RecordAudio("1109304134", var_531_6)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304134", "story_v_side_new_1109304.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304134", "story_v_side_new_1109304.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_7 and arg_528_1.time_ < 0 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1109304135 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1109304135
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1109304136(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.4

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1109304135).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 16 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 16)

				if (16 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 16)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1109304136 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1109304136
		arg_536_1.duration_ = 4.1

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1109304137(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 2 < arg_536_1.time_ and arg_536_1.time_ <= 2 + arg_539_0 then
				arg_536_1.mask_.enabled = true
				arg_536_1.mask_.raycastTarget = true

				arg_536_1:SetGaussion(false)
			end

			local var_539_0 = 2

			if 2 <= arg_536_1.time_ and arg_536_1.time_ < 2 + var_539_0 then
				local var_539_1 = Color.New(0, 0, 0)

				var_539_1.a = Mathf.Lerp(1, 0, (arg_536_1.time_ - 2) / var_539_0)
				arg_536_1.mask_.color = var_539_1
			end

			if arg_536_1.time_ >= 2 + var_539_0 and arg_536_1.time_ < 2 + var_539_0 + arg_539_0 then
				local var_539_2 = Color.New(0, 0, 0)

				arg_536_1.mask_.enabled = false
				var_539_2.a = 0
				arg_536_1.mask_.color = var_539_2
			end

			local var_539_3 = 0
			local var_539_4 = 0.225

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_3 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_5 = arg_536_1:GetWordFromCfg(1109304136)
				local var_539_6 = arg_536_1:FormatText(var_539_5.content)

				arg_536_1.text_.text = var_539_6

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_8 = 9 <= 0 and var_539_4 or var_539_4 * (utf8.len(var_539_6) / 9)

				if (9 <= 0 and var_539_4 or var_539_4 * (utf8.len(var_539_6) / 9)) > 0 and var_539_4 < var_539_8 then
					arg_536_1.talkMaxDuration = var_539_8

					if var_539_8 + var_539_3 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_3
					end
				end

				arg_536_1.text_.text = var_539_6
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304136", "story_v_side_new_1109304.awb") ~= 0 then
					local var_539_9 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304136", "story_v_side_new_1109304.awb") / 1000

					if var_539_9 + var_539_3 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_9 + var_539_3
					end

					if var_539_5.prefab_name ~= "" and arg_536_1.actors_[var_539_5.prefab_name] ~= nil then
						local var_539_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_5.prefab_name].transform, "story_v_side_new_1109304", "1109304136", "story_v_side_new_1109304.awb")

						arg_536_1:RecordAudio("1109304136", var_539_10)
						arg_536_1:RecordAudio("1109304136", var_539_10)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304136", "story_v_side_new_1109304.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304136", "story_v_side_new_1109304.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_11 = math.max(var_539_4, arg_536_1.talkMaxDuration)

			if var_539_3 <= arg_536_1.time_ and arg_536_1.time_ < var_539_3 + var_539_11 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_3) / var_539_11

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_3 + var_539_11 and arg_536_1.time_ < var_539_3 + var_539_11 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1109304137 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1109304137
		arg_540_1.duration_ = 4.7

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1109304138(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.725

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_1 = arg_540_1:GetWordFromCfg(1109304137)
				local var_543_2 = arg_540_1:FormatText(var_543_1.content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 29 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 29)

				if (29 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 29)) > 0 and var_543_0 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + 0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304137", "story_v_side_new_1109304.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304137", "story_v_side_new_1109304.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_side_new_1109304", "1109304137", "story_v_side_new_1109304.awb")

						arg_540_1:RecordAudio("1109304137", var_543_6)
						arg_540_1:RecordAudio("1109304137", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304137", "story_v_side_new_1109304.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304137", "story_v_side_new_1109304.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_7 and arg_540_1.time_ < 0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1109304138 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1109304138
		arg_544_1.duration_ = 7.07

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1109304139(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.575

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_1 = arg_544_1:GetWordFromCfg(1109304138)
				local var_547_2 = arg_544_1:FormatText(var_547_1.content)

				arg_544_1.text_.text = var_547_2

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 23 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 23)

				if (23 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 23)) > 0 and var_547_0 < var_547_4 then
					arg_544_1.talkMaxDuration = var_547_4

					if var_547_4 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_4 + 0
					end
				end

				arg_544_1.text_.text = var_547_2
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304138", "story_v_side_new_1109304.awb") ~= 0 then
					local var_547_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304138", "story_v_side_new_1109304.awb") / 1000

					if var_547_5 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + 0
					end

					if var_547_1.prefab_name ~= "" and arg_544_1.actors_[var_547_1.prefab_name] ~= nil then
						local var_547_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_1.prefab_name].transform, "story_v_side_new_1109304", "1109304138", "story_v_side_new_1109304.awb")

						arg_544_1:RecordAudio("1109304138", var_547_6)
						arg_544_1:RecordAudio("1109304138", var_547_6)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304138", "story_v_side_new_1109304.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304138", "story_v_side_new_1109304.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_7 and arg_544_1.time_ < 0 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1109304139 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1109304139
		arg_548_1.duration_ = 5.3

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1109304140(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.55

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_1 = arg_548_1:GetWordFromCfg(1109304139)
				local var_551_2 = arg_548_1:FormatText(var_551_1.content)

				arg_548_1.text_.text = var_551_2

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 22 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 22)

				if (22 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 22)) > 0 and var_551_0 < var_551_4 then
					arg_548_1.talkMaxDuration = var_551_4

					if var_551_4 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_4 + 0
					end
				end

				arg_548_1.text_.text = var_551_2
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304139", "story_v_side_new_1109304.awb") ~= 0 then
					local var_551_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304139", "story_v_side_new_1109304.awb") / 1000

					if var_551_5 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + 0
					end

					if var_551_1.prefab_name ~= "" and arg_548_1.actors_[var_551_1.prefab_name] ~= nil then
						local var_551_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_1.prefab_name].transform, "story_v_side_new_1109304", "1109304139", "story_v_side_new_1109304.awb")

						arg_548_1:RecordAudio("1109304139", var_551_6)
						arg_548_1:RecordAudio("1109304139", var_551_6)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304139", "story_v_side_new_1109304.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304139", "story_v_side_new_1109304.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_7 and arg_548_1.time_ < 0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1109304140 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1109304140
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1109304141(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.175

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(1109304140).content)

				arg_552_1.text_.text = var_555_1

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_3 = 7 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 7)

				if (7 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 7)) > 0 and var_555_0 < var_555_3 then
					arg_552_1.talkMaxDuration = var_555_3

					if var_555_3 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_3 + 0
					end
				end

				arg_552_1.text_.text = var_555_1
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_4 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_4 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_4

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_4 and arg_552_1.time_ < 0 + var_555_4 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1109304141 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1109304141
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1109304142(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.75

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_1 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(1109304141).content)

				arg_556_1.text_.text = var_559_1

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_3 = 30 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_1) / 30)

				if (30 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_1) / 30)) > 0 and var_559_0 < var_559_3 then
					arg_556_1.talkMaxDuration = var_559_3

					if var_559_3 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_3 + 0
					end
				end

				arg_556_1.text_.text = var_559_1
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_4 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_4 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_4

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_4 and arg_556_1.time_ < 0 + var_559_4 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1109304142 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1109304142
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1109304143(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.825

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, false)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_1 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(1109304142).content)

				arg_560_1.text_.text = var_563_1

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_3 = 33 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_1) / 33)

				if (33 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_1) / 33)) > 0 and var_563_0 < var_563_3 then
					arg_560_1.talkMaxDuration = var_563_3

					if var_563_3 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_3 + 0
					end
				end

				arg_560_1.text_.text = var_563_1
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_4 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_4 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_4

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_4 and arg_560_1.time_ < 0 + var_563_4 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play1109304143 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1109304143
		arg_564_1.duration_ = 7

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1109304144(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 2 < arg_564_1.time_ and arg_564_1.time_ <= 2 + arg_567_0 then
				local var_567_0 = arg_564_1.bgs_.STblack

				arg_564_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_567_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_567_1 = var_567_0:GetComponent("SpriteRenderer")

				if var_567_1 and var_567_1.sprite then
					local var_567_2 = 2 * (var_567_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_567_0.transform.localScale = Vector3.New(var_567_2 / var_567_1.sprite.bounds.size.y < var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x and var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x or var_567_2 / var_567_1.sprite.bounds.size.y, var_567_2 / var_567_1.sprite.bounds.size.y < var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x and var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x or var_567_2 / var_567_1.sprite.bounds.size.y, 0)
				end

				for iter_567_0, iter_567_1 in pairs(arg_564_1.bgs_) do
					if iter_567_0 ~= "STblack" then
						iter_567_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_567_3 = 0

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_3 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_4 = 2

			if var_567_3 <= arg_564_1.time_ and arg_564_1.time_ < var_567_3 + var_567_4 then
				local var_567_5 = Color.New(0, 0, 0)

				var_567_5.a = Mathf.Lerp(0, 1, (arg_564_1.time_ - var_567_3) / var_567_4)
				arg_564_1.mask_.color = var_567_5
			end

			if arg_564_1.time_ >= var_567_3 + var_567_4 and arg_564_1.time_ < var_567_3 + var_567_4 + arg_567_0 then
				local var_567_6 = Color.New(0, 0, 0)

				var_567_6.a = 1
				arg_564_1.mask_.color = var_567_6
			end

			local var_567_7 = 2

			if 2 < arg_564_1.time_ and arg_564_1.time_ <= var_567_7 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_8 = 2

			if var_567_7 <= arg_564_1.time_ and arg_564_1.time_ < var_567_7 + var_567_8 then
				local var_567_9 = Color.New(0, 0, 0)

				var_567_9.a = Mathf.Lerp(1, 0, (arg_564_1.time_ - var_567_7) / var_567_8)
				arg_564_1.mask_.color = var_567_9
			end

			if arg_564_1.time_ >= var_567_7 + var_567_8 and arg_564_1.time_ < var_567_7 + var_567_8 + arg_567_0 then
				local var_567_10 = Color.New(0, 0, 0)

				arg_564_1.mask_.enabled = false
				var_567_10.a = 0
				arg_564_1.mask_.color = var_567_10
			end

			if 2 < arg_564_1.time_ and arg_564_1.time_ <= 2 + arg_567_0 then
				arg_564_1.fswbg_:SetActive(true)
				arg_564_1.dialog_:SetActive(false)

				arg_564_1.fswtw_.percent = 0
				arg_564_1.fswt_.text = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(1109304143).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.fswt_)

				arg_564_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_564_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_564_1.fswtw_:SetDirty()

				arg_564_1.typewritterCharCountI18N = 0

				SetActive(arg_564_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_564_1:ShowNextGo(false)
			end

			local var_567_11 = 2.01666666666667

			if 2.01666666666667 < arg_564_1.time_ and arg_564_1.time_ <= var_567_11 + arg_567_0 then
				arg_564_1.var_.oldValueTypewriter = arg_564_1.fswtw_.percent

				SetActive(arg_564_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_564_1:ShowNextGo(false)
			end

			local var_567_12 = 14
			local var_567_13 = 0.933333333333333
			local var_567_14, var_567_15 = arg_564_1:GetPercentByPara(arg_564_1:FormatText(arg_564_1:GetWordFromCfg(1109304143).content), 1)

			if var_567_11 < arg_564_1.time_ and arg_564_1.time_ <= var_567_11 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0

				local var_567_16 = var_567_12 <= 0 and var_567_13 or var_567_13 * ((var_567_15 - arg_564_1.typewritterCharCountI18N) / var_567_12)

				if (var_567_12 <= 0 and var_567_13 or var_567_13 * ((var_567_15 - arg_564_1.typewritterCharCountI18N) / var_567_12)) > 0 and var_567_13 < var_567_16 then
					arg_564_1.talkMaxDuration = var_567_16

					if var_567_16 + var_567_11 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_16 + var_567_11
					end
				end
			end

			local var_567_17 = math.max(0.933333333333333, arg_564_1.talkMaxDuration)

			if var_567_11 <= arg_564_1.time_ and arg_564_1.time_ < var_567_11 + var_567_17 then
				arg_564_1.fswtw_.percent = Mathf.Lerp(arg_564_1.var_.oldValueTypewriter, var_567_14, (arg_564_1.time_ - var_567_11) / var_567_17)
				arg_564_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_564_1.fswtw_:SetDirty()
			end

			if arg_564_1.time_ >= var_567_11 + var_567_17 and arg_564_1.time_ < var_567_11 + var_567_17 + arg_567_0 then
				arg_564_1.fswtw_.percent = var_567_14

				arg_564_1.fswtw_:SetDirty()
				arg_564_1:ShowNextGo(true)

				arg_564_1.typewritterCharCountI18N = var_567_15
			end

			if 2.01666666666667 < arg_564_1.time_ and arg_564_1.time_ <= 2.01666666666667 + arg_567_0 then
				local var_567_18 = arg_564_1.fswbg_.transform:Find("textbox/adapt/content") or arg_564_1.fswbg_.transform:Find("textbox/content")
				local var_567_19 = arg_564_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_567_20 = var_567_18:GetComponent("RectTransform")

				var_567_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_567_20.offsetMin = Vector2.New(0, 0)
				var_567_20.offsetMax = Vector2.New(0, 0)
			end

			if 2.01666666666667 < arg_564_1.time_ and arg_564_1.time_ <= 2.01666666666667 + arg_567_0 then
				arg_564_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_offlight", "")
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1109304144 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1109304144
		arg_568_1.duration_ = 1

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1109304145(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.fswbg_:SetActive(true)
				arg_568_1.dialog_:SetActive(false)

				arg_568_1.fswtw_.percent = 0
				arg_568_1.fswt_.text = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(1109304144).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.fswt_)

				arg_568_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_568_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_568_1.fswtw_:SetDirty()

				arg_568_1.typewritterCharCountI18N = 0

				SetActive(arg_568_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_568_1:ShowNextGo(false)
			end

			local var_571_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.var_.oldValueTypewriter = arg_568_1.fswtw_.percent

				SetActive(arg_568_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_568_1:ShowNextGo(false)
			end

			local var_571_1 = 23
			local var_571_2 = 0.933333333333333
			local var_571_3, var_571_4 = arg_568_1:GetPercentByPara(arg_568_1:FormatText(arg_568_1:GetWordFromCfg(1109304144).content), 1)

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0

				local var_571_5 = var_571_1 <= 0 and var_571_2 or var_571_2 * ((var_571_4 - arg_568_1.typewritterCharCountI18N) / var_571_1)

				if (var_571_1 <= 0 and var_571_2 or var_571_2 * ((var_571_4 - arg_568_1.typewritterCharCountI18N) / var_571_1)) > 0 and var_571_2 < var_571_5 then
					arg_568_1.talkMaxDuration = var_571_5

					if var_571_5 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_5 + var_571_0
					end
				end
			end

			local var_571_6 = math.max(0.933333333333333, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_6 then
				arg_568_1.fswtw_.percent = Mathf.Lerp(arg_568_1.var_.oldValueTypewriter, var_571_3, (arg_568_1.time_ - var_571_0) / var_571_6)
				arg_568_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_568_1.fswtw_:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_6 and arg_568_1.time_ < var_571_0 + var_571_6 + arg_571_0 then
				arg_568_1.fswtw_.percent = var_571_3

				arg_568_1.fswtw_:SetDirty()
				arg_568_1:ShowNextGo(true)

				arg_568_1.typewritterCharCountI18N = var_571_4
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1109304145 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1109304145
		arg_572_1.duration_ = 1.35

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1109304146(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.fswbg_:SetActive(true)
				arg_572_1.dialog_:SetActive(false)

				arg_572_1.fswtw_.percent = 0
				arg_572_1.fswt_.text = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(1109304145).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.fswt_)

				arg_572_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_572_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_572_1.fswtw_:SetDirty()

				arg_572_1.typewritterCharCountI18N = 0

				SetActive(arg_572_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_572_1:ShowNextGo(false)
			end

			local var_575_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.var_.oldValueTypewriter = arg_572_1.fswtw_.percent

				SetActive(arg_572_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_572_1:ShowNextGo(false)
			end

			local var_575_1 = 20
			local var_575_2 = 1.33333333333333
			local var_575_3, var_575_4 = arg_572_1:GetPercentByPara(arg_572_1:FormatText(arg_572_1:GetWordFromCfg(1109304145).content), 1)

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0

				local var_575_5 = var_575_1 <= 0 and var_575_2 or var_575_2 * ((var_575_4 - arg_572_1.typewritterCharCountI18N) / var_575_1)

				if (var_575_1 <= 0 and var_575_2 or var_575_2 * ((var_575_4 - arg_572_1.typewritterCharCountI18N) / var_575_1)) > 0 and var_575_2 < var_575_5 then
					arg_572_1.talkMaxDuration = var_575_5

					if var_575_5 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_5 + var_575_0
					end
				end
			end

			local var_575_6 = math.max(1.33333333333333, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_6 then
				arg_572_1.fswtw_.percent = Mathf.Lerp(arg_572_1.var_.oldValueTypewriter, var_575_3, (arg_572_1.time_ - var_575_0) / var_575_6)
				arg_572_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_572_1.fswtw_:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_6 and arg_572_1.time_ < var_575_0 + var_575_6 + arg_575_0 then
				arg_572_1.fswtw_.percent = var_575_3

				arg_572_1.fswtw_:SetDirty()
				arg_572_1:ShowNextGo(true)

				arg_572_1.typewritterCharCountI18N = var_575_4
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1109304146 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1109304146
		arg_576_1.duration_ = 1

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1109304147(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.fswbg_:SetActive(true)
				arg_576_1.dialog_:SetActive(false)

				arg_576_1.fswtw_.percent = 0
				arg_576_1.fswt_.text = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(1109304146).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.fswt_)

				arg_576_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_576_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_576_1.fswtw_:SetDirty()

				arg_576_1.typewritterCharCountI18N = 0

				SetActive(arg_576_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_576_1:ShowNextGo(false)
			end

			local var_579_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.var_.oldValueTypewriter = arg_576_1.fswtw_.percent

				SetActive(arg_576_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_576_1:ShowNextGo(false)
			end

			local var_579_1 = 21
			local var_579_2 = 0.933333333333333
			local var_579_3, var_579_4 = arg_576_1:GetPercentByPara(arg_576_1:FormatText(arg_576_1:GetWordFromCfg(1109304146).content), 1)

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0

				local var_579_5 = var_579_1 <= 0 and var_579_2 or var_579_2 * ((var_579_4 - arg_576_1.typewritterCharCountI18N) / var_579_1)

				if (var_579_1 <= 0 and var_579_2 or var_579_2 * ((var_579_4 - arg_576_1.typewritterCharCountI18N) / var_579_1)) > 0 and var_579_2 < var_579_5 then
					arg_576_1.talkMaxDuration = var_579_5

					if var_579_5 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_5 + var_579_0
					end
				end
			end

			local var_579_6 = math.max(0.933333333333333, arg_576_1.talkMaxDuration)

			if var_579_0 <= arg_576_1.time_ and arg_576_1.time_ < var_579_0 + var_579_6 then
				arg_576_1.fswtw_.percent = Mathf.Lerp(arg_576_1.var_.oldValueTypewriter, var_579_3, (arg_576_1.time_ - var_579_0) / var_579_6)
				arg_576_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_576_1.fswtw_:SetDirty()
			end

			if arg_576_1.time_ >= var_579_0 + var_579_6 and arg_576_1.time_ < var_579_0 + var_579_6 + arg_579_0 then
				arg_576_1.fswtw_.percent = var_579_3

				arg_576_1.fswtw_:SetDirty()
				arg_576_1:ShowNextGo(true)

				arg_576_1.typewritterCharCountI18N = var_579_4
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1109304147 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 1109304147
		arg_580_1.duration_ = 9.47

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play1109304148(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.mask_.enabled = true
				arg_580_1.mask_.raycastTarget = true

				arg_580_1:SetGaussion(false)
			end

			local var_583_0 = 2

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 then
				local var_583_1 = Color.New(0, 0, 0)

				var_583_1.a = Mathf.Lerp(0, 1, (arg_580_1.time_ - 0) / var_583_0)
				arg_580_1.mask_.color = var_583_1
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 then
				local var_583_2 = Color.New(0, 0, 0)

				var_583_2.a = 1
				arg_580_1.mask_.color = var_583_2
			end

			local var_583_3 = 2

			if 2 < arg_580_1.time_ and arg_580_1.time_ <= var_583_3 + arg_583_0 then
				arg_580_1.mask_.enabled = true
				arg_580_1.mask_.raycastTarget = true

				arg_580_1:SetGaussion(false)
			end

			local var_583_4 = 2

			if var_583_3 <= arg_580_1.time_ and arg_580_1.time_ < var_583_3 + var_583_4 then
				local var_583_5 = Color.New(0, 0, 0)

				var_583_5.a = Mathf.Lerp(1, 0, (arg_580_1.time_ - var_583_3) / var_583_4)
				arg_580_1.mask_.color = var_583_5
			end

			if arg_580_1.time_ >= var_583_3 + var_583_4 and arg_580_1.time_ < var_583_3 + var_583_4 + arg_583_0 then
				local var_583_6 = Color.New(0, 0, 0)

				arg_580_1.mask_.enabled = false
				var_583_6.a = 0
				arg_580_1.mask_.color = var_583_6
			end

			if 1.98333333333333 < arg_580_1.time_ and arg_580_1.time_ <= 1.98333333333333 + arg_583_0 then
				arg_580_1.fswbg_:SetActive(false)
				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_580_1:ShowNextGo(false)
			end

			if arg_580_1.frameCnt_ <= 1 then
				arg_580_1.dialog_:SetActive(false)
			end

			local var_583_7 = 4
			local var_583_8 = 0.25

			if 4 < arg_580_1.time_ and arg_580_1.time_ <= var_583_7 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0

				arg_580_1.dialog_:SetActive(true)

				arg_580_1.dialogCg_.alpha = 0

				local var_583_9 = LeanTween.value(arg_580_1.dialog_, 0, 1, 0.3)

				var_583_9:setOnUpdate(LuaHelper.FloatAction(function(arg_584_0)
					arg_580_1.dialogCg_.alpha = arg_584_0
				end))
				var_583_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_580_1.dialog_)
					var_583_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_580_1.duration_ = arg_580_1.duration_ + 0.3

				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_10 = arg_580_1:GetWordFromCfg(1109304147)
				local var_583_11 = arg_580_1:FormatText(var_583_10.content)

				arg_580_1.text_.text = var_583_11

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_13 = 10 <= 0 and var_583_8 or var_583_8 * (utf8.len(var_583_11) / 10)

				if (10 <= 0 and var_583_8 or var_583_8 * (utf8.len(var_583_11) / 10)) > 0 and var_583_8 < var_583_13 then
					arg_580_1.talkMaxDuration = var_583_13
					var_583_7 = var_583_7 + 0.3

					if var_583_13 + var_583_7 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_13 + var_583_7
					end
				end

				arg_580_1.text_.text = var_583_11
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304147", "story_v_side_new_1109304.awb") ~= 0 then
					local var_583_14 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304147", "story_v_side_new_1109304.awb") / 1000

					if var_583_14 + var_583_7 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_14 + var_583_7
					end

					if var_583_10.prefab_name ~= "" and arg_580_1.actors_[var_583_10.prefab_name] ~= nil then
						local var_583_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_10.prefab_name].transform, "story_v_side_new_1109304", "1109304147", "story_v_side_new_1109304.awb")

						arg_580_1:RecordAudio("1109304147", var_583_15)
						arg_580_1:RecordAudio("1109304147", var_583_15)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304147", "story_v_side_new_1109304.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304147", "story_v_side_new_1109304.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_16 = var_583_7 + 0.3
			local var_583_17 = math.max(var_583_8, arg_580_1.talkMaxDuration)

			if var_583_7 + 0.3 <= arg_580_1.time_ and arg_580_1.time_ < var_583_16 + var_583_17 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_16) / var_583_17

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_16 + var_583_17 and arg_580_1.time_ < var_583_16 + var_583_17 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play1109304148 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1109304148
		arg_586_1.duration_ = 4

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1109304149(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = 0.475

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_1 = arg_586_1:GetWordFromCfg(1109304148)
				local var_589_2 = arg_586_1:FormatText(var_589_1.content)

				arg_586_1.text_.text = var_589_2

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_4 = 19 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_2) / 19)

				if (19 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_2) / 19)) > 0 and var_589_0 < var_589_4 then
					arg_586_1.talkMaxDuration = var_589_4

					if var_589_4 + 0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_4 + 0
					end
				end

				arg_586_1.text_.text = var_589_2
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304148", "story_v_side_new_1109304.awb") ~= 0 then
					local var_589_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304148", "story_v_side_new_1109304.awb") / 1000

					if var_589_5 + 0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_5 + 0
					end

					if var_589_1.prefab_name ~= "" and arg_586_1.actors_[var_589_1.prefab_name] ~= nil then
						local var_589_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_1.prefab_name].transform, "story_v_side_new_1109304", "1109304148", "story_v_side_new_1109304.awb")

						arg_586_1:RecordAudio("1109304148", var_589_6)
						arg_586_1:RecordAudio("1109304148", var_589_6)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304148", "story_v_side_new_1109304.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304148", "story_v_side_new_1109304.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_7 = math.max(var_589_0, arg_586_1.talkMaxDuration)

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_7 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - 0) / var_589_7

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= 0 + var_589_7 and arg_586_1.time_ < 0 + var_589_7 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play1109304149 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1109304149
		arg_590_1.duration_ = 3.93

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1109304150(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = 0.4

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_1 = arg_590_1:GetWordFromCfg(1109304149)
				local var_593_2 = arg_590_1:FormatText(var_593_1.content)

				arg_590_1.text_.text = var_593_2

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_4 = 16 <= 0 and var_593_0 or var_593_0 * (utf8.len(var_593_2) / 16)

				if (16 <= 0 and var_593_0 or var_593_0 * (utf8.len(var_593_2) / 16)) > 0 and var_593_0 < var_593_4 then
					arg_590_1.talkMaxDuration = var_593_4

					if var_593_4 + 0 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_4 + 0
					end
				end

				arg_590_1.text_.text = var_593_2
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304149", "story_v_side_new_1109304.awb") ~= 0 then
					local var_593_5 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304149", "story_v_side_new_1109304.awb") / 1000

					if var_593_5 + 0 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_5 + 0
					end

					if var_593_1.prefab_name ~= "" and arg_590_1.actors_[var_593_1.prefab_name] ~= nil then
						local var_593_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_1.prefab_name].transform, "story_v_side_new_1109304", "1109304149", "story_v_side_new_1109304.awb")

						arg_590_1:RecordAudio("1109304149", var_593_6)
						arg_590_1:RecordAudio("1109304149", var_593_6)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304149", "story_v_side_new_1109304.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304149", "story_v_side_new_1109304.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_7 = math.max(var_593_0, arg_590_1.talkMaxDuration)

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_7 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - 0) / var_593_7

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= 0 + var_593_7 and arg_590_1.time_ < 0 + var_593_7 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1109304150 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1109304150
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
			arg_594_1.auto_ = false
		end

		function arg_594_1.playNext_(arg_596_0)
			arg_594_1.onStoryFinished_()
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = 0.05

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, false)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_1 = arg_594_1:FormatText(arg_594_1:GetWordFromCfg(1109304150).content)

				arg_594_1.text_.text = var_597_1

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_3 = 2 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_1) / 2)

				if (2 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_1) / 2)) > 0 and var_597_0 < var_597_3 then
					arg_594_1.talkMaxDuration = var_597_3

					if var_597_3 + 0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_3 + 0
					end
				end

				arg_594_1.text_.text = var_597_1
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_4 = math.max(var_597_0, arg_594_1.talkMaxDuration)

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_4 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - 0) / var_597_4

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= 0 + var_597_4 and arg_594_1.time_ < 0 + var_597_4 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play1109304103 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1109304103
		arg_598_1.duration_ = 6.47

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1109304104(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(arg_598_1.actors_["1093ui_story"]) and arg_598_1.var_.characterEffect1093ui_story == nil then
				arg_598_1.var_.characterEffect1093ui_story = arg_598_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_0 = 0.2

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 and not isNil(arg_598_1.actors_["1093ui_story"]) then
				if arg_598_1.var_.characterEffect1093ui_story and not isNil(arg_598_1.actors_["1093ui_story"]) then
					arg_598_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 and not isNil(arg_598_1.actors_["1093ui_story"]) and arg_598_1.var_.characterEffect1093ui_story then
				arg_598_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_601_2 = "1093ui_story"

			if arg_598_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_601_3 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_598_1.stage_.transform)

				var_601_3.name = var_601_2
				var_601_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_598_1.actors_[var_601_2] = var_601_3

				local var_601_4 = var_601_3:GetComponentInChildren(typeof(CharacterEffect))

				var_601_4.enabled = true

				local var_601_5 = GameObjectTools.GetOrAddComponent(var_601_3, typeof(DynamicBoneHelper))

				if var_601_5 then
					var_601_5:EnableDynamicBone(false)
				end

				arg_598_1:ShowWeapon(var_601_4.transform, false)

				arg_598_1.var_[var_601_2 .. "Animator"] = var_601_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_598_1.var_[var_601_2 .. "Animator"].applyRootMotion = true
				arg_598_1.var_[var_601_2 .. "LipSync"] = var_601_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			local var_601_6 = "1093ui_story"

			if arg_598_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_601_7 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_598_1.stage_.transform)

				var_601_7.name = var_601_6
				var_601_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_598_1.actors_[var_601_6] = var_601_7

				local var_601_8 = var_601_7:GetComponentInChildren(typeof(CharacterEffect))

				var_601_8.enabled = true

				local var_601_9 = GameObjectTools.GetOrAddComponent(var_601_7, typeof(DynamicBoneHelper))

				if var_601_9 then
					var_601_9:EnableDynamicBone(false)
				end

				arg_598_1:ShowWeapon(var_601_8.transform, false)

				arg_598_1.var_[var_601_6 .. "Animator"] = var_601_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_598_1.var_[var_601_6 .. "Animator"].applyRootMotion = true
				arg_598_1.var_[var_601_6 .. "LipSync"] = var_601_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_601_10 = 0
			local var_601_11 = 0.375

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_10 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_12 = arg_598_1:GetWordFromCfg(1109304103)
				local var_601_13 = arg_598_1:FormatText(var_601_12.content)

				arg_598_1.text_.text = var_601_13

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_15 = 15 <= 0 and var_601_11 or var_601_11 * (utf8.len(var_601_13) / 15)

				if (15 <= 0 and var_601_11 or var_601_11 * (utf8.len(var_601_13) / 15)) > 0 and var_601_11 < var_601_15 then
					arg_598_1.talkMaxDuration = var_601_15

					if var_601_15 + var_601_10 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_15 + var_601_10
					end
				end

				arg_598_1.text_.text = var_601_13
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304103", "story_v_side_new_1109304.awb") ~= 0 then
					local var_601_16 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304103", "story_v_side_new_1109304.awb") / 1000

					if var_601_16 + var_601_10 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_16 + var_601_10
					end

					if var_601_12.prefab_name ~= "" and arg_598_1.actors_[var_601_12.prefab_name] ~= nil then
						local var_601_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_12.prefab_name].transform, "story_v_side_new_1109304", "1109304103", "story_v_side_new_1109304.awb")

						arg_598_1:RecordAudio("1109304103", var_601_17)
						arg_598_1:RecordAudio("1109304103", var_601_17)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304103", "story_v_side_new_1109304.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304103", "story_v_side_new_1109304.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_18 = math.max(var_601_11, arg_598_1.talkMaxDuration)

			if var_601_10 <= arg_598_1.time_ and arg_598_1.time_ < var_601_10 + var_601_18 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_10) / var_601_18

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_10 + var_601_18 and arg_598_1.time_ < var_601_10 + var_601_18 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1109304104 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1109304104
		arg_602_1.duration_ = 8.4

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1109304105(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_605_0 = 0
			local var_605_1 = 0.725

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_0 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_2 = arg_602_1:GetWordFromCfg(1109304104)
				local var_605_3 = arg_602_1:FormatText(var_605_2.content)

				arg_602_1.text_.text = var_605_3

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_5 = 29 <= 0 and var_605_1 or var_605_1 * (utf8.len(var_605_3) / 29)

				if (29 <= 0 and var_605_1 or var_605_1 * (utf8.len(var_605_3) / 29)) > 0 and var_605_1 < var_605_5 then
					arg_602_1.talkMaxDuration = var_605_5

					if var_605_5 + var_605_0 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_5 + var_605_0
					end
				end

				arg_602_1.text_.text = var_605_3
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304104", "story_v_side_new_1109304.awb") ~= 0 then
					local var_605_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304104", "story_v_side_new_1109304.awb") / 1000

					if var_605_6 + var_605_0 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_6 + var_605_0
					end

					if var_605_2.prefab_name ~= "" and arg_602_1.actors_[var_605_2.prefab_name] ~= nil then
						local var_605_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_2.prefab_name].transform, "story_v_side_new_1109304", "1109304104", "story_v_side_new_1109304.awb")

						arg_602_1:RecordAudio("1109304104", var_605_7)
						arg_602_1:RecordAudio("1109304104", var_605_7)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304104", "story_v_side_new_1109304.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304104", "story_v_side_new_1109304.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_8 = math.max(var_605_1, arg_602_1.talkMaxDuration)

			if var_605_0 <= arg_602_1.time_ and arg_602_1.time_ < var_605_0 + var_605_8 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_0) / var_605_8

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_0 + var_605_8 and arg_602_1.time_ < var_605_0 + var_605_8 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play1109304084 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1109304084
		arg_606_1.duration_ = 6.83

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1109304085(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(arg_606_1.actors_["1093ui_story"]) and arg_606_1.var_.characterEffect1093ui_story == nil then
				arg_606_1.var_.characterEffect1093ui_story = arg_606_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_0 = 0.2

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_0 and not isNil(arg_606_1.actors_["1093ui_story"]) then
				if arg_606_1.var_.characterEffect1093ui_story and not isNil(arg_606_1.actors_["1093ui_story"]) then
					arg_606_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_606_1.time_ >= 0 + var_609_0 and arg_606_1.time_ < 0 + var_609_0 + arg_609_0 and not isNil(arg_606_1.actors_["1093ui_story"]) and arg_606_1.var_.characterEffect1093ui_story then
				arg_606_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_609_2 = "1093ui_story"

			if arg_606_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_609_3 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_606_1.stage_.transform)

				var_609_3.name = var_609_2
				var_609_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_606_1.actors_[var_609_2] = var_609_3

				local var_609_4 = var_609_3:GetComponentInChildren(typeof(CharacterEffect))

				var_609_4.enabled = true

				local var_609_5 = GameObjectTools.GetOrAddComponent(var_609_3, typeof(DynamicBoneHelper))

				if var_609_5 then
					var_609_5:EnableDynamicBone(false)
				end

				arg_606_1:ShowWeapon(var_609_4.transform, false)

				arg_606_1.var_[var_609_2 .. "Animator"] = var_609_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_606_1.var_[var_609_2 .. "Animator"].applyRootMotion = true
				arg_606_1.var_[var_609_2 .. "LipSync"] = var_609_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action447")
			end

			local var_609_6 = "1093ui_story"

			if arg_606_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_609_7 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_606_1.stage_.transform)

				var_609_7.name = var_609_6
				var_609_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_606_1.actors_[var_609_6] = var_609_7

				local var_609_8 = var_609_7:GetComponentInChildren(typeof(CharacterEffect))

				var_609_8.enabled = true

				local var_609_9 = GameObjectTools.GetOrAddComponent(var_609_7, typeof(DynamicBoneHelper))

				if var_609_9 then
					var_609_9:EnableDynamicBone(false)
				end

				arg_606_1:ShowWeapon(var_609_8.transform, false)

				arg_606_1.var_[var_609_6 .. "Animator"] = var_609_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_606_1.var_[var_609_6 .. "Animator"].applyRootMotion = true
				arg_606_1.var_[var_609_6 .. "LipSync"] = var_609_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_609_10 = 0
			local var_609_11 = 0.525

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_10 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_12 = arg_606_1:GetWordFromCfg(1109304084)
				local var_609_13 = arg_606_1:FormatText(var_609_12.content)

				arg_606_1.text_.text = var_609_13

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_15 = 21 <= 0 and var_609_11 or var_609_11 * (utf8.len(var_609_13) / 21)

				if (21 <= 0 and var_609_11 or var_609_11 * (utf8.len(var_609_13) / 21)) > 0 and var_609_11 < var_609_15 then
					arg_606_1.talkMaxDuration = var_609_15

					if var_609_15 + var_609_10 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_15 + var_609_10
					end
				end

				arg_606_1.text_.text = var_609_13
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304084", "story_v_side_new_1109304.awb") ~= 0 then
					local var_609_16 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304084", "story_v_side_new_1109304.awb") / 1000

					if var_609_16 + var_609_10 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_16 + var_609_10
					end

					if var_609_12.prefab_name ~= "" and arg_606_1.actors_[var_609_12.prefab_name] ~= nil then
						local var_609_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_12.prefab_name].transform, "story_v_side_new_1109304", "1109304084", "story_v_side_new_1109304.awb")

						arg_606_1:RecordAudio("1109304084", var_609_17)
						arg_606_1:RecordAudio("1109304084", var_609_17)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304084", "story_v_side_new_1109304.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304084", "story_v_side_new_1109304.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_18 = math.max(var_609_11, arg_606_1.talkMaxDuration)

			if var_609_10 <= arg_606_1.time_ and arg_606_1.time_ < var_609_10 + var_609_18 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_10) / var_609_18

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_10 + var_609_18 and arg_606_1.time_ < var_609_10 + var_609_18 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play1109304085 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1109304085
		arg_610_1.duration_ = 4.6

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1109304086(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_613_0 = 0
			local var_613_1 = 0.425

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_0 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				arg_610_1.leftNameTxt_.text = arg_610_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_2 = arg_610_1:GetWordFromCfg(1109304085)
				local var_613_3 = arg_610_1:FormatText(var_613_2.content)

				arg_610_1.text_.text = var_613_3

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_5 = 17 <= 0 and var_613_1 or var_613_1 * (utf8.len(var_613_3) / 17)

				if (17 <= 0 and var_613_1 or var_613_1 * (utf8.len(var_613_3) / 17)) > 0 and var_613_1 < var_613_5 then
					arg_610_1.talkMaxDuration = var_613_5

					if var_613_5 + var_613_0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_5 + var_613_0
					end
				end

				arg_610_1.text_.text = var_613_3
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304085", "story_v_side_new_1109304.awb") ~= 0 then
					local var_613_6 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304085", "story_v_side_new_1109304.awb") / 1000

					if var_613_6 + var_613_0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_6 + var_613_0
					end

					if var_613_2.prefab_name ~= "" and arg_610_1.actors_[var_613_2.prefab_name] ~= nil then
						local var_613_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_2.prefab_name].transform, "story_v_side_new_1109304", "1109304085", "story_v_side_new_1109304.awb")

						arg_610_1:RecordAudio("1109304085", var_613_7)
						arg_610_1:RecordAudio("1109304085", var_613_7)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304085", "story_v_side_new_1109304.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304085", "story_v_side_new_1109304.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_8 = math.max(var_613_1, arg_610_1.talkMaxDuration)

			if var_613_0 <= arg_610_1.time_ and arg_610_1.time_ < var_613_0 + var_613_8 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_0) / var_613_8

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_0 + var_613_8 and arg_610_1.time_ < var_613_0 + var_613_8 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1109304042 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1109304042
		arg_614_1.duration_ = 6.73

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1109304043(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 and not isNil(arg_614_1.actors_["1093ui_story"]) and arg_614_1.var_.characterEffect1093ui_story == nil then
				arg_614_1.var_.characterEffect1093ui_story = arg_614_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_0 = 0.2

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_0 and not isNil(arg_614_1.actors_["1093ui_story"]) then
				if arg_614_1.var_.characterEffect1093ui_story and not isNil(arg_614_1.actors_["1093ui_story"]) then
					arg_614_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_614_1.time_ >= 0 + var_617_0 and arg_614_1.time_ < 0 + var_617_0 + arg_617_0 and not isNil(arg_614_1.actors_["1093ui_story"]) and arg_614_1.var_.characterEffect1093ui_story then
				arg_614_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_617_2 = "1093ui_story"

			if arg_614_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_617_3 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_614_1.stage_.transform)

				var_617_3.name = var_617_2
				var_617_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_614_1.actors_[var_617_2] = var_617_3

				local var_617_4 = var_617_3:GetComponentInChildren(typeof(CharacterEffect))

				var_617_4.enabled = true

				local var_617_5 = GameObjectTools.GetOrAddComponent(var_617_3, typeof(DynamicBoneHelper))

				if var_617_5 then
					var_617_5:EnableDynamicBone(false)
				end

				arg_614_1:ShowWeapon(var_617_4.transform, false)

				arg_614_1.var_[var_617_2 .. "Animator"] = var_617_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_614_1.var_[var_617_2 .. "Animator"].applyRootMotion = true
				arg_614_1.var_[var_617_2 .. "LipSync"] = var_617_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action447")
			end

			local var_617_6 = "1093ui_story"

			if arg_614_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_617_7 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_614_1.stage_.transform)

				var_617_7.name = var_617_6
				var_617_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_614_1.actors_[var_617_6] = var_617_7

				local var_617_8 = var_617_7:GetComponentInChildren(typeof(CharacterEffect))

				var_617_8.enabled = true

				local var_617_9 = GameObjectTools.GetOrAddComponent(var_617_7, typeof(DynamicBoneHelper))

				if var_617_9 then
					var_617_9:EnableDynamicBone(false)
				end

				arg_614_1:ShowWeapon(var_617_8.transform, false)

				arg_614_1.var_[var_617_6 .. "Animator"] = var_617_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_614_1.var_[var_617_6 .. "Animator"].applyRootMotion = true
				arg_614_1.var_[var_617_6 .. "LipSync"] = var_617_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_617_10 = 0
			local var_617_11 = 0.675

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_10 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_12 = arg_614_1:GetWordFromCfg(1109304042)
				local var_617_13 = arg_614_1:FormatText(var_617_12.content)

				arg_614_1.text_.text = var_617_13

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_15 = 27 <= 0 and var_617_11 or var_617_11 * (utf8.len(var_617_13) / 27)

				if (27 <= 0 and var_617_11 or var_617_11 * (utf8.len(var_617_13) / 27)) > 0 and var_617_11 < var_617_15 then
					arg_614_1.talkMaxDuration = var_617_15

					if var_617_15 + var_617_10 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_15 + var_617_10
					end
				end

				arg_614_1.text_.text = var_617_13
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304042", "story_v_side_new_1109304.awb") ~= 0 then
					local var_617_16 = manager.audio:GetVoiceLength("story_v_side_new_1109304", "1109304042", "story_v_side_new_1109304.awb") / 1000

					if var_617_16 + var_617_10 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_16 + var_617_10
					end

					if var_617_12.prefab_name ~= "" and arg_614_1.actors_[var_617_12.prefab_name] ~= nil then
						local var_617_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_12.prefab_name].transform, "story_v_side_new_1109304", "1109304042", "story_v_side_new_1109304.awb")

						arg_614_1:RecordAudio("1109304042", var_617_17)
						arg_614_1:RecordAudio("1109304042", var_617_17)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1109304", "1109304042", "story_v_side_new_1109304.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1109304", "1109304042", "story_v_side_new_1109304.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_18 = math.max(var_617_11, arg_614_1.talkMaxDuration)

			if var_617_10 <= arg_614_1.time_ and arg_614_1.time_ < var_617_10 + var_617_18 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_10) / var_617_18

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_10 + var_617_18 and arg_614_1.time_ < var_617_10 + var_617_18 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play1109304043 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1109304043
		arg_618_1.duration_ = 5

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1109304044(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 and not isNil(arg_618_1.actors_["1093ui_story"]) and arg_618_1.var_.characterEffect1093ui_story == nil then
				arg_618_1.var_.characterEffect1093ui_story = arg_618_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_0 = 0.2

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_0 and not isNil(arg_618_1.actors_["1093ui_story"]) then
				if arg_618_1.var_.characterEffect1093ui_story and not isNil(arg_618_1.actors_["1093ui_story"]) then
					arg_618_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_618_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_618_1.time_ - 0) / var_621_0)
				end
			end

			if arg_618_1.time_ >= 0 + var_621_0 and arg_618_1.time_ < 0 + var_621_0 + arg_621_0 and not isNil(arg_618_1.actors_["1093ui_story"]) and arg_618_1.var_.characterEffect1093ui_story then
				arg_618_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_618_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_621_1 = 0
			local var_621_2 = 0.3

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, true)
				arg_618_1.iconController_:SetSelectedState("hero")

				arg_618_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_618_1.callingController_:SetSelectedState("normal")

				arg_618_1.keyicon_.color = Color.New(1, 1, 1)
				arg_618_1.icon_.color = Color.New(1, 1, 1)

				local var_621_3 = arg_618_1:FormatText(arg_618_1:GetWordFromCfg(1109304043).content)

				arg_618_1.text_.text = var_621_3

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_5 = 12 <= 0 and var_621_2 or var_621_2 * (utf8.len(var_621_3) / 12)

				if (12 <= 0 and var_621_2 or var_621_2 * (utf8.len(var_621_3) / 12)) > 0 and var_621_2 < var_621_5 then
					arg_618_1.talkMaxDuration = var_621_5

					if var_621_5 + var_621_1 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_5 + var_621_1
					end
				end

				arg_618_1.text_.text = var_621_3
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)
				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_6 = math.max(var_621_2, arg_618_1.talkMaxDuration)

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_6 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_1) / var_621_6

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_1 + var_621_6 and arg_618_1.time_ < var_621_1 + var_621_6 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST11a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST06a",
		"TextureConfig/Background/R9301"
	},
	voices = {
		"story_v_side_new_1109304.awb"
	}
}
