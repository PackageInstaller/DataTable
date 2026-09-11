return {
	Play910201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_4_0.name = "ST02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST02

				arg_1_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST02" then
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
				arg_1_1:AudioAction("stop", "music", "ui_battle", "ui_battle_stopbgm", "")

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

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday", "se_story_birthday_shaokaodian", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.5

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910201001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 20 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 20)

				if (20 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 20)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play910201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 910201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play910201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(910201002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 7)

				if (7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 7)) > 0 and var_12_0 < var_12_3 then
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
	Play910201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 910201003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play910201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.75

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(910201003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 30 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 30)

				if (30 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 30)) > 0 and var_16_0 < var_16_3 then
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
	Play910201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 910201004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play910201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1084ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1084ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1084ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1084ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1084ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_3.localPosition

				arg_17_1:ShowWeapon(arg_17_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.97, -6)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_20_5 = arg_17_1.actors_["1084ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 0.3

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(910201004).content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 12 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 12)

				if (12 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 12)) > 0 and var_20_9 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_13 and arg_17_1.time_ < var_20_8 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play910201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 910201005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play910201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action432")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_24_0 = 0
			local var_24_1 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(910201005).content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 21 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_2) / 21)

				if (21 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_2) / 21)) > 0 and var_24_1 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_5 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_5 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_5

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_5 and arg_21_1.time_ < var_24_0 + var_24_5 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play910201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 910201006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play910201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = arg_25_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(arg_25_1.actors_["1084ui_story"]) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_28_1 = 0
			local var_28_2 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(910201006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 22 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 22)

				if (22 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 22)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play910201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 910201007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play910201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(910201007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 8 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 8)

				if (8 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 8)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play910201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 910201008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play910201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(910201008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 25 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 25)

				if (25 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 25)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play910201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 910201009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play910201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = arg_37_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(arg_37_1.actors_["1084ui_story"]) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.625

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(910201009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 25 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 25)

				if (25 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 25)) > 0 and var_40_3 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_7 and arg_37_1.time_ < var_40_2 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play910201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 910201010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play910201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_44_0 = 0
			local var_44_1 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(910201010).content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 13 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_2) / 13)

				if (13 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_2) / 13)) > 0 and var_44_1 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_5 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_5 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_5

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_5 and arg_41_1.time_ < var_44_0 + var_44_5 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play910201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 910201011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play910201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = arg_45_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(arg_45_1.actors_["1084ui_story"]) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.9

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(910201011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 36 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 36)

				if (36 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 36)) > 0 and var_48_2 < var_48_5 then
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
	Play910201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 910201012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play910201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.35

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(910201012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 14 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 14)

				if (14 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 14)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play910201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 910201013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play910201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.65

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(910201013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 26 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 26)

				if (26 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 26)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play910201014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 910201014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play910201015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.9

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(910201014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 36 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 36)

				if (36 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 36)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play910201015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 910201015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play910201016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.225

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(910201015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 18 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 18)

				if (18 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 18)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play910201016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 910201016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play910201017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.25

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(910201016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 10 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 10)

				if (10 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 10)) > 0 and var_68_0 < var_68_3 then
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
	Play910201017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 910201017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play910201018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = arg_69_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(arg_69_1.actors_["1084ui_story"]) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_72_2 = 0
			local var_72_3 = 0.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(910201017).content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 14 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_4) / 14)

				if (14 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_4) / 14)) > 0 and var_72_3 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_7 and arg_69_1.time_ < var_72_2 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play910201018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 910201018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play910201019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = arg_73_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(arg_73_1.actors_["1084ui_story"]) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1084ui_story"]) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.225

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(910201018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 9 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 9)

				if (9 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 9)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play910201019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 910201019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play910201020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.325

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(910201019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 14 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 14)

				if (14 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 14)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play910201020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 910201020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play910201021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = arg_81_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(arg_81_1.actors_["1084ui_story"]) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_84_2 = 0
			local var_84_3 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(910201020).content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 24 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 24)

				if (24 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 24)) > 0 and var_84_3 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_7 and arg_81_1.time_ < var_84_2 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play910201021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 910201021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play910201022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action468")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_88_0 = 0
			local var_88_1 = 0.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(910201021).content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 25 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_2) / 25)

				if (25 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_2) / 25)) > 0 and var_88_1 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_5 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_5 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_5

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_5 and arg_85_1.time_ < var_88_0 + var_88_5 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play910201022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910201022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910201023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = arg_89_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(arg_89_1.actors_["1084ui_story"]) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1084ui_story"]) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(910201022).content)

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
	Play910201023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910201023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910201024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1084ui_story"]) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = arg_93_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1084ui_story"]) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(arg_93_1.actors_["1084ui_story"]) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1084ui_story"]) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.925

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(910201023).content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 37 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 37)

				if (37 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 37)) > 0 and var_96_3 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_7 and arg_93_1.time_ < var_96_2 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play910201024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910201024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910201025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.525

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(910201024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 21 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 21)

				if (21 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 21)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play910201025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910201025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910201026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = arg_101_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(arg_101_1.actors_["1084ui_story"]) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1084ui_story"]) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_104_1 = 0
			local var_104_2 = 0.925

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(910201025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 37 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 37)

				if (37 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 37)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play910201026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910201026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910201027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1084ui_story"]) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = arg_105_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1084ui_story"]) then
				if arg_105_1.var_.characterEffect1084ui_story and not isNil(arg_105_1.actors_["1084ui_story"]) then
					arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1084ui_story"]) and arg_105_1.var_.characterEffect1084ui_story then
				arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_108_2 = 0
			local var_108_3 = 0.75

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(910201026).content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 30 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 30)

				if (30 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 30)) > 0 and var_108_3 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_7 and arg_105_1.time_ < var_108_2 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play910201027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 910201027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play910201028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_112_0 = 0
			local var_112_1 = 0.675

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(910201027).content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 27 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_2) / 27)

				if (27 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_2) / 27)) > 0 and var_112_1 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_5 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_5 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_5

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_5 and arg_109_1.time_ < var_112_0 + var_112_5 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play910201028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 910201028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play910201029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_116_0 = 0
			local var_116_1 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(910201028).content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 31 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_2) / 31)

				if (31 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_2) / 31)) > 0 and var_116_1 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_5 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_5 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_5

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_5 and arg_113_1.time_ < var_116_0 + var_116_5 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play910201029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 910201029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play910201030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_120_0 = 0
			local var_120_1 = 0.725

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(910201029).content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 29 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_2) / 29)

				if (29 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_2) / 29)) > 0 and var_120_1 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_5 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_5 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_5

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_5 and arg_117_1.time_ < var_120_0 + var_120_5 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play910201030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 910201030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play910201031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_124_0 = 0
			local var_124_1 = 0.575

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(910201030).content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 23 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_2) / 23)

				if (23 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_2) / 23)) > 0 and var_124_1 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_5 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_5 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_5

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_5 and arg_121_1.time_ < var_124_0 + var_124_5 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play910201031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 910201031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play910201032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = arg_125_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) then
				if arg_125_1.var_.characterEffect1084ui_story and not isNil(arg_125_1.actors_["1084ui_story"]) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.575

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(910201031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 23 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 23)

				if (23 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 23)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play910201032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 910201032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play910201033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.825

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(910201032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 33 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 33)

				if (33 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 33)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play910201033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 910201033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play910201034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = arg_133_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(arg_133_1.actors_["1084ui_story"]) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_136_2 = 0
			local var_136_3 = 0.15

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(910201033).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 6 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 6)

				if (6 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 6)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play910201034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 910201034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play910201035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = arg_137_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(arg_137_1.actors_["1084ui_story"]) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 1.025

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
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

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(910201034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 41 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 41)

				if (41 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 41)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play910201035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 910201035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play910201036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = arg_141_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(arg_141_1.actors_["1084ui_story"]) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1084ui_story"]) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_144_2 = 0
			local var_144_3 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(910201035).content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 18 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 18)

				if (18 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 18)) > 0 and var_144_3 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_7 and arg_141_1.time_ < var_144_2 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play910201036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 910201036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play910201037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1084ui_story"]) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = arg_145_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1084ui_story"]) then
				if arg_145_1.var_.characterEffect1084ui_story and not isNil(arg_145_1.actors_["1084ui_story"]) then
					arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1084ui_story"]) and arg_145_1.var_.characterEffect1084ui_story then
				arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.225

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(910201036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 9 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 9)

				if (9 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 9)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play910201037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 910201037
		arg_149_1.duration_ = 9

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play910201038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.STblack == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_152_0.name = "STblack"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.STblack = var_152_0
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.STblack

				arg_149_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "STblack" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_5 = 2

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_5 then
				local var_152_6 = Color.New(0, 0, 0)

				var_152_6.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - var_152_4) / var_152_5)
				arg_149_1.mask_.color = var_152_6
			end

			if arg_149_1.time_ >= var_152_4 + var_152_5 and arg_149_1.time_ < var_152_4 + var_152_5 + arg_152_0 then
				local var_152_7 = Color.New(0, 0, 0)

				var_152_7.a = 1
				arg_149_1.mask_.color = var_152_7
			end

			local var_152_8 = 2

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_9 = 2

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_9 then
				local var_152_10 = Color.New(0, 0, 0)

				var_152_10.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_8) / var_152_9)
				arg_149_1.mask_.color = var_152_10
			end

			if arg_149_1.time_ >= var_152_8 + var_152_9 and arg_149_1.time_ < var_152_8 + var_152_9 + arg_152_0 then
				local var_152_11 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_11.a = 0
				arg_149_1.mask_.color = var_152_11
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:AudioAction("stop", "effect", "se_story_birthday", "se_story_birthday_shaokaodian", "")
			end

			local var_152_13 = arg_149_1.actors_["1084ui_story"].transform

			if 1.966 < arg_149_1.time_ and arg_149_1.time_ <= 1.966 + arg_152_0 then
				arg_149_1.var_.moveOldPos1084ui_story = var_152_13.localPosition
			end

			local var_152_14 = 0.001

			if 1.966 <= arg_149_1.time_ and arg_149_1.time_ < 1.966 + var_152_14 then
				var_152_13.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 1.966) / var_152_14)
				var_152_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_13.position).x, (manager.ui.mainCamera.transform.position - var_152_13.position).y, (manager.ui.mainCamera.transform.position - var_152_13.position).z)
				var_152_13.localEulerAngles.z = 0
				var_152_13.localEulerAngles.x = 0
				var_152_13.localEulerAngles = var_152_13.localEulerAngles
			end

			if arg_149_1.time_ >= 1.966 + var_152_14 and arg_149_1.time_ < 1.966 + var_152_14 + arg_152_0 then
				var_152_13.localPosition = Vector3.New(0, 100, 0)
				var_152_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_13.position).x, (manager.ui.mainCamera.transform.position - var_152_13.position).y, (manager.ui.mainCamera.transform.position - var_152_13.position).z)
				var_152_13.localEulerAngles.z = 0
				var_152_13.localEulerAngles.x = 0
				var_152_13.localEulerAngles = var_152_13.localEulerAngles
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_15 = 4
			local var_152_16 = 0.55

			if 4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_17 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_17:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_18 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(910201037).content)

				arg_149_1.text_.text = var_152_18

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_20 = 22 <= 0 and var_152_16 or var_152_16 * (utf8.len(var_152_18) / 22)

				if (22 <= 0 and var_152_16 or var_152_16 * (utf8.len(var_152_18) / 22)) > 0 and var_152_16 < var_152_20 then
					arg_149_1.talkMaxDuration = var_152_20
					var_152_15 = var_152_15 + 0.3

					if var_152_20 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_18
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_21 = var_152_15 + 0.3
			local var_152_22 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_22 and arg_149_1.time_ < var_152_21 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play910201038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 910201038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play910201039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.475

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(910201038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 19 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 19)

				if (19 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 19)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play910201039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 910201039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play910201040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.15

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(910201039).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 6 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 6)

				if (6 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 6)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play910201040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 910201040
		arg_163_1.duration_ = 9

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play910201041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if arg_163_1.bgs_.A00 == nil then
				local var_166_0 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_166_0.name = "A00"
				var_166_0.transform.parent = arg_163_1.stage_.transform
				var_166_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_.A00 = var_166_0
			end

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				local var_166_1 = arg_163_1.bgs_.A00

				arg_163_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_166_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_2 = var_166_1:GetComponent("SpriteRenderer")

				if var_166_2 and var_166_2.sprite then
					local var_166_3 = 2 * (var_166_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_166_1.transform.localScale = Vector3.New(var_166_3 / var_166_2.sprite.bounds.size.y < var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x and var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x or var_166_3 / var_166_2.sprite.bounds.size.y, var_166_3 / var_166_2.sprite.bounds.size.y < var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x and var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x or var_166_3 / var_166_2.sprite.bounds.size.y, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "A00" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_4 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_5 = 2

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_5 then
				local var_166_6 = Color.New(0, 0, 0)

				var_166_6.a = Mathf.Lerp(0, 1, (arg_163_1.time_ - var_166_4) / var_166_5)
				arg_163_1.mask_.color = var_166_6
			end

			if arg_163_1.time_ >= var_166_4 + var_166_5 and arg_163_1.time_ < var_166_4 + var_166_5 + arg_166_0 then
				local var_166_7 = Color.New(0, 0, 0)

				var_166_7.a = 1
				arg_163_1.mask_.color = var_166_7
			end

			local var_166_8 = 2

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 then
				local var_166_10 = Color.New(0, 0, 0)

				var_166_10.a = Mathf.Lerp(1, 0, (arg_163_1.time_ - var_166_8) / var_166_9)
				arg_163_1.mask_.color = var_166_10
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 then
				local var_166_11 = Color.New(0, 0, 0)

				arg_163_1.mask_.enabled = false
				var_166_11.a = 0
				arg_163_1.mask_.color = var_166_11
			end

			local var_166_12 = "1019ui_story"

			if arg_163_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_166_13 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_163_1.stage_.transform)

				var_166_13.name = var_166_12
				var_166_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_[var_166_12] = var_166_13

				local var_166_14 = var_166_13:GetComponentInChildren(typeof(CharacterEffect))

				var_166_14.enabled = true

				local var_166_15 = GameObjectTools.GetOrAddComponent(var_166_13, typeof(DynamicBoneHelper))

				if var_166_15 then
					var_166_15:EnableDynamicBone(false)
				end

				arg_163_1:ShowWeapon(var_166_14.transform, false)

				arg_163_1.var_[var_166_12 .. "Animator"] = var_166_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_163_1.var_[var_166_12 .. "Animator"].applyRootMotion = true
				arg_163_1.var_[var_166_12 .. "LipSync"] = var_166_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_166_16 = arg_163_1.actors_["1019ui_story"].transform

			if 3.8 < arg_163_1.time_ and arg_163_1.time_ <= 3.8 + arg_166_0 then
				arg_163_1.var_.moveOldPos1019ui_story = var_166_16.localPosition
			end

			local var_166_17 = 0.001

			if 3.8 <= arg_163_1.time_ and arg_163_1.time_ < 3.8 + var_166_17 then
				var_166_16.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_163_1.time_ - 3.8) / var_166_17)
				var_166_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_16.position).x, (manager.ui.mainCamera.transform.position - var_166_16.position).y, (manager.ui.mainCamera.transform.position - var_166_16.position).z)
				var_166_16.localEulerAngles.z = 0
				var_166_16.localEulerAngles.x = 0
				var_166_16.localEulerAngles = var_166_16.localEulerAngles
			end

			if arg_163_1.time_ >= 3.8 + var_166_17 and arg_163_1.time_ < 3.8 + var_166_17 + arg_166_0 then
				var_166_16.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_166_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_16.position).x, (manager.ui.mainCamera.transform.position - var_166_16.position).y, (manager.ui.mainCamera.transform.position - var_166_16.position).z)
				var_166_16.localEulerAngles.z = 0
				var_166_16.localEulerAngles.x = 0
				var_166_16.localEulerAngles = var_166_16.localEulerAngles
			end

			local var_166_18 = arg_163_1.actors_["1019ui_story"]

			if 3.8 < arg_163_1.time_ and arg_163_1.time_ <= 3.8 + arg_166_0 and not isNil(var_166_18) and arg_163_1.var_.characterEffect1019ui_story == nil then
				arg_163_1.var_.characterEffect1019ui_story = var_166_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_19 = 0.2

			if 3.8 <= arg_163_1.time_ and arg_163_1.time_ < 3.8 + var_166_19 and not isNil(var_166_18) then
				if arg_163_1.var_.characterEffect1019ui_story and not isNil(var_166_18) then
					arg_163_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 3.8 + var_166_19 and arg_163_1.time_ < 3.8 + var_166_19 + arg_166_0 and not isNil(var_166_18) and arg_163_1.var_.characterEffect1019ui_story then
				arg_163_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 3.8 < arg_163_1.time_ and arg_163_1.time_ <= 3.8 + arg_166_0 then
				arg_163_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 3.8 < arg_163_1.time_ and arg_163_1.time_ <= 3.8 + arg_166_0 then
				arg_163_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_166_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_23 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_23

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_23
						arg_163_1.bgmTxt2_.text = var_166_23
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.8 < arg_163_1.time_ and arg_163_1.time_ <= 3.8 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_166_26 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_26 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_26

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_26
						arg_163_1.bgmTxt2_.text = var_166_26
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_27 = 4
			local var_166_28 = 0.9

			if 4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_27 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_29 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(910201040).content)

				arg_163_1.text_.text = var_166_29

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_31 = 36 <= 0 and var_166_28 or var_166_28 * (utf8.len(var_166_29) / 36)

				if (36 <= 0 and var_166_28 or var_166_28 * (utf8.len(var_166_29) / 36)) > 0 and var_166_28 < var_166_31 then
					arg_163_1.talkMaxDuration = var_166_31

					if var_166_31 + var_166_27 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_27
					end
				end

				arg_163_1.text_.text = var_166_29
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_32 = math.max(var_166_28, arg_163_1.talkMaxDuration)

			if var_166_27 <= arg_163_1.time_ and arg_163_1.time_ < var_166_27 + var_166_32 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_27) / var_166_32

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_27 + var_166_32 and arg_163_1.time_ < var_166_27 + var_166_32 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play910201041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910201041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910201042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_172_0 = 0
			local var_172_1 = 0.825

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(910201041).content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 33 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_2) / 33)

				if (33 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_2) / 33)) > 0 and var_172_1 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_5 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_5 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_5

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_5 and arg_169_1.time_ < var_172_0 + var_172_5 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play910201042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910201042
		arg_173_1.duration_ = 0.2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"

			SetActive(arg_173_1.choicesGo_, true)

			for iter_174_0, iter_174_1 in ipairs(arg_173_1.choices_) do
				SetActive(iter_174_1.go, iter_174_0 <= 1)
			end

			arg_173_1.choices_[1].txt.text = arg_173_1:FormatText(StoryChoiceCfg[247].name)
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910201043(arg_173_1)
			end

			arg_173_1:RecordChoiceLog(910201042, 247)
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) and arg_173_1.var_.characterEffect1019ui_story == nil then
				arg_173_1.var_.characterEffect1019ui_story = arg_173_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) then
				if arg_173_1.var_.characterEffect1019ui_story and not isNil(arg_173_1.actors_["1019ui_story"]) then
					arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) and arg_173_1.var_.characterEffect1019ui_story then
				arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play910201043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910201043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910201044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1019ui_story"]) and arg_177_1.var_.characterEffect1019ui_story == nil then
				arg_177_1.var_.characterEffect1019ui_story = arg_177_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1019ui_story"]) then
				if arg_177_1.var_.characterEffect1019ui_story and not isNil(arg_177_1.actors_["1019ui_story"]) then
					arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1019ui_story"]) and arg_177_1.var_.characterEffect1019ui_story then
				arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_180_2 = 0
			local var_180_3 = 0.575

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(910201043).content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 23 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 23)

				if (23 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 23)) > 0 and var_180_3 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_7 and arg_177_1.time_ < var_180_2 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play910201044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910201044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910201045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1019ui_story"]) and arg_181_1.var_.characterEffect1019ui_story == nil then
				arg_181_1.var_.characterEffect1019ui_story = arg_181_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1019ui_story"]) then
				if arg_181_1.var_.characterEffect1019ui_story and not isNil(arg_181_1.actors_["1019ui_story"]) then
					arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1019ui_story"]) and arg_181_1.var_.characterEffect1019ui_story then
				arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.15

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(910201044).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 6 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 6)

				if (6 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 6)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play910201045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910201045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"

			SetActive(arg_185_1.choicesGo_, true)

			for iter_186_0, iter_186_1 in ipairs(arg_185_1.choices_) do
				SetActive(iter_186_1.go, iter_186_0 <= 2)
			end

			arg_185_1.choices_[1].txt.text = arg_185_1:FormatText(StoryChoiceCfg[248].name)
			arg_185_1.choices_[2].txt.text = arg_185_1:FormatText(StoryChoiceCfg[249].name)
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910201046(arg_185_1)
			end

			if arg_187_0 == 2 then
				arg_185_0:Play910201046(arg_185_1)
			end

			arg_185_1:RecordChoiceLog(910201045, 248, 249)
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.0333333333333333

			if 4.96666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 4.96666666666667 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(100012006).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 0 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 0)

				if (0 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 0)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 4.96666666666667 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 4.96666666666667
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 4.96666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 4.96666666666667 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 4.96666666666667) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 4.96666666666667 + var_188_4 and arg_185_1.time_ < 4.96666666666667 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play910201046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910201046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910201047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1019ui_story"]) and arg_189_1.var_.characterEffect1019ui_story == nil then
				arg_189_1.var_.characterEffect1019ui_story = arg_189_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1019ui_story"]) then
				if arg_189_1.var_.characterEffect1019ui_story and not isNil(arg_189_1.actors_["1019ui_story"]) then
					arg_189_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1019ui_story"]) and arg_189_1.var_.characterEffect1019ui_story then
				arg_189_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_192_2 = "1019ui_story"

			if arg_189_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_192_3 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_189_1.stage_.transform)

				var_192_3.name = var_192_2
				var_192_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_[var_192_2] = var_192_3

				local var_192_4 = var_192_3:GetComponentInChildren(typeof(CharacterEffect))

				var_192_4.enabled = true

				local var_192_5 = GameObjectTools.GetOrAddComponent(var_192_3, typeof(DynamicBoneHelper))

				if var_192_5 then
					var_192_5:EnableDynamicBone(false)
				end

				arg_189_1:ShowWeapon(var_192_4.transform, false)

				arg_189_1.var_[var_192_2 .. "Animator"] = var_192_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_189_1.var_[var_192_2 .. "Animator"].applyRootMotion = true
				arg_189_1.var_[var_192_2 .. "LipSync"] = var_192_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action467")
			end

			local var_192_6 = 0
			local var_192_7 = 0.75

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(910201046).content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 30 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_8) / 30)

				if (30 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_8) / 30)) > 0 and var_192_7 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_11 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_11 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_11

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_11 and arg_189_1.time_ < var_192_6 + var_192_11 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play910201047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910201047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910201048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action472")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_196_0 = 0
			local var_196_1 = 0.775

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(910201047).content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 31 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_2) / 31)

				if (31 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_2) / 31)) > 0 and var_196_1 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_5 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_5 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_5

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_5 and arg_193_1.time_ < var_196_0 + var_196_5 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play910201048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910201048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910201049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_200_0 = 0
			local var_200_1 = 0.4

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(910201048).content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 16 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_2) / 16)

				if (16 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_2) / 16)) > 0 and var_200_1 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_5 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_5 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_5

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_5 and arg_197_1.time_ < var_200_0 + var_200_5 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play910201049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910201049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910201050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1019ui_story"]) and arg_201_1.var_.characterEffect1019ui_story == nil then
				arg_201_1.var_.characterEffect1019ui_story = arg_201_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1019ui_story"]) then
				if arg_201_1.var_.characterEffect1019ui_story and not isNil(arg_201_1.actors_["1019ui_story"]) then
					arg_201_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1019ui_story"]) and arg_201_1.var_.characterEffect1019ui_story then
				arg_201_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.2

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(910201049).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 8 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 8)

				if (8 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 8)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play910201050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910201050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910201051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1019ui_story"]) and arg_205_1.var_.characterEffect1019ui_story == nil then
				arg_205_1.var_.characterEffect1019ui_story = arg_205_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1019ui_story"]) then
				if arg_205_1.var_.characterEffect1019ui_story and not isNil(arg_205_1.actors_["1019ui_story"]) then
					arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1019ui_story"]) and arg_205_1.var_.characterEffect1019ui_story then
				arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_208_2 = 0
			local var_208_3 = 0.525

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(910201050).content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 21 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 21)

				if (21 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 21)) > 0 and var_208_3 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_7 and arg_205_1.time_ < var_208_2 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play910201051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910201051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910201052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1019ui_story"]) and arg_209_1.var_.characterEffect1019ui_story == nil then
				arg_209_1.var_.characterEffect1019ui_story = arg_209_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1019ui_story"]) then
				if arg_209_1.var_.characterEffect1019ui_story and not isNil(arg_209_1.actors_["1019ui_story"]) then
					arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1019ui_story"]) and arg_209_1.var_.characterEffect1019ui_story then
				arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(910201051).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 12 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 12)

				if (12 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 12)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play910201052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 910201052
		arg_213_1.duration_ = 9

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play910201053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.B13 == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_216_0.name = "B13"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.B13 = var_216_0
			end

			if 1.966 < arg_213_1.time_ and arg_213_1.time_ <= 1.966 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.B13

				arg_213_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "B13" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_5 = 2

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_5 then
				local var_216_6 = Color.New(0, 0, 0)

				var_216_6.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_4) / var_216_5)
				arg_213_1.mask_.color = var_216_6
			end

			if arg_213_1.time_ >= var_216_4 + var_216_5 and arg_213_1.time_ < var_216_4 + var_216_5 + arg_216_0 then
				local var_216_7 = Color.New(0, 0, 0)

				var_216_7.a = 1
				arg_213_1.mask_.color = var_216_7
			end

			local var_216_8 = 2

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_9 = 2

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 then
				local var_216_10 = Color.New(0, 0, 0)

				var_216_10.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_8) / var_216_9)
				arg_213_1.mask_.color = var_216_10
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 then
				local var_216_11 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_11.a = 0
				arg_213_1.mask_.color = var_216_11
			end

			local var_216_12 = arg_213_1.actors_["1019ui_story"].transform

			if 1.966 < arg_213_1.time_ and arg_213_1.time_ <= 1.966 + arg_216_0 then
				arg_213_1.var_.moveOldPos1019ui_story = var_216_12.localPosition
			end

			local var_216_13 = 0.001

			if 1.966 <= arg_213_1.time_ and arg_213_1.time_ < 1.966 + var_216_13 then
				var_216_12.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 1.966) / var_216_13)
				var_216_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_12.position).x, (manager.ui.mainCamera.transform.position - var_216_12.position).y, (manager.ui.mainCamera.transform.position - var_216_12.position).z)
				var_216_12.localEulerAngles.z = 0
				var_216_12.localEulerAngles.x = 0
				var_216_12.localEulerAngles = var_216_12.localEulerAngles
			end

			if arg_213_1.time_ >= 1.966 + var_216_13 and arg_213_1.time_ < 1.966 + var_216_13 + arg_216_0 then
				var_216_12.localPosition = Vector3.New(0, 100, 0)
				var_216_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_12.position).x, (manager.ui.mainCamera.transform.position - var_216_12.position).y, (manager.ui.mainCamera.transform.position - var_216_12.position).z)
				var_216_12.localEulerAngles.z = 0
				var_216_12.localEulerAngles.x = 0
				var_216_12.localEulerAngles = var_216_12.localEulerAngles
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_14 = 4
			local var_216_15 = 0.875

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_16 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_16:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_17 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(910201052).content)

				arg_213_1.text_.text = var_216_17

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_19 = 35 <= 0 and var_216_15 or var_216_15 * (utf8.len(var_216_17) / 35)

				if (35 <= 0 and var_216_15 or var_216_15 * (utf8.len(var_216_17) / 35)) > 0 and var_216_15 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19
					var_216_14 = var_216_14 + 0.3

					if var_216_19 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_14
					end
				end

				arg_213_1.text_.text = var_216_17
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_20 = var_216_14 + 0.3
			local var_216_21 = math.max(var_216_15, arg_213_1.talkMaxDuration)

			if var_216_14 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_20 + var_216_21 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_20) / var_216_21

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_20 + var_216_21 and arg_213_1.time_ < var_216_20 + var_216_21 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play910201053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 910201053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play910201054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_222_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_219_1.stage_.transform)

				var_222_0.name = "1039ui_story"
				var_222_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1039ui_story"] = var_222_0

				local var_222_1 = var_222_0:GetComponentInChildren(typeof(CharacterEffect))

				var_222_1.enabled = true

				local var_222_2 = GameObjectTools.GetOrAddComponent(var_222_0, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(false)
				end

				arg_219_1:ShowWeapon(var_222_1.transform, false)

				arg_219_1.var_["1039ui_story" .. "Animator"] = var_222_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_219_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_219_1.var_["1039ui_story" .. "LipSync"] = var_222_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_222_3 = arg_219_1.actors_["1039ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1039ui_story = var_222_3.localPosition
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_3.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_219_1.time_ - 0) / var_222_4)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_222_5 = arg_219_1.actors_["1039ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1039ui_story == nil then
				arg_219_1.var_.characterEffect1039ui_story = var_222_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 and not isNil(var_222_5) then
				if arg_219_1.var_.characterEffect1039ui_story and not isNil(var_222_5) then
					arg_219_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1039ui_story then
				arg_219_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_222_8 = 0
			local var_222_9 = 0.225

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(910201053).content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_12 = 9 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_10) / 9)

				if (9 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_10) / 9)) > 0 and var_222_9 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_13 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_13

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_13 and arg_219_1.time_ < var_222_8 + var_222_13 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play910201054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 910201054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play910201055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1039ui_story"]) and arg_223_1.var_.characterEffect1039ui_story == nil then
				arg_223_1.var_.characterEffect1039ui_story = arg_223_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1039ui_story"]) then
				if arg_223_1.var_.characterEffect1039ui_story and not isNil(arg_223_1.actors_["1039ui_story"]) then
					arg_223_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1039ui_story"]) and arg_223_1.var_.characterEffect1039ui_story then
				arg_223_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.55

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(910201054).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 22 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 22)

				if (22 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 22)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play910201055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 910201055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play910201056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1039ui_story"]) and arg_227_1.var_.characterEffect1039ui_story == nil then
				arg_227_1.var_.characterEffect1039ui_story = arg_227_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1039ui_story"]) then
				if arg_227_1.var_.characterEffect1039ui_story and not isNil(arg_227_1.actors_["1039ui_story"]) then
					arg_227_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1039ui_story"]) and arg_227_1.var_.characterEffect1039ui_story then
				arg_227_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action457")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_230_2 = 0
			local var_230_3 = 0.375

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(910201055).content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 15 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_4) / 15)

				if (15 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_4) / 15)) > 0 and var_230_3 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_7 and arg_227_1.time_ < var_230_2 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play910201056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 910201056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play910201057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1039ui_story"]) and arg_231_1.var_.characterEffect1039ui_story == nil then
				arg_231_1.var_.characterEffect1039ui_story = arg_231_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1039ui_story"]) then
				if arg_231_1.var_.characterEffect1039ui_story and not isNil(arg_231_1.actors_["1039ui_story"]) then
					arg_231_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1039ui_story"]) and arg_231_1.var_.characterEffect1039ui_story then
				arg_231_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.825

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(910201056).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 33 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 33)

				if (33 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 33)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play910201057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 910201057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play910201058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1039ui_story"]) and arg_235_1.var_.characterEffect1039ui_story == nil then
				arg_235_1.var_.characterEffect1039ui_story = arg_235_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1039ui_story"]) then
				if arg_235_1.var_.characterEffect1039ui_story and not isNil(arg_235_1.actors_["1039ui_story"]) then
					arg_235_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1039ui_story"]) and arg_235_1.var_.characterEffect1039ui_story then
				arg_235_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action472")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_238_2 = 0
			local var_238_3 = 0.875

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(910201057).content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_6 = 35 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_4) / 35)

				if (35 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_4) / 35)) > 0 and var_238_3 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_7 and arg_235_1.time_ < var_238_2 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play910201058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 910201058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play910201059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_242_0 = 0
			local var_242_1 = 0.875

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(910201058).content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 35 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_2) / 35)

				if (35 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_2) / 35)) > 0 and var_242_1 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_5 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_5 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_5

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_5 and arg_239_1.time_ < var_242_0 + var_242_5 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play910201059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 910201059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play910201060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_246_0 = 0
			local var_246_1 = 0.775

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(910201059).content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 31 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_2) / 31)

				if (31 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_2) / 31)) > 0 and var_246_1 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_5 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_5 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_5

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_5 and arg_243_1.time_ < var_246_0 + var_246_5 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play910201060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 910201060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play910201061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_250_0 = 0
			local var_250_1 = 0.625

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(910201060).content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 25 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_2) / 25)

				if (25 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_2) / 25)) > 0 and var_250_1 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_5 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_5 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_5

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_5 and arg_247_1.time_ < var_250_0 + var_250_5 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play910201061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 910201061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play910201062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1039ui_story"]) and arg_251_1.var_.characterEffect1039ui_story == nil then
				arg_251_1.var_.characterEffect1039ui_story = arg_251_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1039ui_story"]) then
				if arg_251_1.var_.characterEffect1039ui_story and not isNil(arg_251_1.actors_["1039ui_story"]) then
					arg_251_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1039ui_story"]) and arg_251_1.var_.characterEffect1039ui_story then
				arg_251_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.75

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

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(910201061).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 30 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 30)

				if (30 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 30)) > 0 and var_254_2 < var_254_5 then
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
	Play910201062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 910201062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play910201063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1039ui_story"]) and arg_255_1.var_.characterEffect1039ui_story == nil then
				arg_255_1.var_.characterEffect1039ui_story = arg_255_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1039ui_story"]) then
				if arg_255_1.var_.characterEffect1039ui_story and not isNil(arg_255_1.actors_["1039ui_story"]) then
					arg_255_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1039ui_story"]) and arg_255_1.var_.characterEffect1039ui_story then
				arg_255_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_258_2 = 0
			local var_258_3 = 0.125

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(910201062).content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_6 = 5 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 5)

				if (5 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 5)) > 0 and var_258_3 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6

					if var_258_6 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_7 and arg_255_1.time_ < var_258_2 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play910201063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 910201063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play910201064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1039ui_story"]) and arg_259_1.var_.characterEffect1039ui_story == nil then
				arg_259_1.var_.characterEffect1039ui_story = arg_259_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1039ui_story"]) then
				if arg_259_1.var_.characterEffect1039ui_story and not isNil(arg_259_1.actors_["1039ui_story"]) then
					arg_259_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1039ui_story"]) and arg_259_1.var_.characterEffect1039ui_story then
				arg_259_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.45

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(910201063).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 18 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 18)

				if (18 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 18)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play910201064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 910201064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play910201065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1039ui_story"]) and arg_263_1.var_.characterEffect1039ui_story == nil then
				arg_263_1.var_.characterEffect1039ui_story = arg_263_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1039ui_story"]) then
				if arg_263_1.var_.characterEffect1039ui_story and not isNil(arg_263_1.actors_["1039ui_story"]) then
					arg_263_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1039ui_story"]) and arg_263_1.var_.characterEffect1039ui_story then
				arg_263_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_266_2 = 0
			local var_266_3 = 0.575

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(910201064).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 23 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 23)

				if (23 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 23)) > 0 and var_266_3 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_7 and arg_263_1.time_ < var_266_2 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play910201065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 910201065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play910201066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action437")
			end

			local var_270_0 = 0
			local var_270_1 = 0.8

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(910201065).content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 32 <= 0 and var_270_1 or var_270_1 * (utf8.len(var_270_2) / 32)

				if (32 <= 0 and var_270_1 or var_270_1 * (utf8.len(var_270_2) / 32)) > 0 and var_270_1 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_5 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_5 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_5

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_5 and arg_267_1.time_ < var_270_0 + var_270_5 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play910201066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 910201066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play910201067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1039ui_story"]) and arg_271_1.var_.characterEffect1039ui_story == nil then
				arg_271_1.var_.characterEffect1039ui_story = arg_271_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1039ui_story"]) then
				if arg_271_1.var_.characterEffect1039ui_story and not isNil(arg_271_1.actors_["1039ui_story"]) then
					arg_271_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1039ui_story"]) and arg_271_1.var_.characterEffect1039ui_story then
				arg_271_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_274_1 = 0
			local var_274_2 = 0.5

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(910201066).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 20 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 20)

				if (20 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 20)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play910201067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 910201067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play910201068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action474")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_278_0 = arg_275_1.actors_["1039ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1039ui_story == nil then
				arg_275_1.var_.characterEffect1039ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_1 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 and not isNil(var_278_0) then
				if arg_275_1.var_.characterEffect1039ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1039ui_story then
				arg_275_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_278_3 = 0
			local var_278_4 = 0.875

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_5 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(910201067).content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 35 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_5) / 35)

				if (35 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_5) / 35)) > 0 and var_278_4 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_3 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_3
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_4, arg_275_1.talkMaxDuration)

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_3) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_3 + var_278_8 and arg_275_1.time_ < var_278_3 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play910201068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 910201068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play910201069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1039ui_story"]) and arg_279_1.var_.characterEffect1039ui_story == nil then
				arg_279_1.var_.characterEffect1039ui_story = arg_279_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1039ui_story"]) then
				if arg_279_1.var_.characterEffect1039ui_story and not isNil(arg_279_1.actors_["1039ui_story"]) then
					arg_279_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1039ui_story"]) and arg_279_1.var_.characterEffect1039ui_story then
				arg_279_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.225

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(910201068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 9 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 9)

				if (9 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 9)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play910201069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 910201069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play910201070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1039ui_story"]) and arg_283_1.var_.characterEffect1039ui_story == nil then
				arg_283_1.var_.characterEffect1039ui_story = arg_283_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1039ui_story"]) then
				if arg_283_1.var_.characterEffect1039ui_story and not isNil(arg_283_1.actors_["1039ui_story"]) then
					arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1039ui_story"]) and arg_283_1.var_.characterEffect1039ui_story then
				arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_286_2 = 0
			local var_286_3 = 0.425

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(910201069).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 17 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 17)

				if (17 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 17)) > 0 and var_286_3 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_7 and arg_283_1.time_ < var_286_2 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play910201070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 910201070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play910201071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_290_0 = 0
			local var_290_1 = 0.8

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_2 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(910201070).content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 32 <= 0 and var_290_1 or var_290_1 * (utf8.len(var_290_2) / 32)

				if (32 <= 0 and var_290_1 or var_290_1 * (utf8.len(var_290_2) / 32)) > 0 and var_290_1 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_5 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_5 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_5

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_5 and arg_287_1.time_ < var_290_0 + var_290_5 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play910201071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 910201071
		arg_291_1.duration_ = 9

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play910201072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if arg_291_1.bgs_.ST12 == nil then
				local var_294_0 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_294_0.name = "ST12"
				var_294_0.transform.parent = arg_291_1.stage_.transform
				var_294_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_.ST12 = var_294_0
			end

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				local var_294_1 = arg_291_1.bgs_.ST12

				arg_291_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_2 = var_294_1:GetComponent("SpriteRenderer")

				if var_294_2 and var_294_2.sprite then
					local var_294_3 = 2 * (var_294_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_1.transform.localScale = Vector3.New(var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "ST12" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_4 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_5 = 2

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_5 then
				local var_294_6 = Color.New(0, 0, 0)

				var_294_6.a = Mathf.Lerp(0, 1, (arg_291_1.time_ - var_294_4) / var_294_5)
				arg_291_1.mask_.color = var_294_6
			end

			if arg_291_1.time_ >= var_294_4 + var_294_5 and arg_291_1.time_ < var_294_4 + var_294_5 + arg_294_0 then
				local var_294_7 = Color.New(0, 0, 0)

				var_294_7.a = 1
				arg_291_1.mask_.color = var_294_7
			end

			local var_294_8 = 2

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_9 = 2

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_9 then
				local var_294_10 = Color.New(0, 0, 0)

				var_294_10.a = Mathf.Lerp(1, 0, (arg_291_1.time_ - var_294_8) / var_294_9)
				arg_291_1.mask_.color = var_294_10
			end

			if arg_291_1.time_ >= var_294_8 + var_294_9 and arg_291_1.time_ < var_294_8 + var_294_9 + arg_294_0 then
				local var_294_11 = Color.New(0, 0, 0)

				arg_291_1.mask_.enabled = false
				var_294_11.a = 0
				arg_291_1.mask_.color = var_294_11
			end

			local var_294_12 = arg_291_1.actors_["1039ui_story"].transform

			if 1.966 < arg_291_1.time_ and arg_291_1.time_ <= 1.966 + arg_294_0 then
				arg_291_1.var_.moveOldPos1039ui_story = var_294_12.localPosition
			end

			local var_294_13 = 0.001

			if 1.966 <= arg_291_1.time_ and arg_291_1.time_ < 1.966 + var_294_13 then
				var_294_12.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 1.966) / var_294_13)
				var_294_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_12.position).x, (manager.ui.mainCamera.transform.position - var_294_12.position).y, (manager.ui.mainCamera.transform.position - var_294_12.position).z)
				var_294_12.localEulerAngles.z = 0
				var_294_12.localEulerAngles.x = 0
				var_294_12.localEulerAngles = var_294_12.localEulerAngles
			end

			if arg_291_1.time_ >= 1.966 + var_294_13 and arg_291_1.time_ < 1.966 + var_294_13 + arg_294_0 then
				var_294_12.localPosition = Vector3.New(0, 100, 0)
				var_294_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_12.position).x, (manager.ui.mainCamera.transform.position - var_294_12.position).y, (manager.ui.mainCamera.transform.position - var_294_12.position).z)
				var_294_12.localEulerAngles.z = 0
				var_294_12.localEulerAngles.x = 0
				var_294_12.localEulerAngles = var_294_12.localEulerAngles
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_14 = 4
			local var_294_15 = 0.8

			if 4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_16 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_16:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_17 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(910201071).content)

				arg_291_1.text_.text = var_294_17

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_19 = 32 <= 0 and var_294_15 or var_294_15 * (utf8.len(var_294_17) / 32)

				if (32 <= 0 and var_294_15 or var_294_15 * (utf8.len(var_294_17) / 32)) > 0 and var_294_15 < var_294_19 then
					arg_291_1.talkMaxDuration = var_294_19
					var_294_14 = var_294_14 + 0.3

					if var_294_19 + var_294_14 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_14
					end
				end

				arg_291_1.text_.text = var_294_17
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_20 = var_294_14 + 0.3
			local var_294_21 = math.max(var_294_15, arg_291_1.talkMaxDuration)

			if var_294_14 + 0.3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_20 + var_294_21 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_20) / var_294_21

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_20 + var_294_21 and arg_291_1.time_ < var_294_20 + var_294_21 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play910201072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 910201072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play910201073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.625

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(910201072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 25 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 25)

				if (25 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 25)) > 0 and var_300_0 < var_300_3 then
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
	Play910201073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 910201073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play910201074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.2

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(910201073).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 8 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 8)

				if (8 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 8)) > 0 and var_304_0 < var_304_3 then
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
	Play910201074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 910201074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play910201075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.4

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(910201074).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 16 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 16)

				if (16 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 16)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play910201075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 910201075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play910201076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.275

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(910201075).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 11 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 11)

				if (11 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 11)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play910201076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 910201076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play910201077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if arg_313_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_316_0 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_313_1.stage_.transform)

				var_316_0.name = "1013ui_story"
				var_316_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1013ui_story"] = var_316_0

				local var_316_1 = var_316_0:GetComponentInChildren(typeof(CharacterEffect))

				var_316_1.enabled = true

				local var_316_2 = GameObjectTools.GetOrAddComponent(var_316_0, typeof(DynamicBoneHelper))

				if var_316_2 then
					var_316_2:EnableDynamicBone(false)
				end

				arg_313_1:ShowWeapon(var_316_1.transform, false)

				arg_313_1.var_["1013ui_story" .. "Animator"] = var_316_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_313_1.var_["1013ui_story" .. "Animator"].applyRootMotion = true
				arg_313_1.var_["1013ui_story" .. "LipSync"] = var_316_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_316_3 = arg_313_1.actors_["1013ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1013ui_story = var_316_3.localPosition
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_3.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_313_1.time_ - 0) / var_316_4)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_3.localPosition = Vector3.New(0, -0.66, -6.15)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action11_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_316_5 = arg_313_1.actors_["1013ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1013ui_story == nil then
				arg_313_1.var_.characterEffect1013ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.characterEffect1013ui_story and not isNil(var_316_5) then
					arg_313_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1013ui_story then
				arg_313_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_316_8 = 0
			local var_316_9 = 0.3

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(910201076).content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_12 = 12 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_10) / 12)

				if (12 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_10) / 12)) > 0 and var_316_9 < var_316_12 then
					arg_313_1.talkMaxDuration = var_316_12

					if var_316_12 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_13 and arg_313_1.time_ < var_316_8 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play910201077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 910201077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play910201078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1013ui_story"]) and arg_317_1.var_.characterEffect1013ui_story == nil then
				arg_317_1.var_.characterEffect1013ui_story = arg_317_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1013ui_story"]) then
				if arg_317_1.var_.characterEffect1013ui_story and not isNil(arg_317_1.actors_["1013ui_story"]) then
					arg_317_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1013ui_story"]) and arg_317_1.var_.characterEffect1013ui_story then
				arg_317_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(910201077).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 4 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 4)

				if (4 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 4)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play910201078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 910201078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play910201079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1013ui_story"]) and arg_321_1.var_.characterEffect1013ui_story == nil then
				arg_321_1.var_.characterEffect1013ui_story = arg_321_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1013ui_story"]) then
				if arg_321_1.var_.characterEffect1013ui_story and not isNil(arg_321_1.actors_["1013ui_story"]) then
					arg_321_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1013ui_story"]) and arg_321_1.var_.characterEffect1013ui_story then
				arg_321_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4112")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_324_2 = 0
			local var_324_3 = 0.85

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(910201078).content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_6 = 34 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_4) / 34)

				if (34 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_4) / 34)) > 0 and var_324_3 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_7 and arg_321_1.time_ < var_324_2 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play910201079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 910201079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play910201080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1013ui_story"]) and arg_325_1.var_.characterEffect1013ui_story == nil then
				arg_325_1.var_.characterEffect1013ui_story = arg_325_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1013ui_story"]) then
				if arg_325_1.var_.characterEffect1013ui_story and not isNil(arg_325_1.actors_["1013ui_story"]) then
					arg_325_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1013ui_story"]) and arg_325_1.var_.characterEffect1013ui_story then
				arg_325_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 0.6

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(910201079).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 24 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 24)

				if (24 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 24)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play910201080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 910201080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play910201081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1013ui_story"]) and arg_329_1.var_.characterEffect1013ui_story == nil then
				arg_329_1.var_.characterEffect1013ui_story = arg_329_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1013ui_story"]) then
				if arg_329_1.var_.characterEffect1013ui_story and not isNil(arg_329_1.actors_["1013ui_story"]) then
					arg_329_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1013ui_story"]) and arg_329_1.var_.characterEffect1013ui_story then
				arg_329_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_332_2 = 0
			local var_332_3 = 0.6

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_4 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(910201080).content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_6 = 24 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_4) / 24)

				if (24 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_4) / 24)) > 0 and var_332_3 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_7 and arg_329_1.time_ < var_332_2 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play910201081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 910201081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play910201082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1013ui_story"]) and arg_333_1.var_.characterEffect1013ui_story == nil then
				arg_333_1.var_.characterEffect1013ui_story = arg_333_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1013ui_story"]) then
				if arg_333_1.var_.characterEffect1013ui_story and not isNil(arg_333_1.actors_["1013ui_story"]) then
					arg_333_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1013ui_story"]) and arg_333_1.var_.characterEffect1013ui_story then
				arg_333_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1013ui_story.fillRatio = 0.5
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

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(910201081).content)

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
	Play910201082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 910201082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play910201083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.425

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(910201082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 17 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 17)

				if (17 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 17)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play910201083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 910201083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play910201084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.475

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(910201083).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 19 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 19)

				if (19 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 19)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play910201084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 910201084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play910201085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1013ui_story"]) and arg_345_1.var_.characterEffect1013ui_story == nil then
				arg_345_1.var_.characterEffect1013ui_story = arg_345_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1013ui_story"]) then
				if arg_345_1.var_.characterEffect1013ui_story and not isNil(arg_345_1.actors_["1013ui_story"]) then
					arg_345_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1013ui_story"]) and arg_345_1.var_.characterEffect1013ui_story then
				arg_345_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action452")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_348_2 = 0
			local var_348_3 = 0.775

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(910201084).content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_6 = 31 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 31)

				if (31 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 31)) > 0 and var_348_3 < var_348_6 then
					arg_345_1.talkMaxDuration = var_348_6

					if var_348_6 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_7 and arg_345_1.time_ < var_348_2 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play910201085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 910201085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play910201086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1013ui_story"]) and arg_349_1.var_.characterEffect1013ui_story == nil then
				arg_349_1.var_.characterEffect1013ui_story = arg_349_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1013ui_story"]) then
				if arg_349_1.var_.characterEffect1013ui_story and not isNil(arg_349_1.actors_["1013ui_story"]) then
					arg_349_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1013ui_story"]) and arg_349_1.var_.characterEffect1013ui_story then
				arg_349_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 0.225

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(910201085).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 9 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 9)

				if (9 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 9)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play910201086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 910201086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play910201087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.075

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(910201086).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 3 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 3)

				if (3 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 3)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play910201087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 910201087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play910201088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1013ui_story"]) and arg_357_1.var_.characterEffect1013ui_story == nil then
				arg_357_1.var_.characterEffect1013ui_story = arg_357_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1013ui_story"]) then
				if arg_357_1.var_.characterEffect1013ui_story and not isNil(arg_357_1.actors_["1013ui_story"]) then
					arg_357_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1013ui_story"]) and arg_357_1.var_.characterEffect1013ui_story then
				arg_357_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_360_2 = 0
			local var_360_3 = 0.35

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(910201087).content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_6 = 14 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 14)

				if (14 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 14)) > 0 and var_360_3 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_7 and arg_357_1.time_ < var_360_2 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play910201088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 910201088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play910201089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action454")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_364_0 = 0
			local var_364_1 = 0.65

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_2 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(910201088).content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 26 <= 0 and var_364_1 or var_364_1 * (utf8.len(var_364_2) / 26)

				if (26 <= 0 and var_364_1 or var_364_1 * (utf8.len(var_364_2) / 26)) > 0 and var_364_1 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_5 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_5 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_5

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_5 and arg_361_1.time_ < var_364_0 + var_364_5 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play910201089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 910201089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play910201090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1013ui_story"]) and arg_365_1.var_.characterEffect1013ui_story == nil then
				arg_365_1.var_.characterEffect1013ui_story = arg_365_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1013ui_story"]) then
				if arg_365_1.var_.characterEffect1013ui_story and not isNil(arg_365_1.actors_["1013ui_story"]) then
					arg_365_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_0)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1013ui_story"]) and arg_365_1.var_.characterEffect1013ui_story then
				arg_365_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_368_1 = 0
			local var_368_2 = 0.1

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(910201089).content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 4 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 4)

				if (4 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 4)) > 0 and var_368_2 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_1
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_6 = math.max(var_368_2, arg_365_1.talkMaxDuration)

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_6 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_1) / var_368_6

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_1 + var_368_6 and arg_365_1.time_ < var_368_1 + var_368_6 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play910201090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 910201090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play910201091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1013ui_story = arg_369_1.actors_["1013ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1013ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1013ui_story"].transform.position).z)
				arg_369_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1013ui_story"].transform.localEulerAngles = arg_369_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1013ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1013ui_story"].transform.position).z)
				arg_369_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1013ui_story"].transform.localEulerAngles = arg_369_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			local var_372_1 = 0
			local var_372_2 = 0.825

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(910201090).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 33 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 33)

				if (33 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 33)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play910201091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 910201091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play910201092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.2

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(910201091).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 8 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 8)

				if (8 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 8)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play910201092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 910201092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play910201093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.475

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(910201092).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 19 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 19)

				if (19 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 19)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play910201093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 910201093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play910201094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.625

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(910201093).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 25 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 25)

				if (25 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 25)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play910201094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 910201094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play910201095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if arg_385_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_388_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_385_1.stage_.transform)

				var_388_0.name = "1080ui_story"
				var_388_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.actors_["1080ui_story"] = var_388_0

				local var_388_1 = var_388_0:GetComponentInChildren(typeof(CharacterEffect))

				var_388_1.enabled = true

				local var_388_2 = GameObjectTools.GetOrAddComponent(var_388_0, typeof(DynamicBoneHelper))

				if var_388_2 then
					var_388_2:EnableDynamicBone(false)
				end

				arg_385_1:ShowWeapon(var_388_1.transform, false)

				arg_385_1.var_["1080ui_story" .. "Animator"] = var_388_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_385_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_385_1.var_["1080ui_story" .. "LipSync"] = var_388_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_388_3 = arg_385_1.actors_["1080ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1080ui_story = var_388_3.localPosition
			end

			local var_388_4 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				var_388_3.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_385_1.time_ - 0) / var_388_4)
				var_388_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_3.position).x, (manager.ui.mainCamera.transform.position - var_388_3.position).y, (manager.ui.mainCamera.transform.position - var_388_3.position).z)
				var_388_3.localEulerAngles.z = 0
				var_388_3.localEulerAngles.x = 0
				var_388_3.localEulerAngles = var_388_3.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				var_388_3.localPosition = Vector3.New(0, -1.01, -6.05)
				var_388_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_3.position).x, (manager.ui.mainCamera.transform.position - var_388_3.position).y, (manager.ui.mainCamera.transform.position - var_388_3.position).z)
				var_388_3.localEulerAngles.z = 0
				var_388_3.localEulerAngles.x = 0
				var_388_3.localEulerAngles = var_388_3.localEulerAngles
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_388_5 = arg_385_1.actors_["1080ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_5) and arg_385_1.var_.characterEffect1080ui_story == nil then
				arg_385_1.var_.characterEffect1080ui_story = var_388_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_6 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_6 and not isNil(var_388_5) then
				if arg_385_1.var_.characterEffect1080ui_story and not isNil(var_388_5) then
					arg_385_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_6 and arg_385_1.time_ < 0 + var_388_6 + arg_388_0 and not isNil(var_388_5) and arg_385_1.var_.characterEffect1080ui_story then
				arg_385_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_388_8 = 0
			local var_388_9 = 0.125

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_10 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(910201094).content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_12 = 5 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_10) / 5)

				if (5 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_10) / 5)) > 0 and var_388_9 < var_388_12 then
					arg_385_1.talkMaxDuration = var_388_12

					if var_388_12 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_12 + var_388_8
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_9, arg_385_1.talkMaxDuration)

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_8) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_8 + var_388_13 and arg_385_1.time_ < var_388_8 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play910201095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 910201095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play910201096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1080ui_story"]) and arg_389_1.var_.characterEffect1080ui_story == nil then
				arg_389_1.var_.characterEffect1080ui_story = arg_389_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1080ui_story"]) then
				if arg_389_1.var_.characterEffect1080ui_story and not isNil(arg_389_1.actors_["1080ui_story"]) then
					arg_389_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1080ui_story"]) and arg_389_1.var_.characterEffect1080ui_story then
				arg_389_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 0.25

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(910201095).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 10 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 10)

				if (10 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 10)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play910201096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 910201096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play910201097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1080ui_story"]) and arg_393_1.var_.characterEffect1080ui_story == nil then
				arg_393_1.var_.characterEffect1080ui_story = arg_393_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1080ui_story"]) then
				if arg_393_1.var_.characterEffect1080ui_story and not isNil(arg_393_1.actors_["1080ui_story"]) then
					arg_393_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1080ui_story"]) and arg_393_1.var_.characterEffect1080ui_story then
				arg_393_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action464")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_396_2 = 0
			local var_396_3 = 0.275

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(910201096).content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_6 = 11 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_4) / 11)

				if (11 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_4) / 11)) > 0 and var_396_3 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_7 and arg_393_1.time_ < var_396_2 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play910201097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 910201097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play910201098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1080ui_story"]) and arg_397_1.var_.characterEffect1080ui_story == nil then
				arg_397_1.var_.characterEffect1080ui_story = arg_397_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1080ui_story"]) then
				if arg_397_1.var_.characterEffect1080ui_story and not isNil(arg_397_1.actors_["1080ui_story"]) then
					arg_397_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1080ui_story"]) and arg_397_1.var_.characterEffect1080ui_story then
				arg_397_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_400_1 = 0
			local var_400_2 = 0.3

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(910201097).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 12 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 12)

				if (12 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 12)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play910201098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 910201098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play910201099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1080ui_story"]) and arg_401_1.var_.characterEffect1080ui_story == nil then
				arg_401_1.var_.characterEffect1080ui_story = arg_401_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1080ui_story"]) then
				if arg_401_1.var_.characterEffect1080ui_story and not isNil(arg_401_1.actors_["1080ui_story"]) then
					arg_401_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1080ui_story"]) and arg_401_1.var_.characterEffect1080ui_story then
				arg_401_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action446")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_404_2 = 0
			local var_404_3 = 0.1

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(910201098).content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 4 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 4)

				if (4 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 4)) > 0 and var_404_3 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_7 and arg_401_1.time_ < var_404_2 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play910201099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 910201099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play910201100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1080ui_story"]) and arg_405_1.var_.characterEffect1080ui_story == nil then
				arg_405_1.var_.characterEffect1080ui_story = arg_405_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1080ui_story"]) then
				if arg_405_1.var_.characterEffect1080ui_story and not isNil(arg_405_1.actors_["1080ui_story"]) then
					arg_405_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1080ui_story"]) and arg_405_1.var_.characterEffect1080ui_story then
				arg_405_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 0.45

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(910201099).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 18 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 18)

				if (18 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 18)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play910201100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 910201100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play910201101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1080ui_story"]) and arg_409_1.var_.characterEffect1080ui_story == nil then
				arg_409_1.var_.characterEffect1080ui_story = arg_409_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1080ui_story"]) then
				if arg_409_1.var_.characterEffect1080ui_story and not isNil(arg_409_1.actors_["1080ui_story"]) then
					arg_409_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1080ui_story"]) and arg_409_1.var_.characterEffect1080ui_story then
				arg_409_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action464")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_412_2 = 0
			local var_412_3 = 0.275

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(910201100).content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 11 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_4) / 11)

				if (11 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_4) / 11)) > 0 and var_412_3 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_7 and arg_409_1.time_ < var_412_2 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play910201101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 910201101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play910201102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1080ui_story"]) and arg_413_1.var_.characterEffect1080ui_story == nil then
				arg_413_1.var_.characterEffect1080ui_story = arg_413_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1080ui_story"]) then
				if arg_413_1.var_.characterEffect1080ui_story and not isNil(arg_413_1.actors_["1080ui_story"]) then
					arg_413_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1080ui_story"]) and arg_413_1.var_.characterEffect1080ui_story then
				arg_413_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 0.075

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(910201101).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 3 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 3)

				if (3 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 3)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play910201102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 910201102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play910201103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1080ui_story"]) and arg_417_1.var_.characterEffect1080ui_story == nil then
				arg_417_1.var_.characterEffect1080ui_story = arg_417_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1080ui_story"]) then
				if arg_417_1.var_.characterEffect1080ui_story and not isNil(arg_417_1.actors_["1080ui_story"]) then
					arg_417_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1080ui_story"]) and arg_417_1.var_.characterEffect1080ui_story then
				arg_417_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_420_2 = 0
			local var_420_3 = 0.175

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_2 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_4 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(910201102).content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_6 = 7 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_4) / 7)

				if (7 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_4) / 7)) > 0 and var_420_3 < var_420_6 then
					arg_417_1.talkMaxDuration = var_420_6

					if var_420_6 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_6 + var_420_2
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_7 = math.max(var_420_3, arg_417_1.talkMaxDuration)

			if var_420_2 <= arg_417_1.time_ and arg_417_1.time_ < var_420_2 + var_420_7 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_2) / var_420_7

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_2 + var_420_7 and arg_417_1.time_ < var_420_2 + var_420_7 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play910201103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 910201103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play910201104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1080ui_story"]) and arg_421_1.var_.characterEffect1080ui_story == nil then
				arg_421_1.var_.characterEffect1080ui_story = arg_421_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1080ui_story"]) then
				if arg_421_1.var_.characterEffect1080ui_story and not isNil(arg_421_1.actors_["1080ui_story"]) then
					arg_421_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1080ui_story"]) and arg_421_1.var_.characterEffect1080ui_story then
				arg_421_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0
			local var_424_2 = 0.375

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(910201103).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 15 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 15)

				if (15 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 15)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play910201104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 910201104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play910201105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1080ui_story"]) and arg_425_1.var_.characterEffect1080ui_story == nil then
				arg_425_1.var_.characterEffect1080ui_story = arg_425_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1080ui_story"]) then
				if arg_425_1.var_.characterEffect1080ui_story and not isNil(arg_425_1.actors_["1080ui_story"]) then
					arg_425_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1080ui_story"]) and arg_425_1.var_.characterEffect1080ui_story then
				arg_425_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action442")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_428_2 = 0
			local var_428_3 = 0.3

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_2 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_4 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(910201104).content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_6 = 12 <= 0 and var_428_3 or var_428_3 * (utf8.len(var_428_4) / 12)

				if (12 <= 0 and var_428_3 or var_428_3 * (utf8.len(var_428_4) / 12)) > 0 and var_428_3 < var_428_6 then
					arg_425_1.talkMaxDuration = var_428_6

					if var_428_6 + var_428_2 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_6 + var_428_2
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_3, arg_425_1.talkMaxDuration)

			if var_428_2 <= arg_425_1.time_ and arg_425_1.time_ < var_428_2 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_2) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_2 + var_428_7 and arg_425_1.time_ < var_428_2 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play910201105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 910201105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play910201106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1080ui_story"]) and arg_429_1.var_.characterEffect1080ui_story == nil then
				arg_429_1.var_.characterEffect1080ui_story = arg_429_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1080ui_story"]) then
				if arg_429_1.var_.characterEffect1080ui_story and not isNil(arg_429_1.actors_["1080ui_story"]) then
					arg_429_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_0)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1080ui_story"]) and arg_429_1.var_.characterEffect1080ui_story then
				arg_429_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_432_1 = 0
			local var_432_2 = 0.675

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(910201105).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 27 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 27)

				if (27 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 27)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play910201106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 910201106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play910201107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1080ui_story"]) and arg_433_1.var_.characterEffect1080ui_story == nil then
				arg_433_1.var_.characterEffect1080ui_story = arg_433_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1080ui_story"]) then
				if arg_433_1.var_.characterEffect1080ui_story and not isNil(arg_433_1.actors_["1080ui_story"]) then
					arg_433_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1080ui_story"]) and arg_433_1.var_.characterEffect1080ui_story then
				arg_433_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action424")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_436_2 = 0
			local var_436_3 = 0.125

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_2 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_4 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(910201106).content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_6 = 5 <= 0 and var_436_3 or var_436_3 * (utf8.len(var_436_4) / 5)

				if (5 <= 0 and var_436_3 or var_436_3 * (utf8.len(var_436_4) / 5)) > 0 and var_436_3 < var_436_6 then
					arg_433_1.talkMaxDuration = var_436_6

					if var_436_6 + var_436_2 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_6 + var_436_2
					end
				end

				arg_433_1.text_.text = var_436_4
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_3, arg_433_1.talkMaxDuration)

			if var_436_2 <= arg_433_1.time_ and arg_433_1.time_ < var_436_2 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_2) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_2 + var_436_7 and arg_433_1.time_ < var_436_2 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play910201107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 910201107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play910201108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1080ui_story"]) and arg_437_1.var_.characterEffect1080ui_story == nil then
				arg_437_1.var_.characterEffect1080ui_story = arg_437_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1080ui_story"]) then
				if arg_437_1.var_.characterEffect1080ui_story and not isNil(arg_437_1.actors_["1080ui_story"]) then
					arg_437_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1080ui_story"]) and arg_437_1.var_.characterEffect1080ui_story then
				arg_437_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.425

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(910201107).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 17 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 17)

				if (17 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 17)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play910201108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 910201108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play910201109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1080ui_story"]) and arg_441_1.var_.characterEffect1080ui_story == nil then
				arg_441_1.var_.characterEffect1080ui_story = arg_441_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1080ui_story"]) then
				if arg_441_1.var_.characterEffect1080ui_story and not isNil(arg_441_1.actors_["1080ui_story"]) then
					arg_441_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1080ui_story"]) and arg_441_1.var_.characterEffect1080ui_story then
				arg_441_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action446")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_444_2 = 0
			local var_444_3 = 0.4

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_4 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(910201108).content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_6 = 16 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_4) / 16)

				if (16 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_4) / 16)) > 0 and var_444_3 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_7 and arg_441_1.time_ < var_444_2 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play910201109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 910201109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play910201110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1080ui_story"]) and arg_445_1.var_.characterEffect1080ui_story == nil then
				arg_445_1.var_.characterEffect1080ui_story = arg_445_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1080ui_story"]) then
				if arg_445_1.var_.characterEffect1080ui_story and not isNil(arg_445_1.actors_["1080ui_story"]) then
					arg_445_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1080ui_story"]) and arg_445_1.var_.characterEffect1080ui_story then
				arg_445_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 0.8

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(910201109).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 32 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 32)

				if (32 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 32)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play910201110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 910201110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play910201111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1080ui_story = arg_449_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1080ui_story"].transform.position).z)
				arg_449_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1080ui_story"].transform.localEulerAngles = arg_449_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_449_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1080ui_story"].transform.position).z)
				arg_449_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1080ui_story"].transform.localEulerAngles = arg_449_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_452_1 = 0
			local var_452_2 = 0.775

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(910201110).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 31 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 31)

				if (31 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 31)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play910201111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 910201111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play910201112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.275

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(910201111).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 11 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 11)

				if (11 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 11)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play910201112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 910201112
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play910201113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.5

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(910201112).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 20 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 20)

				if (20 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 20)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play910201113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 910201113
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play910201114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.675

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(910201113).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 27 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 27)

				if (27 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 27)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play910201114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 910201114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play910201115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if arg_465_1.actors_["1096ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1096ui_story"))) then
				local var_468_0 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_465_1.stage_.transform)

				var_468_0.name = "1096ui_story"
				var_468_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.actors_["1096ui_story"] = var_468_0

				local var_468_1 = var_468_0:GetComponentInChildren(typeof(CharacterEffect))

				var_468_1.enabled = true

				local var_468_2 = GameObjectTools.GetOrAddComponent(var_468_0, typeof(DynamicBoneHelper))

				if var_468_2 then
					var_468_2:EnableDynamicBone(false)
				end

				arg_465_1:ShowWeapon(var_468_1.transform, false)

				arg_465_1.var_["1096ui_story" .. "Animator"] = var_468_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_465_1.var_["1096ui_story" .. "Animator"].applyRootMotion = true
				arg_465_1.var_["1096ui_story" .. "LipSync"] = var_468_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_468_3 = arg_465_1.actors_["1096ui_story"].transform

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1096ui_story = var_468_3.localPosition
			end

			local var_468_4 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				var_468_3.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_465_1.time_ - 0) / var_468_4)
				var_468_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_468_3.position).x, (manager.ui.mainCamera.transform.position - var_468_3.position).y, (manager.ui.mainCamera.transform.position - var_468_3.position).z)
				var_468_3.localEulerAngles.z = 0
				var_468_3.localEulerAngles.x = 0
				var_468_3.localEulerAngles = var_468_3.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				var_468_3.localPosition = Vector3.New(0, -1.13, -5.6)
				var_468_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_468_3.position).x, (manager.ui.mainCamera.transform.position - var_468_3.position).y, (manager.ui.mainCamera.transform.position - var_468_3.position).z)
				var_468_3.localEulerAngles.z = 0
				var_468_3.localEulerAngles.x = 0
				var_468_3.localEulerAngles = var_468_3.localEulerAngles
			end

			local var_468_5 = arg_465_1.actors_["1096ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_5) and arg_465_1.var_.characterEffect1096ui_story == nil then
				arg_465_1.var_.characterEffect1096ui_story = var_468_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_6 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_6 and not isNil(var_468_5) then
				if arg_465_1.var_.characterEffect1096ui_story and not isNil(var_468_5) then
					arg_465_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_6 and arg_465_1.time_ < 0 + var_468_6 + arg_468_0 and not isNil(var_468_5) and arg_465_1.var_.characterEffect1096ui_story then
				arg_465_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_468_8 = 0
			local var_468_9 = 0.125

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_8 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_10 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(910201114).content)

				arg_465_1.text_.text = var_468_10

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_12 = 5 <= 0 and var_468_9 or var_468_9 * (utf8.len(var_468_10) / 5)

				if (5 <= 0 and var_468_9 or var_468_9 * (utf8.len(var_468_10) / 5)) > 0 and var_468_9 < var_468_12 then
					arg_465_1.talkMaxDuration = var_468_12

					if var_468_12 + var_468_8 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_8
					end
				end

				arg_465_1.text_.text = var_468_10
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_13 = math.max(var_468_9, arg_465_1.talkMaxDuration)

			if var_468_8 <= arg_465_1.time_ and arg_465_1.time_ < var_468_8 + var_468_13 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_8) / var_468_13

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_8 + var_468_13 and arg_465_1.time_ < var_468_8 + var_468_13 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play910201115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 910201115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play910201116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1096ui_story"]) and arg_469_1.var_.characterEffect1096ui_story == nil then
				arg_469_1.var_.characterEffect1096ui_story = arg_469_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1096ui_story"]) then
				if arg_469_1.var_.characterEffect1096ui_story and not isNil(arg_469_1.actors_["1096ui_story"]) then
					arg_469_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1096ui_story"]) and arg_469_1.var_.characterEffect1096ui_story then
				arg_469_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.6

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(910201115).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 24 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 24)

				if (24 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 24)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play910201116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 910201116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play910201117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1096ui_story"]) and arg_473_1.var_.characterEffect1096ui_story == nil then
				arg_473_1.var_.characterEffect1096ui_story = arg_473_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1096ui_story"]) then
				if arg_473_1.var_.characterEffect1096ui_story and not isNil(arg_473_1.actors_["1096ui_story"]) then
					arg_473_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1096ui_story"]) and arg_473_1.var_.characterEffect1096ui_story then
				arg_473_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action434")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_476_2 = 0
			local var_476_3 = 0.45

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(910201116).content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 18 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 18)

				if (18 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 18)) > 0 and var_476_3 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_7 and arg_473_1.time_ < var_476_2 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play910201117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 910201117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play910201118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1096ui_story"]) and arg_477_1.var_.characterEffect1096ui_story == nil then
				arg_477_1.var_.characterEffect1096ui_story = arg_477_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1096ui_story"]) then
				if arg_477_1.var_.characterEffect1096ui_story and not isNil(arg_477_1.actors_["1096ui_story"]) then
					arg_477_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1096ui_story"]) and arg_477_1.var_.characterEffect1096ui_story then
				arg_477_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.425

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(910201117).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 17 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 17)

				if (17 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 17)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play910201118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 910201118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play910201119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1096ui_story"]) and arg_481_1.var_.characterEffect1096ui_story == nil then
				arg_481_1.var_.characterEffect1096ui_story = arg_481_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.2

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1096ui_story"]) then
				if arg_481_1.var_.characterEffect1096ui_story and not isNil(arg_481_1.actors_["1096ui_story"]) then
					arg_481_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1096ui_story"]) and arg_481_1.var_.characterEffect1096ui_story then
				arg_481_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action445")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_484_2 = 0
			local var_484_3 = 0.8

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(910201118).content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_6 = 32 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_4) / 32)

				if (32 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_4) / 32)) > 0 and var_484_3 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_7 and arg_481_1.time_ < var_484_2 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play910201119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 910201119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play910201120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action453")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_488_0 = 0
			local var_488_1 = 1.05

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_2 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(910201119).content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 42 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_2) / 42)

				if (42 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_2) / 42)) > 0 and var_488_1 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_5 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_5 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_5

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_5 and arg_485_1.time_ < var_488_0 + var_488_5 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play910201120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 910201120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play910201121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1096ui_story"]) and arg_489_1.var_.characterEffect1096ui_story == nil then
				arg_489_1.var_.characterEffect1096ui_story = arg_489_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1096ui_story"]) then
				if arg_489_1.var_.characterEffect1096ui_story and not isNil(arg_489_1.actors_["1096ui_story"]) then
					arg_489_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1096ui_story"]) and arg_489_1.var_.characterEffect1096ui_story then
				arg_489_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_492_1 = 0
			local var_492_2 = 0.425

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(910201120).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 17 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 17)

				if (17 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 17)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play910201121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 910201121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play910201122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["1096ui_story"]) and arg_493_1.var_.characterEffect1096ui_story == nil then
				arg_493_1.var_.characterEffect1096ui_story = arg_493_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_0 = 0.2

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["1096ui_story"]) then
				if arg_493_1.var_.characterEffect1096ui_story and not isNil(arg_493_1.actors_["1096ui_story"]) then
					arg_493_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["1096ui_story"]) and arg_493_1.var_.characterEffect1096ui_story then
				arg_493_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action432")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_496_2 = 0
			local var_496_3 = 0.775

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_4 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(910201121).content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_6 = 31 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_4) / 31)

				if (31 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_4) / 31)) > 0 and var_496_3 < var_496_6 then
					arg_493_1.talkMaxDuration = var_496_6

					if var_496_6 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_6 + var_496_2
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_3, arg_493_1.talkMaxDuration)

			if var_496_2 <= arg_493_1.time_ and arg_493_1.time_ < var_496_2 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_2) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_2 + var_496_7 and arg_493_1.time_ < var_496_2 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play910201122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 910201122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play910201123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action423")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_500_0 = 0
			local var_500_1 = 0.575

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_2 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(910201122).content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 23 <= 0 and var_500_1 or var_500_1 * (utf8.len(var_500_2) / 23)

				if (23 <= 0 and var_500_1 or var_500_1 * (utf8.len(var_500_2) / 23)) > 0 and var_500_1 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_5 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_5 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_5

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_5 and arg_497_1.time_ < var_500_0 + var_500_5 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play910201123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 910201123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play910201124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1096ui_story"]) and arg_501_1.var_.characterEffect1096ui_story == nil then
				arg_501_1.var_.characterEffect1096ui_story = arg_501_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.2

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1096ui_story"]) then
				if arg_501_1.var_.characterEffect1096ui_story and not isNil(arg_501_1.actors_["1096ui_story"]) then
					arg_501_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_0)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1096ui_story"]) and arg_501_1.var_.characterEffect1096ui_story then
				arg_501_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_504_1 = 0
			local var_504_2 = 0.575

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(910201123).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 23 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 23)

				if (23 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 23)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play910201124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 910201124
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play910201125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1096ui_story"]) and arg_505_1.var_.characterEffect1096ui_story == nil then
				arg_505_1.var_.characterEffect1096ui_story = arg_505_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1096ui_story"]) then
				if arg_505_1.var_.characterEffect1096ui_story and not isNil(arg_505_1.actors_["1096ui_story"]) then
					arg_505_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1096ui_story"]) and arg_505_1.var_.characterEffect1096ui_story then
				arg_505_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action434")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_508_2 = 0
			local var_508_3 = 0.625

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_2 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_4 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(910201124).content)

				arg_505_1.text_.text = var_508_4

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_6 = 25 <= 0 and var_508_3 or var_508_3 * (utf8.len(var_508_4) / 25)

				if (25 <= 0 and var_508_3 or var_508_3 * (utf8.len(var_508_4) / 25)) > 0 and var_508_3 < var_508_6 then
					arg_505_1.talkMaxDuration = var_508_6

					if var_508_6 + var_508_2 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_6 + var_508_2
					end
				end

				arg_505_1.text_.text = var_508_4
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_3, arg_505_1.talkMaxDuration)

			if var_508_2 <= arg_505_1.time_ and arg_505_1.time_ < var_508_2 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_2) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_2 + var_508_7 and arg_505_1.time_ < var_508_2 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play910201125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 910201125
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play910201126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["1096ui_story"]) and arg_509_1.var_.characterEffect1096ui_story == nil then
				arg_509_1.var_.characterEffect1096ui_story = arg_509_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_0 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["1096ui_story"]) then
				if arg_509_1.var_.characterEffect1096ui_story and not isNil(arg_509_1.actors_["1096ui_story"]) then
					arg_509_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_0)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["1096ui_story"]) and arg_509_1.var_.characterEffect1096ui_story then
				arg_509_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_512_1 = 0
			local var_512_2 = 0.9

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(910201125).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 36 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 36)

				if (36 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 36)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play910201126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 910201126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play910201127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.75

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(910201126).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 30 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 30)

				if (30 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 30)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play910201127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 910201127
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play910201128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1096ui_story"]) and arg_517_1.var_.characterEffect1096ui_story == nil then
				arg_517_1.var_.characterEffect1096ui_story = arg_517_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.2

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1096ui_story"]) then
				if arg_517_1.var_.characterEffect1096ui_story and not isNil(arg_517_1.actors_["1096ui_story"]) then
					arg_517_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1096ui_story"]) and arg_517_1.var_.characterEffect1096ui_story then
				arg_517_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action443")
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_520_2 = 0
			local var_520_3 = 0.225

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_4 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(910201127).content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_6 = 9 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_4) / 9)

				if (9 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_4) / 9)) > 0 and var_520_3 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_2
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_3, arg_517_1.talkMaxDuration)

			if var_520_2 <= arg_517_1.time_ and arg_517_1.time_ < var_520_2 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_2) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_2 + var_520_7 and arg_517_1.time_ < var_520_2 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play910201128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 910201128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play910201129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1096ui_story"]) and arg_521_1.var_.characterEffect1096ui_story == nil then
				arg_521_1.var_.characterEffect1096ui_story = arg_521_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1096ui_story"]) then
				if arg_521_1.var_.characterEffect1096ui_story and not isNil(arg_521_1.actors_["1096ui_story"]) then
					arg_521_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1096ui_story"]) and arg_521_1.var_.characterEffect1096ui_story then
				arg_521_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_524_1 = 0
			local var_524_2 = 0.75

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(910201128).content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 30 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 30)

				if (30 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 30)) > 0 and var_524_2 < var_524_5 then
					arg_521_1.talkMaxDuration = var_524_5

					if var_524_5 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + var_524_1
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_6 = math.max(var_524_2, arg_521_1.talkMaxDuration)

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_6 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_1) / var_524_6

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_1 + var_524_6 and arg_521_1.time_ < var_524_1 + var_524_6 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play910201129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 910201129
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play910201130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["1096ui_story"]) and arg_525_1.var_.characterEffect1096ui_story == nil then
				arg_525_1.var_.characterEffect1096ui_story = arg_525_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["1096ui_story"]) then
				if arg_525_1.var_.characterEffect1096ui_story and not isNil(arg_525_1.actors_["1096ui_story"]) then
					arg_525_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["1096ui_story"]) and arg_525_1.var_.characterEffect1096ui_story then
				arg_525_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action435")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_528_2 = 0
			local var_528_3 = 0.275

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_4 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(910201129).content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_6 = 11 <= 0 and var_528_3 or var_528_3 * (utf8.len(var_528_4) / 11)

				if (11 <= 0 and var_528_3 or var_528_3 * (utf8.len(var_528_4) / 11)) > 0 and var_528_3 < var_528_6 then
					arg_525_1.talkMaxDuration = var_528_6

					if var_528_6 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_6 + var_528_2
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_3, arg_525_1.talkMaxDuration)

			if var_528_2 <= arg_525_1.time_ and arg_525_1.time_ < var_528_2 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_2) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_2 + var_528_7 and arg_525_1.time_ < var_528_2 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play910201130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 910201130
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play910201131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1096ui_story"]) and arg_529_1.var_.characterEffect1096ui_story == nil then
				arg_529_1.var_.characterEffect1096ui_story = arg_529_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.2

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1096ui_story"]) then
				if arg_529_1.var_.characterEffect1096ui_story and not isNil(arg_529_1.actors_["1096ui_story"]) then
					arg_529_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_0)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1096ui_story"]) and arg_529_1.var_.characterEffect1096ui_story then
				arg_529_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_532_1 = 0
			local var_532_2 = 1.05

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(910201130).content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 42 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 42)

				if (42 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 42)) > 0 and var_532_2 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_1
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_6 = math.max(var_532_2, arg_529_1.talkMaxDuration)

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_6 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_1) / var_532_6

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_1 + var_532_6 and arg_529_1.time_ < var_532_1 + var_532_6 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play910201131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 910201131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play910201132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["1096ui_story"]) and arg_533_1.var_.characterEffect1096ui_story == nil then
				arg_533_1.var_.characterEffect1096ui_story = arg_533_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.2

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["1096ui_story"]) then
				if arg_533_1.var_.characterEffect1096ui_story and not isNil(arg_533_1.actors_["1096ui_story"]) then
					arg_533_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["1096ui_story"]) and arg_533_1.var_.characterEffect1096ui_story then
				arg_533_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action452")
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_536_2 = 0
			local var_536_3 = 0.8

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_2 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_4 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(910201131).content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_6 = 32 <= 0 and var_536_3 or var_536_3 * (utf8.len(var_536_4) / 32)

				if (32 <= 0 and var_536_3 or var_536_3 * (utf8.len(var_536_4) / 32)) > 0 and var_536_3 < var_536_6 then
					arg_533_1.talkMaxDuration = var_536_6

					if var_536_6 + var_536_2 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_6 + var_536_2
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_3, arg_533_1.talkMaxDuration)

			if var_536_2 <= arg_533_1.time_ and arg_533_1.time_ < var_536_2 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_2) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_2 + var_536_7 and arg_533_1.time_ < var_536_2 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play910201132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 910201132
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play910201133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action424")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_540_0 = 0
			local var_540_1 = 0.9

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_2 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(910201132).content)

				arg_537_1.text_.text = var_540_2

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 36 <= 0 and var_540_1 or var_540_1 * (utf8.len(var_540_2) / 36)

				if (36 <= 0 and var_540_1 or var_540_1 * (utf8.len(var_540_2) / 36)) > 0 and var_540_1 < var_540_4 then
					arg_537_1.talkMaxDuration = var_540_4

					if var_540_4 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_4 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_2
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_5 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_5 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_5

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_5 and arg_537_1.time_ < var_540_0 + var_540_5 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play910201133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 910201133
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play910201134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1096ui_story"]) and arg_541_1.var_.characterEffect1096ui_story == nil then
				arg_541_1.var_.characterEffect1096ui_story = arg_541_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_0 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1096ui_story"]) then
				if arg_541_1.var_.characterEffect1096ui_story and not isNil(arg_541_1.actors_["1096ui_story"]) then
					arg_541_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_541_1.time_ - 0) / var_544_0)
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1096ui_story"]) and arg_541_1.var_.characterEffect1096ui_story then
				arg_541_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_544_1 = 0
			local var_544_2 = 0.575

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(910201133).content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 23 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 23)

				if (23 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 23)) > 0 and var_544_2 < var_544_5 then
					arg_541_1.talkMaxDuration = var_544_5

					if var_544_5 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_6 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_6 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_6

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_6 and arg_541_1.time_ < var_544_1 + var_544_6 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play910201134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 910201134
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play910201135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0.45

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_1 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(910201134).content)

				arg_545_1.text_.text = var_548_1

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_3 = 18 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 18)

				if (18 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 18)) > 0 and var_548_0 < var_548_3 then
					arg_545_1.talkMaxDuration = var_548_3

					if var_548_3 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_3 + 0
					end
				end

				arg_545_1.text_.text = var_548_1
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_4 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_4

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play910201135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 910201135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play910201136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action445")
			end

			local var_552_0 = arg_549_1.actors_["1096ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect1096ui_story == nil then
				arg_549_1.var_.characterEffect1096ui_story = var_552_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_1 = 0.2

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_1 and not isNil(var_552_0) then
				if arg_549_1.var_.characterEffect1096ui_story and not isNil(var_552_0) then
					arg_549_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= 0 + var_552_1 and arg_549_1.time_ < 0 + var_552_1 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect1096ui_story then
				arg_549_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_552_3 = 0
			local var_552_4 = 0.4

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_3 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_5 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(910201135).content)

				arg_549_1.text_.text = var_552_5

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_7 = 16 <= 0 and var_552_4 or var_552_4 * (utf8.len(var_552_5) / 16)

				if (16 <= 0 and var_552_4 or var_552_4 * (utf8.len(var_552_5) / 16)) > 0 and var_552_4 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_3 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_3
					end
				end

				arg_549_1.text_.text = var_552_5
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_8 = math.max(var_552_4, arg_549_1.talkMaxDuration)

			if var_552_3 <= arg_549_1.time_ and arg_549_1.time_ < var_552_3 + var_552_8 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_3) / var_552_8

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_3 + var_552_8 and arg_549_1.time_ < var_552_3 + var_552_8 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play910201136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 910201136
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play910201137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1096ui_story"]) and arg_553_1.var_.characterEffect1096ui_story == nil then
				arg_553_1.var_.characterEffect1096ui_story = arg_553_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1096ui_story"]) then
				if arg_553_1.var_.characterEffect1096ui_story and not isNil(arg_553_1.actors_["1096ui_story"]) then
					arg_553_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_0)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1096ui_story"]) and arg_553_1.var_.characterEffect1096ui_story then
				arg_553_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_556_1 = 0
			local var_556_2 = 0.55

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_3 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(910201136).content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 22 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 22)

				if (22 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 22)) > 0 and var_556_2 < var_556_5 then
					arg_553_1.talkMaxDuration = var_556_5

					if var_556_5 + var_556_1 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + var_556_1
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_6 = math.max(var_556_2, arg_553_1.talkMaxDuration)

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_6 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_1) / var_556_6

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_1 + var_556_6 and arg_553_1.time_ < var_556_1 + var_556_6 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play910201137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 910201137
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play910201138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1096ui_story"]) and arg_557_1.var_.characterEffect1096ui_story == nil then
				arg_557_1.var_.characterEffect1096ui_story = arg_557_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1096ui_story"]) then
				if arg_557_1.var_.characterEffect1096ui_story and not isNil(arg_557_1.actors_["1096ui_story"]) then
					arg_557_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1096ui_story"]) and arg_557_1.var_.characterEffect1096ui_story then
				arg_557_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_560_2 = 0
			local var_560_3 = 0.8

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_2 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_4 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(910201137).content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_6 = 32 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_4) / 32)

				if (32 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_4) / 32)) > 0 and var_560_3 < var_560_6 then
					arg_557_1.talkMaxDuration = var_560_6

					if var_560_6 + var_560_2 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_2
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_3, arg_557_1.talkMaxDuration)

			if var_560_2 <= arg_557_1.time_ and arg_557_1.time_ < var_560_2 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_2) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_2 + var_560_7 and arg_557_1.time_ < var_560_2 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play910201138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 910201138
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play910201139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["1096ui_story"]) and arg_561_1.var_.characterEffect1096ui_story == nil then
				arg_561_1.var_.characterEffect1096ui_story = arg_561_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_0 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["1096ui_story"]) then
				if arg_561_1.var_.characterEffect1096ui_story and not isNil(arg_561_1.actors_["1096ui_story"]) then
					arg_561_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_561_1.time_ - 0) / var_564_0)
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["1096ui_story"]) and arg_561_1.var_.characterEffect1096ui_story then
				arg_561_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_564_1 = 0
			local var_564_2 = 0.5

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(910201138).content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 20 <= 0 and var_564_2 or var_564_2 * (utf8.len(var_564_3) / 20)

				if (20 <= 0 and var_564_2 or var_564_2 * (utf8.len(var_564_3) / 20)) > 0 and var_564_2 < var_564_5 then
					arg_561_1.talkMaxDuration = var_564_5

					if var_564_5 + var_564_1 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + var_564_1
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_6 = math.max(var_564_2, arg_561_1.talkMaxDuration)

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_6 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_1) / var_564_6

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_1 + var_564_6 and arg_561_1.time_ < var_564_1 + var_564_6 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play910201139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 910201139
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play910201140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1096ui_story"]) and arg_565_1.var_.characterEffect1096ui_story == nil then
				arg_565_1.var_.characterEffect1096ui_story = arg_565_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.2

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1096ui_story"]) then
				if arg_565_1.var_.characterEffect1096ui_story and not isNil(arg_565_1.actors_["1096ui_story"]) then
					arg_565_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1096ui_story"]) and arg_565_1.var_.characterEffect1096ui_story then
				arg_565_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action453")
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_568_2 = 0
			local var_568_3 = 1.075

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_2 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_4 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(910201139).content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_6 = 43 <= 0 and var_568_3 or var_568_3 * (utf8.len(var_568_4) / 43)

				if (43 <= 0 and var_568_3 or var_568_3 * (utf8.len(var_568_4) / 43)) > 0 and var_568_3 < var_568_6 then
					arg_565_1.talkMaxDuration = var_568_6

					if var_568_6 + var_568_2 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_6 + var_568_2
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_7 = math.max(var_568_3, arg_565_1.talkMaxDuration)

			if var_568_2 <= arg_565_1.time_ and arg_565_1.time_ < var_568_2 + var_568_7 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_2) / var_568_7

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_2 + var_568_7 and arg_565_1.time_ < var_568_2 + var_568_7 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play910201140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 910201140
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play910201141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["1096ui_story"]) and arg_569_1.var_.characterEffect1096ui_story == nil then
				arg_569_1.var_.characterEffect1096ui_story = arg_569_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_0 = 0.2

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["1096ui_story"]) then
				if arg_569_1.var_.characterEffect1096ui_story and not isNil(arg_569_1.actors_["1096ui_story"]) then
					arg_569_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_569_1.time_ - 0) / var_572_0)
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["1096ui_story"]) and arg_569_1.var_.characterEffect1096ui_story then
				arg_569_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_572_1 = 0
			local var_572_2 = 0.3

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_3 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(910201140).content)

				arg_569_1.text_.text = var_572_3

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 12 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 12)

				if (12 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 12)) > 0 and var_572_2 < var_572_5 then
					arg_569_1.talkMaxDuration = var_572_5

					if var_572_5 + var_572_1 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + var_572_1
					end
				end

				arg_569_1.text_.text = var_572_3
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_6 = math.max(var_572_2, arg_569_1.talkMaxDuration)

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_6 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_1) / var_572_6

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_1 + var_572_6 and arg_569_1.time_ < var_572_1 + var_572_6 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play910201141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 910201141
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play910201142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1096ui_story"]) and arg_573_1.var_.characterEffect1096ui_story == nil then
				arg_573_1.var_.characterEffect1096ui_story = arg_573_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.2

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1096ui_story"]) then
				if arg_573_1.var_.characterEffect1096ui_story and not isNil(arg_573_1.actors_["1096ui_story"]) then
					arg_573_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1096ui_story"]) and arg_573_1.var_.characterEffect1096ui_story then
				arg_573_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action435")
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_576_2 = 0
			local var_576_3 = 0.175

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_2 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_4 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(910201141).content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_6 = 7 <= 0 and var_576_3 or var_576_3 * (utf8.len(var_576_4) / 7)

				if (7 <= 0 and var_576_3 or var_576_3 * (utf8.len(var_576_4) / 7)) > 0 and var_576_3 < var_576_6 then
					arg_573_1.talkMaxDuration = var_576_6

					if var_576_6 + var_576_2 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_6 + var_576_2
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_7 = math.max(var_576_3, arg_573_1.talkMaxDuration)

			if var_576_2 <= arg_573_1.time_ and arg_573_1.time_ < var_576_2 + var_576_7 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_2) / var_576_7

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_2 + var_576_7 and arg_573_1.time_ < var_576_2 + var_576_7 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play910201142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 910201142
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play910201143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1096ui_story"]) and arg_577_1.var_.characterEffect1096ui_story == nil then
				arg_577_1.var_.characterEffect1096ui_story = arg_577_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.2

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1096ui_story"]) then
				if arg_577_1.var_.characterEffect1096ui_story and not isNil(arg_577_1.actors_["1096ui_story"]) then
					arg_577_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_0)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1096ui_story"]) and arg_577_1.var_.characterEffect1096ui_story then
				arg_577_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_580_1 = 0
			local var_580_2 = 0.075

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_3 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(910201142).content)

				arg_577_1.text_.text = var_580_3

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 3 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 3)

				if (3 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 3)) > 0 and var_580_2 < var_580_5 then
					arg_577_1.talkMaxDuration = var_580_5

					if var_580_5 + var_580_1 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + var_580_1
					end
				end

				arg_577_1.text_.text = var_580_3
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_6 = math.max(var_580_2, arg_577_1.talkMaxDuration)

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_6 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_1) / var_580_6

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_1 + var_580_6 and arg_577_1.time_ < var_580_1 + var_580_6 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play910201143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 910201143
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play910201144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["1096ui_story"]) and arg_581_1.var_.characterEffect1096ui_story == nil then
				arg_581_1.var_.characterEffect1096ui_story = arg_581_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_0 = 0.2

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["1096ui_story"]) then
				if arg_581_1.var_.characterEffect1096ui_story and not isNil(arg_581_1.actors_["1096ui_story"]) then
					arg_581_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["1096ui_story"]) and arg_581_1.var_.characterEffect1096ui_story then
				arg_581_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_584_2 = 0
			local var_584_3 = 0.325

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_2 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_4 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(910201143).content)

				arg_581_1.text_.text = var_584_4

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_6 = 13 <= 0 and var_584_3 or var_584_3 * (utf8.len(var_584_4) / 13)

				if (13 <= 0 and var_584_3 or var_584_3 * (utf8.len(var_584_4) / 13)) > 0 and var_584_3 < var_584_6 then
					arg_581_1.talkMaxDuration = var_584_6

					if var_584_6 + var_584_2 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_6 + var_584_2
					end
				end

				arg_581_1.text_.text = var_584_4
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_7 = math.max(var_584_3, arg_581_1.talkMaxDuration)

			if var_584_2 <= arg_581_1.time_ and arg_581_1.time_ < var_584_2 + var_584_7 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_2) / var_584_7

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_2 + var_584_7 and arg_581_1.time_ < var_584_2 + var_584_7 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play910201144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 910201144
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play910201145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action453")
			end

			local var_588_0 = 0
			local var_588_1 = 1.25

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_2 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(910201144).content)

				arg_585_1.text_.text = var_588_2

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 50 <= 0 and var_588_1 or var_588_1 * (utf8.len(var_588_2) / 50)

				if (50 <= 0 and var_588_1 or var_588_1 * (utf8.len(var_588_2) / 50)) > 0 and var_588_1 < var_588_4 then
					arg_585_1.talkMaxDuration = var_588_4

					if var_588_4 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_4 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_2
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_5 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_5 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_5

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_5 and arg_585_1.time_ < var_588_0 + var_588_5 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play910201145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 910201145
		arg_589_1.duration_ = 6.53

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play910201146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 1.966 < arg_589_1.time_ and arg_589_1.time_ <= 1.966 + arg_592_0 then
				arg_589_1.var_.moveOldPos1096ui_story = arg_589_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_592_0 = 0.001

			if 1.966 <= arg_589_1.time_ and arg_589_1.time_ < 1.966 + var_592_0 then
				arg_589_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_589_1.time_ - 1.966) / var_592_0)
				arg_589_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1096ui_story"].transform.position).z)
				arg_589_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1096ui_story"].transform.localEulerAngles = arg_589_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_589_1.time_ >= 1.966 + var_592_0 and arg_589_1.time_ < 1.966 + var_592_0 + arg_592_0 then
				arg_589_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_589_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1096ui_story"].transform.position).z)
				arg_589_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1096ui_story"].transform.localEulerAngles = arg_589_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_592_1 = 0

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.mask_.enabled = true
				arg_589_1.mask_.raycastTarget = true

				arg_589_1:SetGaussion(false)
			end

			local var_592_2 = 1.966

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 then
				local var_592_3 = Color.New(0, 0, 0)

				var_592_3.a = Mathf.Lerp(0, 1, (arg_589_1.time_ - var_592_1) / var_592_2)
				arg_589_1.mask_.color = var_592_3
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 then
				local var_592_4 = Color.New(0, 0, 0)

				var_592_4.a = 1
				arg_589_1.mask_.color = var_592_4
			end

			local var_592_5 = 1.966

			if 1.966 < arg_589_1.time_ and arg_589_1.time_ <= var_592_5 + arg_592_0 then
				arg_589_1.mask_.enabled = true
				arg_589_1.mask_.raycastTarget = true

				arg_589_1:SetGaussion(false)
			end

			local var_592_6 = 1.966

			if var_592_5 <= arg_589_1.time_ and arg_589_1.time_ < var_592_5 + var_592_6 then
				local var_592_7 = Color.New(0, 0, 0)

				var_592_7.a = Mathf.Lerp(1, 0, (arg_589_1.time_ - var_592_5) / var_592_6)
				arg_589_1.mask_.color = var_592_7
			end

			if arg_589_1.time_ >= var_592_5 + var_592_6 and arg_589_1.time_ < var_592_5 + var_592_6 + arg_592_0 then
				local var_592_8 = Color.New(0, 0, 0)

				arg_589_1.mask_.enabled = false
				var_592_8.a = 0
				arg_589_1.mask_.color = var_592_8
			end

			if 1.966 < arg_589_1.time_ and arg_589_1.time_ <= 1.966 + arg_592_0 then
				arg_589_1.fswbg_:SetActive(true)
				arg_589_1.dialog_:SetActive(false)

				arg_589_1.fswtw_.percent = 0
				arg_589_1.fswt_.text = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(910201145).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.fswt_)

				arg_589_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_589_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_589_1.fswtw_:SetDirty()

				arg_589_1.typewritterCharCountI18N = 0

				SetActive(arg_589_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_589_1:ShowNextGo(false)
			end

			local var_592_9 = 1.98266666666667

			if 1.98266666666667 < arg_589_1.time_ and arg_589_1.time_ <= var_592_9 + arg_592_0 then
				arg_589_1.var_.oldValueTypewriter = arg_589_1.fswtw_.percent

				SetActive(arg_589_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_589_1:ShowNextGo(false)
			end

			local var_592_10 = 14
			local var_592_11 = 0.933333333333333
			local var_592_12, var_592_13 = arg_589_1:GetPercentByPara(arg_589_1:FormatText(arg_589_1:GetWordFromCfg(910201145).content), 1)

			if var_592_9 < arg_589_1.time_ and arg_589_1.time_ <= var_592_9 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0

				local var_592_14 = var_592_10 <= 0 and var_592_11 or var_592_11 * ((var_592_13 - arg_589_1.typewritterCharCountI18N) / var_592_10)

				if (var_592_10 <= 0 and var_592_11 or var_592_11 * ((var_592_13 - arg_589_1.typewritterCharCountI18N) / var_592_10)) > 0 and var_592_11 < var_592_14 then
					arg_589_1.talkMaxDuration = var_592_14

					if var_592_14 + var_592_9 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_14 + var_592_9
					end
				end
			end

			local var_592_15 = math.max(0.933333333333333, arg_589_1.talkMaxDuration)

			if var_592_9 <= arg_589_1.time_ and arg_589_1.time_ < var_592_9 + var_592_15 then
				arg_589_1.fswtw_.percent = Mathf.Lerp(arg_589_1.var_.oldValueTypewriter, var_592_12, (arg_589_1.time_ - var_592_9) / var_592_15)
				arg_589_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_589_1.fswtw_:SetDirty()
			end

			if arg_589_1.time_ >= var_592_9 + var_592_15 and arg_589_1.time_ < var_592_9 + var_592_15 + arg_592_0 then
				arg_589_1.fswtw_.percent = var_592_12

				arg_589_1.fswtw_:SetDirty()
				arg_589_1:ShowNextGo(true)

				arg_589_1.typewritterCharCountI18N = var_592_13
			end

			if 1.966 < arg_589_1.time_ and arg_589_1.time_ <= 1.966 + arg_592_0 then
				local var_592_16 = arg_589_1.fswbg_.transform:Find("textbox/adapt/content") or arg_589_1.fswbg_.transform:Find("textbox/content")
				local var_592_17 = arg_589_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_592_18 = var_592_16:GetComponent("RectTransform")

				var_592_16:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_592_18.offsetMin = Vector2.New(0, 0)
				var_592_18.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play910201146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 910201146
		arg_593_1.duration_ = 1.33

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play910201147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.oldValueTypewriter = arg_593_1.fswtw_.percent

				SetActive(arg_593_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_593_1:ShowNextGo(false)
			end

			local var_596_0 = 34
			local var_596_1 = 1.33333333333333
			local var_596_2, var_596_3 = arg_593_1:GetPercentByPara(arg_593_1:FormatText(arg_593_1:GetWordFromCfg(910201145).content), 2)

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0

				local var_596_4 = var_596_0 <= 0 and var_596_1 or var_596_1 * ((var_596_3 - arg_593_1.typewritterCharCountI18N) / var_596_0)

				if (var_596_0 <= 0 and var_596_1 or var_596_1 * ((var_596_3 - arg_593_1.typewritterCharCountI18N) / var_596_0)) > 0 and var_596_1 < var_596_4 then
					arg_593_1.talkMaxDuration = var_596_4

					if var_596_4 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_4 + 0
					end
				end
			end

			local var_596_5 = math.max(1.33333333333333, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_5 then
				arg_593_1.fswtw_.percent = Mathf.Lerp(arg_593_1.var_.oldValueTypewriter, var_596_2, (arg_593_1.time_ - 0) / var_596_5)
				arg_593_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_593_1.fswtw_:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_5 and arg_593_1.time_ < 0 + var_596_5 + arg_596_0 then
				arg_593_1.fswtw_.percent = var_596_2

				arg_593_1.fswtw_:SetDirty()
				arg_593_1:ShowNextGo(true)

				arg_593_1.typewritterCharCountI18N = var_596_3
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play910201147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 910201147
		arg_597_1.duration_ = 1

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play910201148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.var_.oldValueTypewriter = arg_597_1.fswtw_.percent

				SetActive(arg_597_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_597_1:ShowNextGo(false)
			end

			local var_600_0 = 5
			local var_600_1 = 0.333333333333333
			local var_600_2, var_600_3 = arg_597_1:GetPercentByPara(arg_597_1:FormatText(arg_597_1:GetWordFromCfg(910201145).content), 3)

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0

				local var_600_4 = var_600_0 <= 0 and var_600_1 or var_600_1 * ((var_600_3 - arg_597_1.typewritterCharCountI18N) / var_600_0)

				if (var_600_0 <= 0 and var_600_1 or var_600_1 * ((var_600_3 - arg_597_1.typewritterCharCountI18N) / var_600_0)) > 0 and var_600_1 < var_600_4 then
					arg_597_1.talkMaxDuration = var_600_4

					if var_600_4 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_4 + 0
					end
				end
			end

			local var_600_5 = math.max(0.333333333333333, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_5 then
				arg_597_1.fswtw_.percent = Mathf.Lerp(arg_597_1.var_.oldValueTypewriter, var_600_2, (arg_597_1.time_ - 0) / var_600_5)
				arg_597_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_597_1.fswtw_:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_5 and arg_597_1.time_ < 0 + var_600_5 + arg_600_0 then
				arg_597_1.fswtw_.percent = var_600_2

				arg_597_1.fswtw_:SetDirty()
				arg_597_1:ShowNextGo(true)

				arg_597_1.typewritterCharCountI18N = var_600_3
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play910201148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 910201148
		arg_601_1.duration_ = 9

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play910201149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.mask_.enabled = true
				arg_601_1.mask_.raycastTarget = true

				arg_601_1:SetGaussion(false)
			end

			local var_604_0 = 2

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 then
				local var_604_1 = Color.New(0, 0, 0)

				var_604_1.a = Mathf.Lerp(0, 1, (arg_601_1.time_ - 0) / var_604_0)
				arg_601_1.mask_.color = var_604_1
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 then
				local var_604_2 = Color.New(0, 0, 0)

				var_604_2.a = 1
				arg_601_1.mask_.color = var_604_2
			end

			local var_604_3 = 2

			if 2 < arg_601_1.time_ and arg_601_1.time_ <= var_604_3 + arg_604_0 then
				arg_601_1.mask_.enabled = true
				arg_601_1.mask_.raycastTarget = true

				arg_601_1:SetGaussion(false)
			end

			local var_604_4 = 2

			if var_604_3 <= arg_601_1.time_ and arg_601_1.time_ < var_604_3 + var_604_4 then
				local var_604_5 = Color.New(0, 0, 0)

				var_604_5.a = Mathf.Lerp(1, 0, (arg_601_1.time_ - var_604_3) / var_604_4)
				arg_601_1.mask_.color = var_604_5
			end

			if arg_601_1.time_ >= var_604_3 + var_604_4 and arg_601_1.time_ < var_604_3 + var_604_4 + arg_604_0 then
				local var_604_6 = Color.New(0, 0, 0)

				arg_601_1.mask_.enabled = false
				var_604_6.a = 0
				arg_601_1.mask_.color = var_604_6
			end

			if 1.98333333333333 < arg_601_1.time_ and arg_601_1.time_ <= 1.98333333333333 + arg_604_0 then
				arg_601_1.fswbg_:SetActive(false)
				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_601_1:ShowNextGo(false)
			end

			if arg_601_1.frameCnt_ <= 1 then
				arg_601_1.dialog_:SetActive(false)
			end

			local var_604_7 = 4
			local var_604_8 = 0.5

			if 4 < arg_601_1.time_ and arg_601_1.time_ <= var_604_7 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0

				arg_601_1.dialog_:SetActive(true)

				arg_601_1.dialogCg_.alpha = 0

				local var_604_9 = LeanTween.value(arg_601_1.dialog_, 0, 1, 0.3)

				var_604_9:setOnUpdate(LuaHelper.FloatAction(function(arg_605_0)
					arg_601_1.dialogCg_.alpha = arg_605_0
				end))
				var_604_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_601_1.dialog_)
					var_604_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_601_1.duration_ = arg_601_1.duration_ + 0.3

				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_10 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(910201148).content)

				arg_601_1.text_.text = var_604_10

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_12 = 20 <= 0 and var_604_8 or var_604_8 * (utf8.len(var_604_10) / 20)

				if (20 <= 0 and var_604_8 or var_604_8 * (utf8.len(var_604_10) / 20)) > 0 and var_604_8 < var_604_12 then
					arg_601_1.talkMaxDuration = var_604_12
					var_604_7 = var_604_7 + 0.3

					if var_604_12 + var_604_7 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_12 + var_604_7
					end
				end

				arg_601_1.text_.text = var_604_10
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_13 = var_604_7 + 0.3
			local var_604_14 = math.max(var_604_8, arg_601_1.talkMaxDuration)

			if var_604_7 + 0.3 <= arg_601_1.time_ and arg_601_1.time_ < var_604_13 + var_604_14 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_13) / var_604_14

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_13 + var_604_14 and arg_601_1.time_ < var_604_13 + var_604_14 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play910201149 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 910201149
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play910201150(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["1096ui_story"]) and arg_607_1.var_.characterEffect1096ui_story == nil then
				arg_607_1.var_.characterEffect1096ui_story = arg_607_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_0 = 0.2

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["1096ui_story"]) then
				if arg_607_1.var_.characterEffect1096ui_story and not isNil(arg_607_1.actors_["1096ui_story"]) then
					arg_607_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["1096ui_story"]) and arg_607_1.var_.characterEffect1096ui_story then
				arg_607_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action432")
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_610_2 = arg_607_1.actors_["1096ui_story"].transform

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.var_.moveOldPos1096ui_story = var_610_2.localPosition
			end

			local var_610_3 = 0.001

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_3 then
				var_610_2.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_607_1.time_ - 0) / var_610_3)
				var_610_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_610_2.position).x, (manager.ui.mainCamera.transform.position - var_610_2.position).y, (manager.ui.mainCamera.transform.position - var_610_2.position).z)
				var_610_2.localEulerAngles.z = 0
				var_610_2.localEulerAngles.x = 0
				var_610_2.localEulerAngles = var_610_2.localEulerAngles
			end

			if arg_607_1.time_ >= 0 + var_610_3 and arg_607_1.time_ < 0 + var_610_3 + arg_610_0 then
				var_610_2.localPosition = Vector3.New(0, -1.13, -5.6)
				var_610_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_610_2.position).x, (manager.ui.mainCamera.transform.position - var_610_2.position).y, (manager.ui.mainCamera.transform.position - var_610_2.position).z)
				var_610_2.localEulerAngles.z = 0
				var_610_2.localEulerAngles.x = 0
				var_610_2.localEulerAngles = var_610_2.localEulerAngles
			end

			local var_610_4 = 0
			local var_610_5 = 0.25

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_6 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(910201149).content)

				arg_607_1.text_.text = var_610_6

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_8 = 10 <= 0 and var_610_5 or var_610_5 * (utf8.len(var_610_6) / 10)

				if (10 <= 0 and var_610_5 or var_610_5 * (utf8.len(var_610_6) / 10)) > 0 and var_610_5 < var_610_8 then
					arg_607_1.talkMaxDuration = var_610_8

					if var_610_8 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_8 + var_610_4
					end
				end

				arg_607_1.text_.text = var_610_6
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_9 = math.max(var_610_5, arg_607_1.talkMaxDuration)

			if var_610_4 <= arg_607_1.time_ and arg_607_1.time_ < var_610_4 + var_610_9 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_4) / var_610_9

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_4 + var_610_9 and arg_607_1.time_ < var_610_4 + var_610_9 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_607_1:InitPlayNodeList()
	end,
	Play910201150 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 910201150
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play910201151(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1096ui_story"]) and arg_611_1.var_.characterEffect1096ui_story == nil then
				arg_611_1.var_.characterEffect1096ui_story = arg_611_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1096ui_story"]) then
				if arg_611_1.var_.characterEffect1096ui_story and not isNil(arg_611_1.actors_["1096ui_story"]) then
					arg_611_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1096ui_story"]) and arg_611_1.var_.characterEffect1096ui_story then
				arg_611_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_614_1 = 0
			local var_614_2 = 0.75

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_3 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(910201150).content)

				arg_611_1.text_.text = var_614_3

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 30 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 30)

				if (30 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 30)) > 0 and var_614_2 < var_614_5 then
					arg_611_1.talkMaxDuration = var_614_5

					if var_614_5 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_5 + var_614_1
					end
				end

				arg_611_1.text_.text = var_614_3
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_6 = math.max(var_614_2, arg_611_1.talkMaxDuration)

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_6 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_1) / var_614_6

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_1 + var_614_6 and arg_611_1.time_ < var_614_1 + var_614_6 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play910201151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 910201151
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play910201152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0.725

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_1 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(910201151).content)

				arg_615_1.text_.text = var_618_1

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_3 = 29 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 29)

				if (29 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 29)) > 0 and var_618_0 < var_618_3 then
					arg_615_1.talkMaxDuration = var_618_3

					if var_618_3 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_3 + 0
					end
				end

				arg_615_1.text_.text = var_618_1
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_4 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_4 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_4

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_4 and arg_615_1.time_ < 0 + var_618_4 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play910201152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 910201152
		arg_619_1.duration_ = 9

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play910201153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if arg_619_1.bgs_.ST05 == nil then
				local var_622_0 = Object.Instantiate(arg_619_1.paintGo_)

				var_622_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05")
				var_622_0.name = "ST05"
				var_622_0.transform.parent = arg_619_1.stage_.transform
				var_622_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_619_1.bgs_.ST05 = var_622_0
			end

			if 2 < arg_619_1.time_ and arg_619_1.time_ <= 2 + arg_622_0 then
				local var_622_1 = arg_619_1.bgs_.ST05

				arg_619_1.bgs_.ST05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_622_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_622_2 = var_622_1:GetComponent("SpriteRenderer")

				if var_622_2 and var_622_2.sprite then
					local var_622_3 = 2 * (var_622_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_622_1.transform.localScale = Vector3.New(var_622_3 / var_622_2.sprite.bounds.size.y < var_622_3 * manager.ui.mainCameraCom_.aspect / var_622_2.sprite.bounds.size.x and var_622_3 * manager.ui.mainCameraCom_.aspect / var_622_2.sprite.bounds.size.x or var_622_3 / var_622_2.sprite.bounds.size.y, var_622_3 / var_622_2.sprite.bounds.size.y < var_622_3 * manager.ui.mainCameraCom_.aspect / var_622_2.sprite.bounds.size.x and var_622_3 * manager.ui.mainCameraCom_.aspect / var_622_2.sprite.bounds.size.x or var_622_3 / var_622_2.sprite.bounds.size.y, 0)
				end

				for iter_622_0, iter_622_1 in pairs(arg_619_1.bgs_) do
					if iter_622_0 ~= "ST05" then
						iter_622_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_622_4 = 0

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_4 + arg_622_0 then
				arg_619_1.mask_.enabled = true
				arg_619_1.mask_.raycastTarget = true

				arg_619_1:SetGaussion(false)
			end

			local var_622_5 = 2

			if var_622_4 <= arg_619_1.time_ and arg_619_1.time_ < var_622_4 + var_622_5 then
				local var_622_6 = Color.New(0, 0, 0)

				var_622_6.a = Mathf.Lerp(0, 1, (arg_619_1.time_ - var_622_4) / var_622_5)
				arg_619_1.mask_.color = var_622_6
			end

			if arg_619_1.time_ >= var_622_4 + var_622_5 and arg_619_1.time_ < var_622_4 + var_622_5 + arg_622_0 then
				local var_622_7 = Color.New(0, 0, 0)

				var_622_7.a = 1
				arg_619_1.mask_.color = var_622_7
			end

			local var_622_8 = 2

			if 2 < arg_619_1.time_ and arg_619_1.time_ <= var_622_8 + arg_622_0 then
				arg_619_1.mask_.enabled = true
				arg_619_1.mask_.raycastTarget = true

				arg_619_1:SetGaussion(false)
			end

			local var_622_9 = 2.166667

			if var_622_8 <= arg_619_1.time_ and arg_619_1.time_ < var_622_8 + var_622_9 then
				local var_622_10 = Color.New(0, 0, 0)

				var_622_10.a = Mathf.Lerp(1, 0, (arg_619_1.time_ - var_622_8) / var_622_9)
				arg_619_1.mask_.color = var_622_10
			end

			if arg_619_1.time_ >= var_622_8 + var_622_9 and arg_619_1.time_ < var_622_8 + var_622_9 + arg_622_0 then
				local var_622_11 = Color.New(0, 0, 0)

				arg_619_1.mask_.enabled = false
				var_622_11.a = 0
				arg_619_1.mask_.color = var_622_11
			end

			local var_622_12 = arg_619_1.actors_["1096ui_story"].transform

			if 1.966 < arg_619_1.time_ and arg_619_1.time_ <= 1.966 + arg_622_0 then
				arg_619_1.var_.moveOldPos1096ui_story = var_622_12.localPosition
			end

			local var_622_13 = 0.001

			if 1.966 <= arg_619_1.time_ and arg_619_1.time_ < 1.966 + var_622_13 then
				var_622_12.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_619_1.time_ - 1.966) / var_622_13)
				var_622_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_12.position).x, (manager.ui.mainCamera.transform.position - var_622_12.position).y, (manager.ui.mainCamera.transform.position - var_622_12.position).z)
				var_622_12.localEulerAngles.z = 0
				var_622_12.localEulerAngles.x = 0
				var_622_12.localEulerAngles = var_622_12.localEulerAngles
			end

			if arg_619_1.time_ >= 1.966 + var_622_13 and arg_619_1.time_ < 1.966 + var_622_13 + arg_622_0 then
				var_622_12.localPosition = Vector3.New(0, 100, 0)
				var_622_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_12.position).x, (manager.ui.mainCamera.transform.position - var_622_12.position).y, (manager.ui.mainCamera.transform.position - var_622_12.position).z)
				var_622_12.localEulerAngles.z = 0
				var_622_12.localEulerAngles.x = 0
				var_622_12.localEulerAngles = var_622_12.localEulerAngles
			end

			if 2 < arg_619_1.time_ and arg_619_1.time_ <= 2 + arg_622_0 then
				local var_622_14 = arg_619_1.bgs_.ST05:GetComponent("SpriteRenderer")

				if var_622_14 then
					arg_619_1.var_.alphaOldValueST05 = var_622_14.color.a
					arg_619_1.var_.alphaMatValueST05 = var_622_14
				end
			end

			local var_622_15 = 2.43333333333333

			if 2 <= arg_619_1.time_ and arg_619_1.time_ < 2 + var_622_15 then
				if arg_619_1.var_.alphaMatValueST05 then
					arg_619_1.var_.alphaMatValueST05.color.a = Mathf.Lerp(arg_619_1.var_.alphaOldValueST05, 0.5, (arg_619_1.time_ - 2) / var_622_15)
					arg_619_1.var_.alphaMatValueST05.color = arg_619_1.var_.alphaMatValueST05.color
				end
			end

			if arg_619_1.time_ >= 2 + var_622_15 and arg_619_1.time_ < 2 + var_622_15 + arg_622_0 and arg_619_1.var_.alphaMatValueST05 then
				arg_619_1.var_.alphaMatValueST05.color.a = 0.5
				arg_619_1.var_.alphaMatValueST05.color = arg_619_1.var_.alphaMatValueST05.color
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_622_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_619_1.bgmTxt_.text ~= var_622_18 and arg_619_1.bgmTxt_.text ~= "" then
						if arg_619_1.bgmTxt2_.text ~= "" then
							arg_619_1.bgmTxt_.text = arg_619_1.bgmTxt2_.text
						end

						arg_619_1.bgmTxt2_.text = var_622_18

						arg_619_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_619_1.bgmTxt_.text = var_622_18
						arg_619_1.bgmTxt2_.text = var_622_18
					end

					if arg_619_1.bgmTimer then
						arg_619_1.bgmTimer:Stop()

						arg_619_1.bgmTimer = nil
					end

					if arg_619_1.settingData.show_music_name == 1 then
						arg_619_1.musicController:SetSelectedState("show")
						arg_619_1.musicAnimator_:Play("open", 0, 0)

						if arg_619_1.settingData.music_time ~= 0 then
							arg_619_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_619_1.settingData.music_time), function()
								if arg_619_1 == nil or isNil(arg_619_1.bgmTxt_) then
									return
								end

								arg_619_1.musicController:SetSelectedState("hide")
								arg_619_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_622_19 = 4
			local var_622_20 = 0.975

			if 4 < arg_619_1.time_ and arg_619_1.time_ <= var_622_19 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_21 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(910201152).content)

				arg_619_1.text_.text = var_622_21

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_23 = 39 <= 0 and var_622_20 or var_622_20 * (utf8.len(var_622_21) / 39)

				if (39 <= 0 and var_622_20 or var_622_20 * (utf8.len(var_622_21) / 39)) > 0 and var_622_20 < var_622_23 then
					arg_619_1.talkMaxDuration = var_622_23

					if var_622_23 + var_622_19 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_23 + var_622_19
					end
				end

				arg_619_1.text_.text = var_622_21
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_24 = math.max(var_622_20, arg_619_1.talkMaxDuration)

			if var_622_19 <= arg_619_1.time_ and arg_619_1.time_ < var_622_19 + var_622_24 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_19) / var_622_24

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_19 + var_622_24 and arg_619_1.time_ < var_622_19 + var_622_24 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play910201153 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 910201153
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play910201154(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0.3

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_1 = arg_624_1:FormatText(arg_624_1:GetWordFromCfg(910201153).content)

				arg_624_1.text_.text = var_627_1

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_3 = 12 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_1) / 12)

				if (12 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_1) / 12)) > 0 and var_627_0 < var_627_3 then
					arg_624_1.talkMaxDuration = var_627_3

					if var_627_3 + 0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_3 + 0
					end
				end

				arg_624_1.text_.text = var_627_1
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_4 = math.max(var_627_0, arg_624_1.talkMaxDuration)

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_4 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - 0) / var_627_4

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= 0 + var_627_4 and arg_624_1.time_ < 0 + var_627_4 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play910201154 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 910201154
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play910201155(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1.var_.moveOldPos1096ui_story = arg_628_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_631_0 = 0.001

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 then
				arg_628_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_628_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_628_1.time_ - 0) / var_631_0)
				arg_628_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_628_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1096ui_story"].transform.position).z)
				arg_628_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_628_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_628_1.actors_["1096ui_story"].transform.localEulerAngles = arg_628_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 then
				arg_628_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, -1.13, -5.6)
				arg_628_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_628_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1096ui_story"].transform.position).z)
				arg_628_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_628_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_628_1.actors_["1096ui_story"].transform.localEulerAngles = arg_628_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_1")
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_631_1 = arg_628_1.actors_["1096ui_story"]

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(var_631_1) and arg_628_1.var_.characterEffect1096ui_story == nil then
				arg_628_1.var_.characterEffect1096ui_story = var_631_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_2 = 0.2

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_2 and not isNil(var_631_1) then
				if arg_628_1.var_.characterEffect1096ui_story and not isNil(var_631_1) then
					arg_628_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= 0 + var_631_2 and arg_628_1.time_ < 0 + var_631_2 + arg_631_0 and not isNil(var_631_1) and arg_628_1.var_.characterEffect1096ui_story then
				arg_628_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_631_4 = 0
			local var_631_5 = 0.5

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_4 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_6 = arg_628_1:FormatText(arg_628_1:GetWordFromCfg(910201154).content)

				arg_628_1.text_.text = var_631_6

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_8 = 20 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_6) / 20)

				if (20 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_6) / 20)) > 0 and var_631_5 < var_631_8 then
					arg_628_1.talkMaxDuration = var_631_8

					if var_631_8 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_8 + var_631_4
					end
				end

				arg_628_1.text_.text = var_631_6
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_9 = math.max(var_631_5, arg_628_1.talkMaxDuration)

			if var_631_4 <= arg_628_1.time_ and arg_628_1.time_ < var_631_4 + var_631_9 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_4) / var_631_9

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_4 + var_631_9 and arg_628_1.time_ < var_631_4 + var_631_9 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_628_1:InitPlayNodeList()
	end,
	Play910201155 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 910201155
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play910201156(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 and not isNil(arg_632_1.actors_["1096ui_story"]) and arg_632_1.var_.characterEffect1096ui_story == nil then
				arg_632_1.var_.characterEffect1096ui_story = arg_632_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_0 = 0.2

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_0 and not isNil(arg_632_1.actors_["1096ui_story"]) then
				if arg_632_1.var_.characterEffect1096ui_story and not isNil(arg_632_1.actors_["1096ui_story"]) then
					arg_632_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_632_1.time_ - 0) / var_635_0)
				end
			end

			if arg_632_1.time_ >= 0 + var_635_0 and arg_632_1.time_ < 0 + var_635_0 + arg_635_0 and not isNil(arg_632_1.actors_["1096ui_story"]) and arg_632_1.var_.characterEffect1096ui_story then
				arg_632_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_635_1 = 0
			local var_635_2 = 0.575

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_3 = arg_632_1:FormatText(arg_632_1:GetWordFromCfg(910201155).content)

				arg_632_1.text_.text = var_635_3

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 23 <= 0 and var_635_2 or var_635_2 * (utf8.len(var_635_3) / 23)

				if (23 <= 0 and var_635_2 or var_635_2 * (utf8.len(var_635_3) / 23)) > 0 and var_635_2 < var_635_5 then
					arg_632_1.talkMaxDuration = var_635_5

					if var_635_5 + var_635_1 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_5 + var_635_1
					end
				end

				arg_632_1.text_.text = var_635_3
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_6 = math.max(var_635_2, arg_632_1.talkMaxDuration)

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_6 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_1) / var_635_6

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_1 + var_635_6 and arg_632_1.time_ < var_635_1 + var_635_6 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play910201156 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 910201156
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play910201157(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 and not isNil(arg_636_1.actors_["1096ui_story"]) and arg_636_1.var_.characterEffect1096ui_story == nil then
				arg_636_1.var_.characterEffect1096ui_story = arg_636_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_0 = 0.2

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_0 and not isNil(arg_636_1.actors_["1096ui_story"]) then
				if arg_636_1.var_.characterEffect1096ui_story and not isNil(arg_636_1.actors_["1096ui_story"]) then
					arg_636_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= 0 + var_639_0 and arg_636_1.time_ < 0 + var_639_0 + arg_639_0 and not isNil(arg_636_1.actors_["1096ui_story"]) and arg_636_1.var_.characterEffect1096ui_story then
				arg_636_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action452")
			end

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_639_2 = 0
			local var_639_3 = 0.35

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_2 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				arg_636_1.leftNameTxt_.text = arg_636_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_4 = arg_636_1:FormatText(arg_636_1:GetWordFromCfg(910201156).content)

				arg_636_1.text_.text = var_639_4

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_6 = 14 <= 0 and var_639_3 or var_639_3 * (utf8.len(var_639_4) / 14)

				if (14 <= 0 and var_639_3 or var_639_3 * (utf8.len(var_639_4) / 14)) > 0 and var_639_3 < var_639_6 then
					arg_636_1.talkMaxDuration = var_639_6

					if var_639_6 + var_639_2 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_6 + var_639_2
					end
				end

				arg_636_1.text_.text = var_639_4
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_7 = math.max(var_639_3, arg_636_1.talkMaxDuration)

			if var_639_2 <= arg_636_1.time_ and arg_636_1.time_ < var_639_2 + var_639_7 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_2) / var_639_7

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_2 + var_639_7 and arg_636_1.time_ < var_639_2 + var_639_7 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play910201157 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 910201157
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play910201158(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 and not isNil(arg_640_1.actors_["1096ui_story"]) and arg_640_1.var_.characterEffect1096ui_story == nil then
				arg_640_1.var_.characterEffect1096ui_story = arg_640_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_0 = 0.2

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_0 and not isNil(arg_640_1.actors_["1096ui_story"]) then
				if arg_640_1.var_.characterEffect1096ui_story and not isNil(arg_640_1.actors_["1096ui_story"]) then
					arg_640_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_640_1.time_ - 0) / var_643_0)
				end
			end

			if arg_640_1.time_ >= 0 + var_643_0 and arg_640_1.time_ < 0 + var_643_0 + arg_643_0 and not isNil(arg_640_1.actors_["1096ui_story"]) and arg_640_1.var_.characterEffect1096ui_story then
				arg_640_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_643_1 = 0
			local var_643_2 = 0.35

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				arg_640_1.leftNameTxt_.text = arg_640_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, true)
				arg_640_1.iconController_:SetSelectedState("hero")

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_3 = arg_640_1:FormatText(arg_640_1:GetWordFromCfg(910201157).content)

				arg_640_1.text_.text = var_643_3

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_5 = 14 <= 0 and var_643_2 or var_643_2 * (utf8.len(var_643_3) / 14)

				if (14 <= 0 and var_643_2 or var_643_2 * (utf8.len(var_643_3) / 14)) > 0 and var_643_2 < var_643_5 then
					arg_640_1.talkMaxDuration = var_643_5

					if var_643_5 + var_643_1 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_5 + var_643_1
					end
				end

				arg_640_1.text_.text = var_643_3
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_6 = math.max(var_643_2, arg_640_1.talkMaxDuration)

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_6 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_1) / var_643_6

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_1 + var_643_6 and arg_640_1.time_ < var_643_1 + var_643_6 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play910201158 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 910201158
		arg_644_1.duration_ = 7

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play910201159(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.mask_.enabled = true
				arg_644_1.mask_.raycastTarget = true

				arg_644_1:SetGaussion(false)
			end

			local var_647_0 = 2

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_0 then
				local var_647_1 = Color.New(1, 1, 1)

				var_647_1.a = Mathf.Lerp(1, 0, (arg_644_1.time_ - 0) / var_647_0)
				arg_644_1.mask_.color = var_647_1
			end

			if arg_644_1.time_ >= 0 + var_647_0 and arg_644_1.time_ < 0 + var_647_0 + arg_647_0 then
				local var_647_2 = Color.New(1, 1, 1)

				arg_644_1.mask_.enabled = false
				var_647_2.a = 0
				arg_644_1.mask_.color = var_647_2
			end

			local var_647_3 = arg_644_1.actors_["1096ui_story"].transform

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.var_.moveOldPos1096ui_story = var_647_3.localPosition
			end

			local var_647_4 = 0.001

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_4 then
				var_647_3.localPosition = Vector3.Lerp(arg_644_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_644_1.time_ - 0) / var_647_4)
				var_647_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_647_3.position).x, (manager.ui.mainCamera.transform.position - var_647_3.position).y, (manager.ui.mainCamera.transform.position - var_647_3.position).z)
				var_647_3.localEulerAngles.z = 0
				var_647_3.localEulerAngles.x = 0
				var_647_3.localEulerAngles = var_647_3.localEulerAngles
			end

			if arg_644_1.time_ >= 0 + var_647_4 and arg_644_1.time_ < 0 + var_647_4 + arg_647_0 then
				var_647_3.localPosition = Vector3.New(0, 100, 0)
				var_647_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_647_3.position).x, (manager.ui.mainCamera.transform.position - var_647_3.position).y, (manager.ui.mainCamera.transform.position - var_647_3.position).z)
				var_647_3.localEulerAngles.z = 0
				var_647_3.localEulerAngles.x = 0
				var_647_3.localEulerAngles = var_647_3.localEulerAngles
			end

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				local var_647_5 = arg_644_1.bgs_.ST05:GetComponent("SpriteRenderer")

				if var_647_5 then
					arg_644_1.var_.alphaOldValueST05 = var_647_5.color.a
					arg_644_1.var_.alphaMatValueST05 = var_647_5
				end

				arg_644_1.var_.alphaOldValueST05 = 0
			end

			local var_647_6 = 3.2

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_6 then
				if arg_644_1.var_.alphaMatValueST05 then
					arg_644_1.var_.alphaMatValueST05.color.a = Mathf.Lerp(arg_644_1.var_.alphaOldValueST05, 1, (arg_644_1.time_ - 0) / var_647_6)
					arg_644_1.var_.alphaMatValueST05.color = arg_644_1.var_.alphaMatValueST05.color
				end
			end

			if arg_644_1.time_ >= 0 + var_647_6 and arg_644_1.time_ < 0 + var_647_6 + arg_647_0 and arg_644_1.var_.alphaMatValueST05 then
				arg_644_1.var_.alphaMatValueST05.color.a = 1
				arg_644_1.var_.alphaMatValueST05.color = arg_644_1.var_.alphaMatValueST05.color
			end

			local var_647_7 = 2
			local var_647_8 = 0.075

			if 2 < arg_644_1.time_ and arg_644_1.time_ <= var_647_7 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, false)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_9 = arg_644_1:FormatText(arg_644_1:GetWordFromCfg(910201158).content)

				arg_644_1.text_.text = var_647_9

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_11 = 3 <= 0 and var_647_8 or var_647_8 * (utf8.len(var_647_9) / 3)

				if (3 <= 0 and var_647_8 or var_647_8 * (utf8.len(var_647_9) / 3)) > 0 and var_647_8 < var_647_11 then
					arg_644_1.talkMaxDuration = var_647_11

					if var_647_11 + var_647_7 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_11 + var_647_7
					end
				end

				arg_644_1.text_.text = var_647_9
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_12 = math.max(var_647_8, arg_644_1.talkMaxDuration)

			if var_647_7 <= arg_644_1.time_ and arg_644_1.time_ < var_647_7 + var_647_12 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_7) / var_647_12

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_7 + var_647_12 and arg_644_1.time_ < var_647_7 + var_647_12 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_644_1:InitPlayNodeList()
	end,
	Play910201159 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 910201159
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play910201160(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0.35

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				arg_648_1.leftNameTxt_.text = arg_648_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, true)
				arg_648_1.iconController_:SetSelectedState("hero")

				arg_648_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_648_1.callingController_:SetSelectedState("normal")

				arg_648_1.keyicon_.color = Color.New(1, 1, 1)
				arg_648_1.icon_.color = Color.New(1, 1, 1)

				local var_651_1 = arg_648_1:FormatText(arg_648_1:GetWordFromCfg(910201159).content)

				arg_648_1.text_.text = var_651_1

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_3 = 14 <= 0 and var_651_0 or var_651_0 * (utf8.len(var_651_1) / 14)

				if (14 <= 0 and var_651_0 or var_651_0 * (utf8.len(var_651_1) / 14)) > 0 and var_651_0 < var_651_3 then
					arg_648_1.talkMaxDuration = var_651_3

					if var_651_3 + 0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_3 + 0
					end
				end

				arg_648_1.text_.text = var_651_1
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_4 = math.max(var_651_0, arg_648_1.talkMaxDuration)

			if 0 <= arg_648_1.time_ and arg_648_1.time_ < 0 + var_651_4 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - 0) / var_651_4

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= 0 + var_651_4 and arg_648_1.time_ < 0 + var_651_4 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play910201160 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 910201160
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play910201161(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.mask_.enabled = true
				arg_652_1.mask_.raycastTarget = true

				arg_652_1:SetGaussion(false)
			end

			local var_655_0 = 2

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_0 then
				local var_655_1 = Color.New(1, 1, 1)

				var_655_1.a = Mathf.Lerp(1, 0, (arg_652_1.time_ - 0) / var_655_0)
				arg_652_1.mask_.color = var_655_1
			end

			if arg_652_1.time_ >= 0 + var_655_0 and arg_652_1.time_ < 0 + var_655_0 + arg_655_0 then
				local var_655_2 = Color.New(1, 1, 1)

				arg_652_1.mask_.enabled = false
				var_655_2.a = 0
				arg_652_1.mask_.color = var_655_2
			end

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:AudioAction("play", "effect", "se_story_birthday", "se_story_birthday_kaideng", "")
			end

			local var_655_4 = 0
			local var_655_5 = 0.075

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_4 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_6 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(910201160).content)

				arg_652_1.text_.text = var_655_6

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_8 = 3 <= 0 and var_655_5 or var_655_5 * (utf8.len(var_655_6) / 3)

				if (3 <= 0 and var_655_5 or var_655_5 * (utf8.len(var_655_6) / 3)) > 0 and var_655_5 < var_655_8 then
					arg_652_1.talkMaxDuration = var_655_8

					if var_655_8 + var_655_4 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_8 + var_655_4
					end
				end

				arg_652_1.text_.text = var_655_6
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_9 = math.max(var_655_5, arg_652_1.talkMaxDuration)

			if var_655_4 <= arg_652_1.time_ and arg_652_1.time_ < var_655_4 + var_655_9 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_4) / var_655_9

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_4 + var_655_9 and arg_652_1.time_ < var_655_4 + var_655_9 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play910201161 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 910201161
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play910201162(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1:AudioAction("play", "effect", "se_story_birthday", "se_story_birthday_lapao", "")
			end

			local var_659_1 = 0
			local var_659_2 = 0.1

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, false)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_3 = arg_656_1:FormatText(arg_656_1:GetWordFromCfg(910201161).content)

				arg_656_1.text_.text = var_659_3

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_5 = 4 <= 0 and var_659_2 or var_659_2 * (utf8.len(var_659_3) / 4)

				if (4 <= 0 and var_659_2 or var_659_2 * (utf8.len(var_659_3) / 4)) > 0 and var_659_2 < var_659_5 then
					arg_656_1.talkMaxDuration = var_659_5

					if var_659_5 + var_659_1 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_5 + var_659_1
					end
				end

				arg_656_1.text_.text = var_659_3
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_6 = math.max(var_659_2, arg_656_1.talkMaxDuration)

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_6 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_1) / var_659_6

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_1 + var_659_6 and arg_656_1.time_ < var_659_1 + var_659_6 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play910201162 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 910201162
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play910201163(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0.2

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				arg_660_1.leftNameTxt_.text = arg_660_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_1 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(910201162).content)

				arg_660_1.text_.text = var_663_1

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_3 = 8 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_1) / 8)

				if (8 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_1) / 8)) > 0 and var_663_0 < var_663_3 then
					arg_660_1.talkMaxDuration = var_663_3

					if var_663_3 + 0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_3 + 0
					end
				end

				arg_660_1.text_.text = var_663_1
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_4 = math.max(var_663_0, arg_660_1.talkMaxDuration)

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_4 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - 0) / var_663_4

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= 0 + var_663_4 and arg_660_1.time_ < 0 + var_663_4 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play910201163 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 910201163
		arg_664_1.duration_ = 5

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play910201164(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_667_2 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_664_1.bgmTxt_.text ~= var_667_2 and arg_664_1.bgmTxt_.text ~= "" then
						if arg_664_1.bgmTxt2_.text ~= "" then
							arg_664_1.bgmTxt_.text = arg_664_1.bgmTxt2_.text
						end

						arg_664_1.bgmTxt2_.text = var_667_2

						arg_664_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_664_1.bgmTxt_.text = var_667_2
						arg_664_1.bgmTxt2_.text = var_667_2
					end

					if arg_664_1.bgmTimer then
						arg_664_1.bgmTimer:Stop()

						arg_664_1.bgmTimer = nil
					end

					if arg_664_1.settingData.show_music_name == 1 then
						arg_664_1.musicController:SetSelectedState("show")
						arg_664_1.musicAnimator_:Play("open", 0, 0)

						if arg_664_1.settingData.music_time ~= 0 then
							arg_664_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_664_1.settingData.music_time), function()
								if arg_664_1 == nil or isNil(arg_664_1.bgmTxt_) then
									return
								end

								arg_664_1.musicController:SetSelectedState("hide")
								arg_664_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_667_3 = 0
			local var_667_4 = 0.2

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_3 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				arg_664_1.leftNameTxt_.text = arg_664_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_5 = arg_664_1:FormatText(arg_664_1:GetWordFromCfg(910201163).content)

				arg_664_1.text_.text = var_667_5

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_7 = 8 <= 0 and var_667_4 or var_667_4 * (utf8.len(var_667_5) / 8)

				if (8 <= 0 and var_667_4 or var_667_4 * (utf8.len(var_667_5) / 8)) > 0 and var_667_4 < var_667_7 then
					arg_664_1.talkMaxDuration = var_667_7

					if var_667_7 + var_667_3 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_7 + var_667_3
					end
				end

				arg_664_1.text_.text = var_667_5
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)
				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_8 = math.max(var_667_4, arg_664_1.talkMaxDuration)

			if var_667_3 <= arg_664_1.time_ and arg_664_1.time_ < var_667_3 + var_667_8 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_3) / var_667_8

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_3 + var_667_8 and arg_664_1.time_ < var_667_3 + var_667_8 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play910201164 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 910201164
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play910201165(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0.975

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, false)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_1 = arg_669_1:FormatText(arg_669_1:GetWordFromCfg(910201164).content)

				arg_669_1.text_.text = var_672_1

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_3 = 39 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_1) / 39)

				if (39 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_1) / 39)) > 0 and var_672_0 < var_672_3 then
					arg_669_1.talkMaxDuration = var_672_3

					if var_672_3 + 0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_3 + 0
					end
				end

				arg_669_1.text_.text = var_672_1
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_4 = math.max(var_672_0, arg_669_1.talkMaxDuration)

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_4 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - 0) / var_672_4

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= 0 + var_672_4 and arg_669_1.time_ < 0 + var_672_4 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play910201165 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 910201165
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play910201166(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = 0.3

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, true)
				arg_673_1.iconController_:SetSelectedState("hero")

				arg_673_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_673_1.callingController_:SetSelectedState("normal")

				arg_673_1.keyicon_.color = Color.New(1, 1, 1)
				arg_673_1.icon_.color = Color.New(1, 1, 1)

				local var_676_1 = arg_673_1:FormatText(arg_673_1:GetWordFromCfg(910201165).content)

				arg_673_1.text_.text = var_676_1

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_3 = 12 <= 0 and var_676_0 or var_676_0 * (utf8.len(var_676_1) / 12)

				if (12 <= 0 and var_676_0 or var_676_0 * (utf8.len(var_676_1) / 12)) > 0 and var_676_0 < var_676_3 then
					arg_673_1.talkMaxDuration = var_676_3

					if var_676_3 + 0 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_3 + 0
					end
				end

				arg_673_1.text_.text = var_676_1
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_4 = math.max(var_676_0, arg_673_1.talkMaxDuration)

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_4 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - 0) / var_676_4

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= 0 + var_676_4 and arg_673_1.time_ < 0 + var_676_4 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play910201166 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 910201166
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play910201167(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if arg_677_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_680_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_677_1.stage_.transform)

				var_680_0.name = "1036ui_story"
				var_680_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.actors_["1036ui_story"] = var_680_0

				local var_680_1 = var_680_0:GetComponentInChildren(typeof(CharacterEffect))

				var_680_1.enabled = true

				local var_680_2 = GameObjectTools.GetOrAddComponent(var_680_0, typeof(DynamicBoneHelper))

				if var_680_2 then
					var_680_2:EnableDynamicBone(false)
				end

				arg_677_1:ShowWeapon(var_680_1.transform, false)

				arg_677_1.var_["1036ui_story" .. "Animator"] = var_680_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_677_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_677_1.var_["1036ui_story" .. "LipSync"] = var_680_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_680_3 = arg_677_1.actors_["1036ui_story"].transform

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1.var_.moveOldPos1036ui_story = var_680_3.localPosition
			end

			local var_680_4 = 0.001

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_4 then
				var_680_3.localPosition = Vector3.Lerp(arg_677_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_677_1.time_ - 0) / var_680_4)
				var_680_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_680_3.position).x, (manager.ui.mainCamera.transform.position - var_680_3.position).y, (manager.ui.mainCamera.transform.position - var_680_3.position).z)
				var_680_3.localEulerAngles.z = 0
				var_680_3.localEulerAngles.x = 0
				var_680_3.localEulerAngles = var_680_3.localEulerAngles
			end

			if arg_677_1.time_ >= 0 + var_680_4 and arg_677_1.time_ < 0 + var_680_4 + arg_680_0 then
				var_680_3.localPosition = Vector3.New(0, -1.09, -5.78)
				var_680_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_680_3.position).x, (manager.ui.mainCamera.transform.position - var_680_3.position).y, (manager.ui.mainCamera.transform.position - var_680_3.position).z)
				var_680_3.localEulerAngles.z = 0
				var_680_3.localEulerAngles.x = 0
				var_680_3.localEulerAngles = var_680_3.localEulerAngles
			end

			local var_680_5 = arg_677_1.actors_["1036ui_story"]

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 and not isNil(var_680_5) and arg_677_1.var_.characterEffect1036ui_story == nil then
				arg_677_1.var_.characterEffect1036ui_story = var_680_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_6 = 0.2

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_6 and not isNil(var_680_5) then
				if arg_677_1.var_.characterEffect1036ui_story and not isNil(var_680_5) then
					arg_677_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= 0 + var_680_6 and arg_677_1.time_ < 0 + var_680_6 + arg_680_0 and not isNil(var_680_5) and arg_677_1.var_.characterEffect1036ui_story then
				arg_677_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_680_8 = 0
			local var_680_9 = 1

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_8 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_10 = arg_677_1:FormatText(arg_677_1:GetWordFromCfg(910201166).content)

				arg_677_1.text_.text = var_680_10

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_12 = 40 <= 0 and var_680_9 or var_680_9 * (utf8.len(var_680_10) / 40)

				if (40 <= 0 and var_680_9 or var_680_9 * (utf8.len(var_680_10) / 40)) > 0 and var_680_9 < var_680_12 then
					arg_677_1.talkMaxDuration = var_680_12

					if var_680_12 + var_680_8 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_12 + var_680_8
					end
				end

				arg_677_1.text_.text = var_680_10
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_13 = math.max(var_680_9, arg_677_1.talkMaxDuration)

			if var_680_8 <= arg_677_1.time_ and arg_677_1.time_ < var_680_8 + var_680_13 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_8) / var_680_13

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_8 + var_680_13 and arg_677_1.time_ < var_680_8 + var_680_13 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_677_1:InitPlayNodeList()
	end,
	Play910201167 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 910201167
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play910201168(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if arg_681_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_684_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_681_1.stage_.transform)

				var_684_0.name = "1037ui_story"
				var_684_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_681_1.actors_["1037ui_story"] = var_684_0

				local var_684_1 = var_684_0:GetComponentInChildren(typeof(CharacterEffect))

				var_684_1.enabled = true

				local var_684_2 = GameObjectTools.GetOrAddComponent(var_684_0, typeof(DynamicBoneHelper))

				if var_684_2 then
					var_684_2:EnableDynamicBone(false)
				end

				arg_681_1:ShowWeapon(var_684_1.transform, false)

				arg_681_1.var_["1037ui_story" .. "Animator"] = var_684_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_681_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_681_1.var_["1037ui_story" .. "LipSync"] = var_684_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_684_3 = arg_681_1.actors_["1037ui_story"]

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 and not isNil(var_684_3) and arg_681_1.var_.characterEffect1037ui_story == nil then
				arg_681_1.var_.characterEffect1037ui_story = var_684_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_4 = 0.2

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_4 and not isNil(var_684_3) then
				if arg_681_1.var_.characterEffect1037ui_story and not isNil(var_684_3) then
					arg_681_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_681_1.time_ >= 0 + var_684_4 and arg_681_1.time_ < 0 + var_684_4 + arg_684_0 and not isNil(var_684_3) and arg_681_1.var_.characterEffect1037ui_story then
				arg_681_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_684_6 = arg_681_1.actors_["1036ui_story"]

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 and not isNil(var_684_6) and arg_681_1.var_.characterEffect1036ui_story == nil then
				arg_681_1.var_.characterEffect1036ui_story = var_684_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_7 = 0.2

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_7 and not isNil(var_684_6) then
				if arg_681_1.var_.characterEffect1036ui_story and not isNil(var_684_6) then
					arg_681_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_681_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_681_1.time_ - 0) / var_684_7)
				end
			end

			if arg_681_1.time_ >= 0 + var_684_7 and arg_681_1.time_ < 0 + var_684_7 + arg_684_0 and not isNil(var_684_6) and arg_681_1.var_.characterEffect1036ui_story then
				arg_681_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_681_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_2")
			end

			local var_684_8 = arg_681_1.actors_["1037ui_story"].transform

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.var_.moveOldPos1037ui_story = var_684_8.localPosition
			end

			local var_684_9 = 0.001

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_9 then
				var_684_8.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_681_1.time_ - 0) / var_684_9)
				var_684_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_684_8.position).x, (manager.ui.mainCamera.transform.position - var_684_8.position).y, (manager.ui.mainCamera.transform.position - var_684_8.position).z)
				var_684_8.localEulerAngles.z = 0
				var_684_8.localEulerAngles.x = 0
				var_684_8.localEulerAngles = var_684_8.localEulerAngles
			end

			if arg_681_1.time_ >= 0 + var_684_9 and arg_681_1.time_ < 0 + var_684_9 + arg_684_0 then
				var_684_8.localPosition = Vector3.New(0, -1.09, -5.81)
				var_684_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_684_8.position).x, (manager.ui.mainCamera.transform.position - var_684_8.position).y, (manager.ui.mainCamera.transform.position - var_684_8.position).z)
				var_684_8.localEulerAngles.z = 0
				var_684_8.localEulerAngles.x = 0
				var_684_8.localEulerAngles = var_684_8.localEulerAngles
			end

			local var_684_10 = arg_681_1.actors_["1036ui_story"].transform

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.var_.moveOldPos1036ui_story = var_684_10.localPosition
			end

			local var_684_11 = 0.001

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_11 then
				var_684_10.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_681_1.time_ - 0) / var_684_11)
				var_684_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_684_10.position).x, (manager.ui.mainCamera.transform.position - var_684_10.position).y, (manager.ui.mainCamera.transform.position - var_684_10.position).z)
				var_684_10.localEulerAngles.z = 0
				var_684_10.localEulerAngles.x = 0
				var_684_10.localEulerAngles = var_684_10.localEulerAngles
			end

			if arg_681_1.time_ >= 0 + var_684_11 and arg_681_1.time_ < 0 + var_684_11 + arg_684_0 then
				var_684_10.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_684_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_684_10.position).x, (manager.ui.mainCamera.transform.position - var_684_10.position).y, (manager.ui.mainCamera.transform.position - var_684_10.position).z)
				var_684_10.localEulerAngles.z = 0
				var_684_10.localEulerAngles.x = 0
				var_684_10.localEulerAngles = var_684_10.localEulerAngles
			end

			local var_684_12 = 0
			local var_684_13 = 0.2

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_12 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				arg_681_1.leftNameTxt_.text = arg_681_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_14 = arg_681_1:FormatText(arg_681_1:GetWordFromCfg(910201167).content)

				arg_681_1.text_.text = var_684_14

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_16 = 8 <= 0 and var_684_13 or var_684_13 * (utf8.len(var_684_14) / 8)

				if (8 <= 0 and var_684_13 or var_684_13 * (utf8.len(var_684_14) / 8)) > 0 and var_684_13 < var_684_16 then
					arg_681_1.talkMaxDuration = var_684_16

					if var_684_16 + var_684_12 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_16 + var_684_12
					end
				end

				arg_681_1.text_.text = var_684_14
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_17 = math.max(var_684_13, arg_681_1.talkMaxDuration)

			if var_684_12 <= arg_681_1.time_ and arg_681_1.time_ < var_684_12 + var_684_17 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_12) / var_684_17

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_12 + var_684_17 and arg_681_1.time_ < var_684_12 + var_684_17 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play910201168 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 910201168
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play910201169(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.var_.moveOldPos1036ui_story = arg_685_1.actors_["1036ui_story"].transform.localPosition
			end

			local var_688_0 = 0.001

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_0 then
				arg_685_1.actors_["1036ui_story"].transform.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_685_1.time_ - 0) / var_688_0)
				arg_685_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_685_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1036ui_story"].transform.position).z)
				arg_685_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_685_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_685_1.actors_["1036ui_story"].transform.localEulerAngles = arg_685_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			if arg_685_1.time_ >= 0 + var_688_0 and arg_685_1.time_ < 0 + var_688_0 + arg_688_0 then
				arg_685_1.actors_["1036ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_685_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_685_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1036ui_story"].transform.position).z)
				arg_685_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_685_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_685_1.actors_["1036ui_story"].transform.localEulerAngles = arg_685_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			local var_688_1 = arg_685_1.actors_["1037ui_story"].transform

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.var_.moveOldPos1037ui_story = var_688_1.localPosition
			end

			local var_688_2 = 0.001

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_2 then
				var_688_1.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_685_1.time_ - 0) / var_688_2)
				var_688_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_688_1.position).x, (manager.ui.mainCamera.transform.position - var_688_1.position).y, (manager.ui.mainCamera.transform.position - var_688_1.position).z)
				var_688_1.localEulerAngles.z = 0
				var_688_1.localEulerAngles.x = 0
				var_688_1.localEulerAngles = var_688_1.localEulerAngles
			end

			if arg_685_1.time_ >= 0 + var_688_2 and arg_685_1.time_ < 0 + var_688_2 + arg_688_0 then
				var_688_1.localPosition = Vector3.New(0, 100, 0)
				var_688_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_688_1.position).x, (manager.ui.mainCamera.transform.position - var_688_1.position).y, (manager.ui.mainCamera.transform.position - var_688_1.position).z)
				var_688_1.localEulerAngles.z = 0
				var_688_1.localEulerAngles.x = 0
				var_688_1.localEulerAngles = var_688_1.localEulerAngles
			end

			local var_688_3 = "1066ui_story"

			if arg_685_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_688_4 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_685_1.stage_.transform)

				var_688_4.name = var_688_3
				var_688_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_685_1.actors_[var_688_3] = var_688_4

				local var_688_5 = var_688_4:GetComponentInChildren(typeof(CharacterEffect))

				var_688_5.enabled = true

				local var_688_6 = GameObjectTools.GetOrAddComponent(var_688_4, typeof(DynamicBoneHelper))

				if var_688_6 then
					var_688_6:EnableDynamicBone(false)
				end

				arg_685_1:ShowWeapon(var_688_5.transform, false)

				arg_685_1.var_[var_688_3 .. "Animator"] = var_688_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_685_1.var_[var_688_3 .. "Animator"].applyRootMotion = true
				arg_685_1.var_[var_688_3 .. "LipSync"] = var_688_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_688_7 = arg_685_1.actors_["1066ui_story"].transform

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.var_.moveOldPos1066ui_story = var_688_7.localPosition
			end

			local var_688_8 = 0.001

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_8 then
				var_688_7.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_685_1.time_ - 0) / var_688_8)
				var_688_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_688_7.position).x, (manager.ui.mainCamera.transform.position - var_688_7.position).y, (manager.ui.mainCamera.transform.position - var_688_7.position).z)
				var_688_7.localEulerAngles.z = 0
				var_688_7.localEulerAngles.x = 0
				var_688_7.localEulerAngles = var_688_7.localEulerAngles
			end

			if arg_685_1.time_ >= 0 + var_688_8 and arg_685_1.time_ < 0 + var_688_8 + arg_688_0 then
				var_688_7.localPosition = Vector3.New(0, -0.77, -6.1)
				var_688_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_688_7.position).x, (manager.ui.mainCamera.transform.position - var_688_7.position).y, (manager.ui.mainCamera.transform.position - var_688_7.position).z)
				var_688_7.localEulerAngles.z = 0
				var_688_7.localEulerAngles.x = 0
				var_688_7.localEulerAngles = var_688_7.localEulerAngles
			end

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_688_9 = arg_685_1.actors_["1066ui_story"]

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 and not isNil(var_688_9) and arg_685_1.var_.characterEffect1066ui_story == nil then
				arg_685_1.var_.characterEffect1066ui_story = var_688_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_10 = 0.2

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_10 and not isNil(var_688_9) then
				if arg_685_1.var_.characterEffect1066ui_story and not isNil(var_688_9) then
					arg_685_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= 0 + var_688_10 and arg_685_1.time_ < 0 + var_688_10 + arg_688_0 and not isNil(var_688_9) and arg_685_1.var_.characterEffect1066ui_story then
				arg_685_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_688_12 = 0
			local var_688_13 = 1

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_12 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_14 = arg_685_1:FormatText(arg_685_1:GetWordFromCfg(910201168).content)

				arg_685_1.text_.text = var_688_14

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_16 = 40 <= 0 and var_688_13 or var_688_13 * (utf8.len(var_688_14) / 40)

				if (40 <= 0 and var_688_13 or var_688_13 * (utf8.len(var_688_14) / 40)) > 0 and var_688_13 < var_688_16 then
					arg_685_1.talkMaxDuration = var_688_16

					if var_688_16 + var_688_12 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_16 + var_688_12
					end
				end

				arg_685_1.text_.text = var_688_14
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_17 = math.max(var_688_13, arg_685_1.talkMaxDuration)

			if var_688_12 <= arg_685_1.time_ and arg_685_1.time_ < var_688_12 + var_688_17 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_12) / var_688_17

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_12 + var_688_17 and arg_685_1.time_ < var_688_12 + var_688_17 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_685_1:InitPlayNodeList()
	end,
	Play910201169 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 910201169
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play910201170(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_692_0 = 0
			local var_692_1 = 1.1

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_2 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(910201169).content)

				arg_689_1.text_.text = var_692_2

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_4 = 44 <= 0 and var_692_1 or var_692_1 * (utf8.len(var_692_2) / 44)

				if (44 <= 0 and var_692_1 or var_692_1 * (utf8.len(var_692_2) / 44)) > 0 and var_692_1 < var_692_4 then
					arg_689_1.talkMaxDuration = var_692_4

					if var_692_4 + var_692_0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_4 + var_692_0
					end
				end

				arg_689_1.text_.text = var_692_2
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_5 = math.max(var_692_1, arg_689_1.talkMaxDuration)

			if var_692_0 <= arg_689_1.time_ and arg_689_1.time_ < var_692_0 + var_692_5 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_0) / var_692_5

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_0 + var_692_5 and arg_689_1.time_ < var_692_0 + var_692_5 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play910201170 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 910201170
		arg_693_1.duration_ = 5

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play910201171(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.var_.moveOldPos1066ui_story = arg_693_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_696_0 = 0.001

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_0 then
				arg_693_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_693_1.time_ - 0) / var_696_0)
				arg_693_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_693_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1066ui_story"].transform.position).z)
				arg_693_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_693_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_693_1.actors_["1066ui_story"].transform.localEulerAngles = arg_693_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_693_1.time_ >= 0 + var_696_0 and arg_693_1.time_ < 0 + var_696_0 + arg_696_0 then
				arg_693_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_693_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_693_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1066ui_story"].transform.position).z)
				arg_693_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_693_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_693_1.actors_["1066ui_story"].transform.localEulerAngles = arg_693_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_696_1 = "1027ui_story"

			if arg_693_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_696_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_693_1.stage_.transform)

				var_696_2.name = var_696_1
				var_696_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_693_1.actors_[var_696_1] = var_696_2

				local var_696_3 = var_696_2:GetComponentInChildren(typeof(CharacterEffect))

				var_696_3.enabled = true

				local var_696_4 = GameObjectTools.GetOrAddComponent(var_696_2, typeof(DynamicBoneHelper))

				if var_696_4 then
					var_696_4:EnableDynamicBone(false)
				end

				arg_693_1:ShowWeapon(var_696_3.transform, false)

				arg_693_1.var_[var_696_1 .. "Animator"] = var_696_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_693_1.var_[var_696_1 .. "Animator"].applyRootMotion = true
				arg_693_1.var_[var_696_1 .. "LipSync"] = var_696_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_696_5 = arg_693_1.actors_["1027ui_story"].transform

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.var_.moveOldPos1027ui_story = var_696_5.localPosition
			end

			local var_696_6 = 0.001

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_6 then
				var_696_5.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_693_1.time_ - 0) / var_696_6)
				var_696_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_696_5.position).x, (manager.ui.mainCamera.transform.position - var_696_5.position).y, (manager.ui.mainCamera.transform.position - var_696_5.position).z)
				var_696_5.localEulerAngles.z = 0
				var_696_5.localEulerAngles.x = 0
				var_696_5.localEulerAngles = var_696_5.localEulerAngles
			end

			if arg_693_1.time_ >= 0 + var_696_6 and arg_693_1.time_ < 0 + var_696_6 + arg_696_0 then
				var_696_5.localPosition = Vector3.New(0, -0.81, -5.8)
				var_696_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_696_5.position).x, (manager.ui.mainCamera.transform.position - var_696_5.position).y, (manager.ui.mainCamera.transform.position - var_696_5.position).z)
				var_696_5.localEulerAngles.z = 0
				var_696_5.localEulerAngles.x = 0
				var_696_5.localEulerAngles = var_696_5.localEulerAngles
			end

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_696_7 = arg_693_1.actors_["1027ui_story"]

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 and not isNil(var_696_7) and arg_693_1.var_.characterEffect1027ui_story == nil then
				arg_693_1.var_.characterEffect1027ui_story = var_696_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_8 = 0.2

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_8 and not isNil(var_696_7) then
				if arg_693_1.var_.characterEffect1027ui_story and not isNil(var_696_7) then
					arg_693_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= 0 + var_696_8 and arg_693_1.time_ < 0 + var_696_8 + arg_696_0 and not isNil(var_696_7) and arg_693_1.var_.characterEffect1027ui_story then
				arg_693_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_696_10 = 0
			local var_696_11 = 0.3

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_10 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_12 = arg_693_1:FormatText(arg_693_1:GetWordFromCfg(910201170).content)

				arg_693_1.text_.text = var_696_12

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_14 = 12 <= 0 and var_696_11 or var_696_11 * (utf8.len(var_696_12) / 12)

				if (12 <= 0 and var_696_11 or var_696_11 * (utf8.len(var_696_12) / 12)) > 0 and var_696_11 < var_696_14 then
					arg_693_1.talkMaxDuration = var_696_14

					if var_696_14 + var_696_10 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_14 + var_696_10
					end
				end

				arg_693_1.text_.text = var_696_12
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_15 = math.max(var_696_11, arg_693_1.talkMaxDuration)

			if var_696_10 <= arg_693_1.time_ and arg_693_1.time_ < var_696_10 + var_696_15 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_10) / var_696_15

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_10 + var_696_15 and arg_693_1.time_ < var_696_10 + var_696_15 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_693_1:InitPlayNodeList()
	end,
	Play910201171 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 910201171
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play910201172(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action476")
			end

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_700_0 = 0
			local var_700_1 = 0.85

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= var_700_0 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				arg_697_1.leftNameTxt_.text = arg_697_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_2 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(910201171).content)

				arg_697_1.text_.text = var_700_2

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_4 = 34 <= 0 and var_700_1 or var_700_1 * (utf8.len(var_700_2) / 34)

				if (34 <= 0 and var_700_1 or var_700_1 * (utf8.len(var_700_2) / 34)) > 0 and var_700_1 < var_700_4 then
					arg_697_1.talkMaxDuration = var_700_4

					if var_700_4 + var_700_0 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_4 + var_700_0
					end
				end

				arg_697_1.text_.text = var_700_2
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_5 = math.max(var_700_1, arg_697_1.talkMaxDuration)

			if var_700_0 <= arg_697_1.time_ and arg_697_1.time_ < var_700_0 + var_700_5 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_0) / var_700_5

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_0 + var_700_5 and arg_697_1.time_ < var_700_0 + var_700_5 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play910201172 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 910201172
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play910201173(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action462")
			end

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_704_0 = 0
			local var_704_1 = 0.275

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_2 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(910201172).content)

				arg_701_1.text_.text = var_704_2

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_4 = 11 <= 0 and var_704_1 or var_704_1 * (utf8.len(var_704_2) / 11)

				if (11 <= 0 and var_704_1 or var_704_1 * (utf8.len(var_704_2) / 11)) > 0 and var_704_1 < var_704_4 then
					arg_701_1.talkMaxDuration = var_704_4

					if var_704_4 + var_704_0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_4 + var_704_0
					end
				end

				arg_701_1.text_.text = var_704_2
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_5 = math.max(var_704_1, arg_701_1.talkMaxDuration)

			if var_704_0 <= arg_701_1.time_ and arg_701_1.time_ < var_704_0 + var_704_5 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_0) / var_704_5

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_0 + var_704_5 and arg_701_1.time_ < var_704_0 + var_704_5 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play910201173 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 910201173
		arg_705_1.duration_ = 5

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play910201174(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.var_.moveOldPos1027ui_story = arg_705_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_708_0 = 0.001

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_0 then
				arg_705_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_705_1.time_ - 0) / var_708_0)
				arg_705_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1027ui_story"].transform.position).z)
				arg_705_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["1027ui_story"].transform.localEulerAngles = arg_705_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_705_1.time_ >= 0 + var_708_0 and arg_705_1.time_ < 0 + var_708_0 + arg_708_0 then
				arg_705_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_705_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1027ui_story"].transform.position).z)
				arg_705_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["1027ui_story"].transform.localEulerAngles = arg_705_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_708_1 = "1011ui_story"

			if arg_705_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_708_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_705_1.stage_.transform)

				var_708_2.name = var_708_1
				var_708_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_705_1.actors_[var_708_1] = var_708_2

				local var_708_3 = var_708_2:GetComponentInChildren(typeof(CharacterEffect))

				var_708_3.enabled = true

				local var_708_4 = GameObjectTools.GetOrAddComponent(var_708_2, typeof(DynamicBoneHelper))

				if var_708_4 then
					var_708_4:EnableDynamicBone(false)
				end

				arg_705_1:ShowWeapon(var_708_3.transform, false)

				arg_705_1.var_[var_708_1 .. "Animator"] = var_708_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_705_1.var_[var_708_1 .. "Animator"].applyRootMotion = true
				arg_705_1.var_[var_708_1 .. "LipSync"] = var_708_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_708_5 = arg_705_1.actors_["1011ui_story"].transform

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.var_.moveOldPos1011ui_story = var_708_5.localPosition
			end

			local var_708_6 = 0.001

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_6 then
				var_708_5.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_705_1.time_ - 0) / var_708_6)
				var_708_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_708_5.position).x, (manager.ui.mainCamera.transform.position - var_708_5.position).y, (manager.ui.mainCamera.transform.position - var_708_5.position).z)
				var_708_5.localEulerAngles.z = 0
				var_708_5.localEulerAngles.x = 0
				var_708_5.localEulerAngles = var_708_5.localEulerAngles
			end

			if arg_705_1.time_ >= 0 + var_708_6 and arg_705_1.time_ < 0 + var_708_6 + arg_708_0 then
				var_708_5.localPosition = Vector3.New(0, -0.71, -6)
				var_708_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_708_5.position).x, (manager.ui.mainCamera.transform.position - var_708_5.position).y, (manager.ui.mainCamera.transform.position - var_708_5.position).z)
				var_708_5.localEulerAngles.z = 0
				var_708_5.localEulerAngles.x = 0
				var_708_5.localEulerAngles = var_708_5.localEulerAngles
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_708_7 = arg_705_1.actors_["1011ui_story"]

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 and not isNil(var_708_7) and arg_705_1.var_.characterEffect1011ui_story == nil then
				arg_705_1.var_.characterEffect1011ui_story = var_708_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_8 = 0.2

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_8 and not isNil(var_708_7) then
				if arg_705_1.var_.characterEffect1011ui_story and not isNil(var_708_7) then
					arg_705_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= 0 + var_708_8 and arg_705_1.time_ < 0 + var_708_8 + arg_708_0 and not isNil(var_708_7) and arg_705_1.var_.characterEffect1011ui_story then
				arg_705_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_708_10 = 0
			local var_708_11 = 0.25

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_10 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_12 = arg_705_1:FormatText(arg_705_1:GetWordFromCfg(910201173).content)

				arg_705_1.text_.text = var_708_12

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_14 = 10 <= 0 and var_708_11 or var_708_11 * (utf8.len(var_708_12) / 10)

				if (10 <= 0 and var_708_11 or var_708_11 * (utf8.len(var_708_12) / 10)) > 0 and var_708_11 < var_708_14 then
					arg_705_1.talkMaxDuration = var_708_14

					if var_708_14 + var_708_10 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_14 + var_708_10
					end
				end

				arg_705_1.text_.text = var_708_12
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)
				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_15 = math.max(var_708_11, arg_705_1.talkMaxDuration)

			if var_708_10 <= arg_705_1.time_ and arg_705_1.time_ < var_708_10 + var_708_15 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_10) / var_708_15

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_10 + var_708_15 and arg_705_1.time_ < var_708_10 + var_708_15 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_705_1:InitPlayNodeList()
	end,
	Play910201174 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 910201174
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play910201175(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.var_.moveOldPos1011ui_story = arg_709_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_712_0 = 0.001

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_0 then
				arg_709_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_709_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_709_1.time_ - 0) / var_712_0)
				arg_709_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_709_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["1011ui_story"].transform.position).z)
				arg_709_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_709_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_709_1.actors_["1011ui_story"].transform.localEulerAngles = arg_709_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_709_1.time_ >= 0 + var_712_0 and arg_709_1.time_ < 0 + var_712_0 + arg_712_0 then
				arg_709_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_709_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_709_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["1011ui_story"].transform.position).z)
				arg_709_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_709_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_709_1.actors_["1011ui_story"].transform.localEulerAngles = arg_709_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_712_1 = 0
			local var_712_2 = 0.675

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_3 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(910201174).content)

				arg_709_1.text_.text = var_712_3

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_5 = 27 <= 0 and var_712_2 or var_712_2 * (utf8.len(var_712_3) / 27)

				if (27 <= 0 and var_712_2 or var_712_2 * (utf8.len(var_712_3) / 27)) > 0 and var_712_2 < var_712_5 then
					arg_709_1.talkMaxDuration = var_712_5

					if var_712_5 + var_712_1 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_5 + var_712_1
					end
				end

				arg_709_1.text_.text = var_712_3
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_6 = math.max(var_712_2, arg_709_1.talkMaxDuration)

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_6 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_1) / var_712_6

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_1 + var_712_6 and arg_709_1.time_ < var_712_1 + var_712_6 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_709_1:InitPlayNodeList()
	end,
	Play910201175 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 910201175
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play910201176(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.var_.moveOldPos1084ui_story = arg_713_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_716_0 = 0.001

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_0 then
				arg_713_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_713_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_713_1.time_ - 0) / var_716_0)
				arg_713_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_713_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_713_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_713_1.actors_["1084ui_story"].transform.position).z)
				arg_713_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_713_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_713_1.actors_["1084ui_story"].transform.localEulerAngles = arg_713_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_713_1.time_ >= 0 + var_716_0 and arg_713_1.time_ < 0 + var_716_0 + arg_716_0 then
				arg_713_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_713_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_713_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_713_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_713_1.actors_["1084ui_story"].transform.position).z)
				arg_713_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_713_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_713_1.actors_["1084ui_story"].transform.localEulerAngles = arg_713_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_716_1 = arg_713_1.actors_["1084ui_story"]

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 and not isNil(var_716_1) and arg_713_1.var_.characterEffect1084ui_story == nil then
				arg_713_1.var_.characterEffect1084ui_story = var_716_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_716_2 = 0.2

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_2 and not isNil(var_716_1) then
				if arg_713_1.var_.characterEffect1084ui_story and not isNil(var_716_1) then
					arg_713_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_713_1.time_ >= 0 + var_716_2 and arg_713_1.time_ < 0 + var_716_2 + arg_716_0 and not isNil(var_716_1) and arg_713_1.var_.characterEffect1084ui_story then
				arg_713_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_716_4 = 0
			local var_716_5 = 0.35

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= var_716_4 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_6 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(910201175).content)

				arg_713_1.text_.text = var_716_6

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_8 = 14 <= 0 and var_716_5 or var_716_5 * (utf8.len(var_716_6) / 14)

				if (14 <= 0 and var_716_5 or var_716_5 * (utf8.len(var_716_6) / 14)) > 0 and var_716_5 < var_716_8 then
					arg_713_1.talkMaxDuration = var_716_8

					if var_716_8 + var_716_4 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_8 + var_716_4
					end
				end

				arg_713_1.text_.text = var_716_6
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_9 = math.max(var_716_5, arg_713_1.talkMaxDuration)

			if var_716_4 <= arg_713_1.time_ and arg_713_1.time_ < var_716_4 + var_716_9 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_4) / var_716_9

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_4 + var_716_9 and arg_713_1.time_ < var_716_4 + var_716_9 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_713_1:InitPlayNodeList()
	end,
	Play910201176 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 910201176
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play910201177(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 and not isNil(arg_717_1.actors_["1084ui_story"]) and arg_717_1.var_.characterEffect1084ui_story == nil then
				arg_717_1.var_.characterEffect1084ui_story = arg_717_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_0 = 0.2

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_0 and not isNil(arg_717_1.actors_["1084ui_story"]) then
				if arg_717_1.var_.characterEffect1084ui_story and not isNil(arg_717_1.actors_["1084ui_story"]) then
					arg_717_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_717_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_717_1.time_ - 0) / var_720_0)
				end
			end

			if arg_717_1.time_ >= 0 + var_720_0 and arg_717_1.time_ < 0 + var_720_0 + arg_720_0 and not isNil(arg_717_1.actors_["1084ui_story"]) and arg_717_1.var_.characterEffect1084ui_story then
				arg_717_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_717_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_720_1 = 0
			local var_720_2 = 0.4

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= var_720_1 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, true)
				arg_717_1.iconController_:SetSelectedState("hero")

				arg_717_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_717_1.callingController_:SetSelectedState("normal")

				arg_717_1.keyicon_.color = Color.New(1, 1, 1)
				arg_717_1.icon_.color = Color.New(1, 1, 1)

				local var_720_3 = arg_717_1:FormatText(arg_717_1:GetWordFromCfg(910201176).content)

				arg_717_1.text_.text = var_720_3

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_5 = 16 <= 0 and var_720_2 or var_720_2 * (utf8.len(var_720_3) / 16)

				if (16 <= 0 and var_720_2 or var_720_2 * (utf8.len(var_720_3) / 16)) > 0 and var_720_2 < var_720_5 then
					arg_717_1.talkMaxDuration = var_720_5

					if var_720_5 + var_720_1 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_5 + var_720_1
					end
				end

				arg_717_1.text_.text = var_720_3
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_6 = math.max(var_720_2, arg_717_1.talkMaxDuration)

			if var_720_1 <= arg_717_1.time_ and arg_717_1.time_ < var_720_1 + var_720_6 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_1) / var_720_6

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_1 + var_720_6 and arg_717_1.time_ < var_720_1 + var_720_6 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play910201177 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 910201177
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play910201178(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 and not isNil(arg_721_1.actors_["1084ui_story"]) and arg_721_1.var_.characterEffect1084ui_story == nil then
				arg_721_1.var_.characterEffect1084ui_story = arg_721_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_0 = 0.2

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_0 and not isNil(arg_721_1.actors_["1084ui_story"]) then
				if arg_721_1.var_.characterEffect1084ui_story and not isNil(arg_721_1.actors_["1084ui_story"]) then
					arg_721_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_721_1.time_ >= 0 + var_724_0 and arg_721_1.time_ < 0 + var_724_0 + arg_724_0 and not isNil(arg_721_1.actors_["1084ui_story"]) and arg_721_1.var_.characterEffect1084ui_story then
				arg_721_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action432")
			end

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_724_2 = 0
			local var_724_3 = 0.475

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= var_724_2 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				arg_721_1.leftNameTxt_.text = arg_721_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_4 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(910201177).content)

				arg_721_1.text_.text = var_724_4

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_6 = 19 <= 0 and var_724_3 or var_724_3 * (utf8.len(var_724_4) / 19)

				if (19 <= 0 and var_724_3 or var_724_3 * (utf8.len(var_724_4) / 19)) > 0 and var_724_3 < var_724_6 then
					arg_721_1.talkMaxDuration = var_724_6

					if var_724_6 + var_724_2 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_6 + var_724_2
					end
				end

				arg_721_1.text_.text = var_724_4
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_7 = math.max(var_724_3, arg_721_1.talkMaxDuration)

			if var_724_2 <= arg_721_1.time_ and arg_721_1.time_ < var_724_2 + var_724_7 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_2) / var_724_7

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_2 + var_724_7 and arg_721_1.time_ < var_724_2 + var_724_7 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play910201178 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 910201178
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play910201179(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 and not isNil(arg_725_1.actors_["1084ui_story"]) and arg_725_1.var_.characterEffect1084ui_story == nil then
				arg_725_1.var_.characterEffect1084ui_story = arg_725_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_728_0 = 0.2

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_0 and not isNil(arg_725_1.actors_["1084ui_story"]) then
				if arg_725_1.var_.characterEffect1084ui_story and not isNil(arg_725_1.actors_["1084ui_story"]) then
					arg_725_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_725_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_725_1.time_ - 0) / var_728_0)
				end
			end

			if arg_725_1.time_ >= 0 + var_728_0 and arg_725_1.time_ < 0 + var_728_0 + arg_728_0 and not isNil(arg_725_1.actors_["1084ui_story"]) and arg_725_1.var_.characterEffect1084ui_story then
				arg_725_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_725_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_728_1 = 0
			local var_728_2 = 0.175

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_1 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				arg_725_1.leftNameTxt_.text = arg_725_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, true)
				arg_725_1.iconController_:SetSelectedState("hero")

				arg_725_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_725_1.callingController_:SetSelectedState("normal")

				arg_725_1.keyicon_.color = Color.New(1, 1, 1)
				arg_725_1.icon_.color = Color.New(1, 1, 1)

				local var_728_3 = arg_725_1:FormatText(arg_725_1:GetWordFromCfg(910201178).content)

				arg_725_1.text_.text = var_728_3

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_5 = 7 <= 0 and var_728_2 or var_728_2 * (utf8.len(var_728_3) / 7)

				if (7 <= 0 and var_728_2 or var_728_2 * (utf8.len(var_728_3) / 7)) > 0 and var_728_2 < var_728_5 then
					arg_725_1.talkMaxDuration = var_728_5

					if var_728_5 + var_728_1 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_5 + var_728_1
					end
				end

				arg_725_1.text_.text = var_728_3
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_6 = math.max(var_728_2, arg_725_1.talkMaxDuration)

			if var_728_1 <= arg_725_1.time_ and arg_725_1.time_ < var_728_1 + var_728_6 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_1) / var_728_6

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_1 + var_728_6 and arg_725_1.time_ < var_728_1 + var_728_6 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play910201179 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 910201179
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play910201180(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 and not isNil(arg_729_1.actors_["1084ui_story"]) and arg_729_1.var_.characterEffect1084ui_story == nil then
				arg_729_1.var_.characterEffect1084ui_story = arg_729_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_732_0 = 0.2

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_0 and not isNil(arg_729_1.actors_["1084ui_story"]) then
				if arg_729_1.var_.characterEffect1084ui_story and not isNil(arg_729_1.actors_["1084ui_story"]) then
					arg_729_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_729_1.time_ >= 0 + var_732_0 and arg_729_1.time_ < 0 + var_732_0 + arg_732_0 and not isNil(arg_729_1.actors_["1084ui_story"]) and arg_729_1.var_.characterEffect1084ui_story then
				arg_729_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action428")
			end

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_732_2 = 0
			local var_732_3 = 0.475

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_2 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_4 = arg_729_1:FormatText(arg_729_1:GetWordFromCfg(910201179).content)

				arg_729_1.text_.text = var_732_4

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_6 = 19 <= 0 and var_732_3 or var_732_3 * (utf8.len(var_732_4) / 19)

				if (19 <= 0 and var_732_3 or var_732_3 * (utf8.len(var_732_4) / 19)) > 0 and var_732_3 < var_732_6 then
					arg_729_1.talkMaxDuration = var_732_6

					if var_732_6 + var_732_2 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_6 + var_732_2
					end
				end

				arg_729_1.text_.text = var_732_4
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_7 = math.max(var_732_3, arg_729_1.talkMaxDuration)

			if var_732_2 <= arg_729_1.time_ and arg_729_1.time_ < var_732_2 + var_732_7 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_2) / var_732_7

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_2 + var_732_7 and arg_729_1.time_ < var_732_2 + var_732_7 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play910201180 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 910201180
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play910201181(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 and not isNil(arg_733_1.actors_["1084ui_story"]) and arg_733_1.var_.characterEffect1084ui_story == nil then
				arg_733_1.var_.characterEffect1084ui_story = arg_733_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_0 = 0.2

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_0 and not isNil(arg_733_1.actors_["1084ui_story"]) then
				if arg_733_1.var_.characterEffect1084ui_story and not isNil(arg_733_1.actors_["1084ui_story"]) then
					arg_733_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_733_1.time_ - 0) / var_736_0)
				end
			end

			if arg_733_1.time_ >= 0 + var_736_0 and arg_733_1.time_ < 0 + var_736_0 + arg_736_0 and not isNil(arg_733_1.actors_["1084ui_story"]) and arg_733_1.var_.characterEffect1084ui_story then
				arg_733_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_736_1 = 0
			local var_736_2 = 0.3

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_1 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				arg_733_1.leftNameTxt_.text = arg_733_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, true)
				arg_733_1.iconController_:SetSelectedState("hero")

				arg_733_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_733_1.callingController_:SetSelectedState("normal")

				arg_733_1.keyicon_.color = Color.New(1, 1, 1)
				arg_733_1.icon_.color = Color.New(1, 1, 1)

				local var_736_3 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(910201180).content)

				arg_733_1.text_.text = var_736_3

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_5 = 12 <= 0 and var_736_2 or var_736_2 * (utf8.len(var_736_3) / 12)

				if (12 <= 0 and var_736_2 or var_736_2 * (utf8.len(var_736_3) / 12)) > 0 and var_736_2 < var_736_5 then
					arg_733_1.talkMaxDuration = var_736_5

					if var_736_5 + var_736_1 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_5 + var_736_1
					end
				end

				arg_733_1.text_.text = var_736_3
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_6 = math.max(var_736_2, arg_733_1.talkMaxDuration)

			if var_736_1 <= arg_733_1.time_ and arg_733_1.time_ < var_736_1 + var_736_6 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_1) / var_736_6

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_1 + var_736_6 and arg_733_1.time_ < var_736_1 + var_736_6 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play910201181 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 910201181
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play910201182(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 and not isNil(arg_737_1.actors_["1084ui_story"]) and arg_737_1.var_.characterEffect1084ui_story == nil then
				arg_737_1.var_.characterEffect1084ui_story = arg_737_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_0 = 0.2

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_0 and not isNil(arg_737_1.actors_["1084ui_story"]) then
				if arg_737_1.var_.characterEffect1084ui_story and not isNil(arg_737_1.actors_["1084ui_story"]) then
					arg_737_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_737_1.time_ >= 0 + var_740_0 and arg_737_1.time_ < 0 + var_740_0 + arg_740_0 and not isNil(arg_737_1.actors_["1084ui_story"]) and arg_737_1.var_.characterEffect1084ui_story then
				arg_737_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_740_2 = 0
			local var_740_3 = 0.825

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_2 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_4 = arg_737_1:FormatText(arg_737_1:GetWordFromCfg(910201181).content)

				arg_737_1.text_.text = var_740_4

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_6 = 33 <= 0 and var_740_3 or var_740_3 * (utf8.len(var_740_4) / 33)

				if (33 <= 0 and var_740_3 or var_740_3 * (utf8.len(var_740_4) / 33)) > 0 and var_740_3 < var_740_6 then
					arg_737_1.talkMaxDuration = var_740_6

					if var_740_6 + var_740_2 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_6 + var_740_2
					end
				end

				arg_737_1.text_.text = var_740_4
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_7 = math.max(var_740_3, arg_737_1.talkMaxDuration)

			if var_740_2 <= arg_737_1.time_ and arg_737_1.time_ < var_740_2 + var_740_7 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_2) / var_740_7

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_2 + var_740_7 and arg_737_1.time_ < var_740_2 + var_740_7 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play910201182 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 910201182
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play910201183(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action467")
			end

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_744_0 = 0
			local var_744_1 = 0.775

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_0 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_2 = arg_741_1:FormatText(arg_741_1:GetWordFromCfg(910201182).content)

				arg_741_1.text_.text = var_744_2

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_4 = 31 <= 0 and var_744_1 or var_744_1 * (utf8.len(var_744_2) / 31)

				if (31 <= 0 and var_744_1 or var_744_1 * (utf8.len(var_744_2) / 31)) > 0 and var_744_1 < var_744_4 then
					arg_741_1.talkMaxDuration = var_744_4

					if var_744_4 + var_744_0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_4 + var_744_0
					end
				end

				arg_741_1.text_.text = var_744_2
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_5 = math.max(var_744_1, arg_741_1.talkMaxDuration)

			if var_744_0 <= arg_741_1.time_ and arg_741_1.time_ < var_744_0 + var_744_5 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_0) / var_744_5

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_0 + var_744_5 and arg_741_1.time_ < var_744_0 + var_744_5 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play910201183 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 910201183
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play910201184(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_748_0 = 0
			local var_748_1 = 0.825

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				arg_745_1.leftNameTxt_.text = arg_745_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_2 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(910201183).content)

				arg_745_1.text_.text = var_748_2

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_4 = 33 <= 0 and var_748_1 or var_748_1 * (utf8.len(var_748_2) / 33)

				if (33 <= 0 and var_748_1 or var_748_1 * (utf8.len(var_748_2) / 33)) > 0 and var_748_1 < var_748_4 then
					arg_745_1.talkMaxDuration = var_748_4

					if var_748_4 + var_748_0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_4 + var_748_0
					end
				end

				arg_745_1.text_.text = var_748_2
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_5 = math.max(var_748_1, arg_745_1.talkMaxDuration)

			if var_748_0 <= arg_745_1.time_ and arg_745_1.time_ < var_748_0 + var_748_5 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_0) / var_748_5

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_0 + var_748_5 and arg_745_1.time_ < var_748_0 + var_748_5 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play910201184 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 910201184
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play910201185(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_752_0 = 0
			local var_752_1 = 1.05

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_2 = arg_749_1:FormatText(arg_749_1:GetWordFromCfg(910201184).content)

				arg_749_1.text_.text = var_752_2

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_4 = 42 <= 0 and var_752_1 or var_752_1 * (utf8.len(var_752_2) / 42)

				if (42 <= 0 and var_752_1 or var_752_1 * (utf8.len(var_752_2) / 42)) > 0 and var_752_1 < var_752_4 then
					arg_749_1.talkMaxDuration = var_752_4

					if var_752_4 + var_752_0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_4 + var_752_0
					end
				end

				arg_749_1.text_.text = var_752_2
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_5 = math.max(var_752_1, arg_749_1.talkMaxDuration)

			if var_752_0 <= arg_749_1.time_ and arg_749_1.time_ < var_752_0 + var_752_5 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_0) / var_752_5

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_0 + var_752_5 and arg_749_1.time_ < var_752_0 + var_752_5 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play910201185 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 910201185
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play910201186(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 and not isNil(arg_753_1.actors_["1084ui_story"]) and arg_753_1.var_.characterEffect1084ui_story == nil then
				arg_753_1.var_.characterEffect1084ui_story = arg_753_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_0 = 0.2

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_0 and not isNil(arg_753_1.actors_["1084ui_story"]) then
				if arg_753_1.var_.characterEffect1084ui_story and not isNil(arg_753_1.actors_["1084ui_story"]) then
					arg_753_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_753_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_753_1.time_ - 0) / var_756_0)
				end
			end

			if arg_753_1.time_ >= 0 + var_756_0 and arg_753_1.time_ < 0 + var_756_0 + arg_756_0 and not isNil(arg_753_1.actors_["1084ui_story"]) and arg_753_1.var_.characterEffect1084ui_story then
				arg_753_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_753_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_756_1 = 0
			local var_756_2 = 0.425

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= var_756_1 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				arg_753_1.leftNameTxt_.text = arg_753_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, true)
				arg_753_1.iconController_:SetSelectedState("hero")

				arg_753_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_753_1.callingController_:SetSelectedState("normal")

				arg_753_1.keyicon_.color = Color.New(1, 1, 1)
				arg_753_1.icon_.color = Color.New(1, 1, 1)

				local var_756_3 = arg_753_1:FormatText(arg_753_1:GetWordFromCfg(910201185).content)

				arg_753_1.text_.text = var_756_3

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_5 = 17 <= 0 and var_756_2 or var_756_2 * (utf8.len(var_756_3) / 17)

				if (17 <= 0 and var_756_2 or var_756_2 * (utf8.len(var_756_3) / 17)) > 0 and var_756_2 < var_756_5 then
					arg_753_1.talkMaxDuration = var_756_5

					if var_756_5 + var_756_1 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_5 + var_756_1
					end
				end

				arg_753_1.text_.text = var_756_3
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_6 = math.max(var_756_2, arg_753_1.talkMaxDuration)

			if var_756_1 <= arg_753_1.time_ and arg_753_1.time_ < var_756_1 + var_756_6 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_1) / var_756_6

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_1 + var_756_6 and arg_753_1.time_ < var_756_1 + var_756_6 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play910201186 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 910201186
		arg_757_1.duration_ = 5

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play910201187(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.var_.moveOldPos1013ui_story = arg_757_1.actors_["1013ui_story"].transform.localPosition
			end

			local var_760_0 = 0.001

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_0 then
				arg_757_1.actors_["1013ui_story"].transform.localPosition = Vector3.Lerp(arg_757_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_757_1.time_ - 0) / var_760_0)
				arg_757_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_757_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_757_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_757_1.actors_["1013ui_story"].transform.position).z)
				arg_757_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_757_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_757_1.actors_["1013ui_story"].transform.localEulerAngles = arg_757_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			if arg_757_1.time_ >= 0 + var_760_0 and arg_757_1.time_ < 0 + var_760_0 + arg_760_0 then
				arg_757_1.actors_["1013ui_story"].transform.localPosition = Vector3.New(0, -0.66, -6.15)
				arg_757_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_757_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_757_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_757_1.actors_["1013ui_story"].transform.position).z)
				arg_757_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_757_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_757_1.actors_["1013ui_story"].transform.localEulerAngles = arg_757_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_760_1 = arg_757_1.actors_["1084ui_story"].transform

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.var_.moveOldPos1084ui_story = var_760_1.localPosition
			end

			local var_760_2 = 0.001

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_2 then
				var_760_1.localPosition = Vector3.Lerp(arg_757_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_757_1.time_ - 0) / var_760_2)
				var_760_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_760_1.position).x, (manager.ui.mainCamera.transform.position - var_760_1.position).y, (manager.ui.mainCamera.transform.position - var_760_1.position).z)
				var_760_1.localEulerAngles.z = 0
				var_760_1.localEulerAngles.x = 0
				var_760_1.localEulerAngles = var_760_1.localEulerAngles
			end

			if arg_757_1.time_ >= 0 + var_760_2 and arg_757_1.time_ < 0 + var_760_2 + arg_760_0 then
				var_760_1.localPosition = Vector3.New(0, 100, 0)
				var_760_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_760_1.position).x, (manager.ui.mainCamera.transform.position - var_760_1.position).y, (manager.ui.mainCamera.transform.position - var_760_1.position).z)
				var_760_1.localEulerAngles.z = 0
				var_760_1.localEulerAngles.x = 0
				var_760_1.localEulerAngles = var_760_1.localEulerAngles
			end

			local var_760_3 = arg_757_1.actors_["1013ui_story"]

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 and not isNil(var_760_3) and arg_757_1.var_.characterEffect1013ui_story == nil then
				arg_757_1.var_.characterEffect1013ui_story = var_760_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_760_4 = 0.2

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_4 and not isNil(var_760_3) then
				if arg_757_1.var_.characterEffect1013ui_story and not isNil(var_760_3) then
					arg_757_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_757_1.time_ >= 0 + var_760_4 and arg_757_1.time_ < 0 + var_760_4 + arg_760_0 and not isNil(var_760_3) and arg_757_1.var_.characterEffect1013ui_story then
				arg_757_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_760_6 = 0
			local var_760_7 = 0.575

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= var_760_6 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				arg_757_1.leftNameTxt_.text = arg_757_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_8 = arg_757_1:FormatText(arg_757_1:GetWordFromCfg(910201186).content)

				arg_757_1.text_.text = var_760_8

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_10 = 23 <= 0 and var_760_7 or var_760_7 * (utf8.len(var_760_8) / 23)

				if (23 <= 0 and var_760_7 or var_760_7 * (utf8.len(var_760_8) / 23)) > 0 and var_760_7 < var_760_10 then
					arg_757_1.talkMaxDuration = var_760_10

					if var_760_10 + var_760_6 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_10 + var_760_6
					end
				end

				arg_757_1.text_.text = var_760_8
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)
				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_11 = math.max(var_760_7, arg_757_1.talkMaxDuration)

			if var_760_6 <= arg_757_1.time_ and arg_757_1.time_ < var_760_6 + var_760_11 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_6) / var_760_11

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_6 + var_760_11 and arg_757_1.time_ < var_760_6 + var_760_11 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_757_1:InitPlayNodeList()
	end,
	Play910201187 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 910201187
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play910201188(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4102")
			end

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_764_0 = 0
			local var_764_1 = 0.475

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= var_764_0 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				arg_761_1.leftNameTxt_.text = arg_761_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, false)
				arg_761_1.callingController_:SetSelectedState("normal")

				local var_764_2 = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(910201187).content)

				arg_761_1.text_.text = var_764_2

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_4 = 19 <= 0 and var_764_1 or var_764_1 * (utf8.len(var_764_2) / 19)

				if (19 <= 0 and var_764_1 or var_764_1 * (utf8.len(var_764_2) / 19)) > 0 and var_764_1 < var_764_4 then
					arg_761_1.talkMaxDuration = var_764_4

					if var_764_4 + var_764_0 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_4 + var_764_0
					end
				end

				arg_761_1.text_.text = var_764_2
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_5 = math.max(var_764_1, arg_761_1.talkMaxDuration)

			if var_764_0 <= arg_761_1.time_ and arg_761_1.time_ < var_764_0 + var_764_5 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_0) / var_764_5

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_0 + var_764_5 and arg_761_1.time_ < var_764_0 + var_764_5 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play910201188 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 910201188
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play910201189(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 then
				arg_765_1.var_.moveOldPos1013ui_story = arg_765_1.actors_["1013ui_story"].transform.localPosition
			end

			local var_768_0 = 0.001

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_0 then
				arg_765_1.actors_["1013ui_story"].transform.localPosition = Vector3.Lerp(arg_765_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_765_1.time_ - 0) / var_768_0)
				arg_765_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_765_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_765_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_765_1.actors_["1013ui_story"].transform.position).z)
				arg_765_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_765_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_765_1.actors_["1013ui_story"].transform.localEulerAngles = arg_765_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			if arg_765_1.time_ >= 0 + var_768_0 and arg_765_1.time_ < 0 + var_768_0 + arg_768_0 then
				arg_765_1.actors_["1013ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_765_1.actors_["1013ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_765_1.actors_["1013ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_765_1.actors_["1013ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_765_1.actors_["1013ui_story"].transform.position).z)
				arg_765_1.actors_["1013ui_story"].transform.localEulerAngles.z = 0
				arg_765_1.actors_["1013ui_story"].transform.localEulerAngles.x = 0
				arg_765_1.actors_["1013ui_story"].transform.localEulerAngles = arg_765_1.actors_["1013ui_story"].transform.localEulerAngles
			end

			local var_768_1 = 0
			local var_768_2 = 0.225

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= var_768_1 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, true)
				arg_765_1.iconController_:SetSelectedState("hero")

				arg_765_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_765_1.callingController_:SetSelectedState("normal")

				arg_765_1.keyicon_.color = Color.New(1, 1, 1)
				arg_765_1.icon_.color = Color.New(1, 1, 1)

				local var_768_3 = arg_765_1:FormatText(arg_765_1:GetWordFromCfg(910201188).content)

				arg_765_1.text_.text = var_768_3

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_5 = 9 <= 0 and var_768_2 or var_768_2 * (utf8.len(var_768_3) / 9)

				if (9 <= 0 and var_768_2 or var_768_2 * (utf8.len(var_768_3) / 9)) > 0 and var_768_2 < var_768_5 then
					arg_765_1.talkMaxDuration = var_768_5

					if var_768_5 + var_768_1 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_5 + var_768_1
					end
				end

				arg_765_1.text_.text = var_768_3
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_6 = math.max(var_768_2, arg_765_1.talkMaxDuration)

			if var_768_1 <= arg_765_1.time_ and arg_765_1.time_ < var_768_1 + var_768_6 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_1) / var_768_6

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_1 + var_768_6 and arg_765_1.time_ < var_768_1 + var_768_6 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_765_1:InitPlayNodeList()
	end,
	Play910201189 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 910201189
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play910201190(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1.var_.moveOldPos1080ui_story = arg_769_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_772_0 = 0.001

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_0 then
				arg_769_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_769_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_769_1.time_ - 0) / var_772_0)
				arg_769_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_769_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1080ui_story"].transform.position).z)
				arg_769_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_769_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_769_1.actors_["1080ui_story"].transform.localEulerAngles = arg_769_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_769_1.time_ >= 0 + var_772_0 and arg_769_1.time_ < 0 + var_772_0 + arg_772_0 then
				arg_769_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_769_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_769_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1080ui_story"].transform.position).z)
				arg_769_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_769_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_769_1.actors_["1080ui_story"].transform.localEulerAngles = arg_769_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_772_1 = arg_769_1.actors_["1080ui_story"]

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 and not isNil(var_772_1) and arg_769_1.var_.characterEffect1080ui_story == nil then
				arg_769_1.var_.characterEffect1080ui_story = var_772_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_2 = 0.2

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_2 and not isNil(var_772_1) then
				if arg_769_1.var_.characterEffect1080ui_story and not isNil(var_772_1) then
					arg_769_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_769_1.time_ >= 0 + var_772_2 and arg_769_1.time_ < 0 + var_772_2 + arg_772_0 and not isNil(var_772_1) and arg_769_1.var_.characterEffect1080ui_story then
				arg_769_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action3_1")
			end

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_772_4 = 0
			local var_772_5 = 0.25

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= var_772_4 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				arg_769_1.leftNameTxt_.text = arg_769_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_6 = arg_769_1:FormatText(arg_769_1:GetWordFromCfg(910201189).content)

				arg_769_1.text_.text = var_772_6

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_8 = 10 <= 0 and var_772_5 or var_772_5 * (utf8.len(var_772_6) / 10)

				if (10 <= 0 and var_772_5 or var_772_5 * (utf8.len(var_772_6) / 10)) > 0 and var_772_5 < var_772_8 then
					arg_769_1.talkMaxDuration = var_772_8

					if var_772_8 + var_772_4 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_8 + var_772_4
					end
				end

				arg_769_1.text_.text = var_772_6
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_9 = math.max(var_772_5, arg_769_1.talkMaxDuration)

			if var_772_4 <= arg_769_1.time_ and arg_769_1.time_ < var_772_4 + var_772_9 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_4) / var_772_9

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_4 + var_772_9 and arg_769_1.time_ < var_772_4 + var_772_9 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_769_1:InitPlayNodeList()
	end,
	Play910201190 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 910201190
		arg_773_1.duration_ = 5

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play910201191(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 and not isNil(arg_773_1.actors_["1080ui_story"]) and arg_773_1.var_.characterEffect1080ui_story == nil then
				arg_773_1.var_.characterEffect1080ui_story = arg_773_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_0 = 0.2

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_0 and not isNil(arg_773_1.actors_["1080ui_story"]) then
				if arg_773_1.var_.characterEffect1080ui_story and not isNil(arg_773_1.actors_["1080ui_story"]) then
					arg_773_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_773_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_773_1.time_ - 0) / var_776_0)
				end
			end

			if arg_773_1.time_ >= 0 + var_776_0 and arg_773_1.time_ < 0 + var_776_0 + arg_776_0 and not isNil(arg_773_1.actors_["1080ui_story"]) and arg_773_1.var_.characterEffect1080ui_story then
				arg_773_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_773_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_776_1 = 0
			local var_776_2 = 0.275

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_1 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, false)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_3 = arg_773_1:FormatText(arg_773_1:GetWordFromCfg(910201190).content)

				arg_773_1.text_.text = var_776_3

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_5 = 11 <= 0 and var_776_2 or var_776_2 * (utf8.len(var_776_3) / 11)

				if (11 <= 0 and var_776_2 or var_776_2 * (utf8.len(var_776_3) / 11)) > 0 and var_776_2 < var_776_5 then
					arg_773_1.talkMaxDuration = var_776_5

					if var_776_5 + var_776_1 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_5 + var_776_1
					end
				end

				arg_773_1.text_.text = var_776_3
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)
				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_6 = math.max(var_776_2, arg_773_1.talkMaxDuration)

			if var_776_1 <= arg_773_1.time_ and arg_773_1.time_ < var_776_1 + var_776_6 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_1) / var_776_6

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_1 + var_776_6 and arg_773_1.time_ < var_776_1 + var_776_6 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play910201191 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 910201191
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play910201192(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0.225

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_1 = arg_777_1:FormatText(arg_777_1:GetWordFromCfg(910201191).content)

				arg_777_1.text_.text = var_780_1

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_3 = 9 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_1) / 9)

				if (9 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_1) / 9)) > 0 and var_780_0 < var_780_3 then
					arg_777_1.talkMaxDuration = var_780_3

					if var_780_3 + 0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_3 + 0
					end
				end

				arg_777_1.text_.text = var_780_1
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_4 = math.max(var_780_0, arg_777_1.talkMaxDuration)

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_4 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - 0) / var_780_4

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= 0 + var_780_4 and arg_777_1.time_ < 0 + var_780_4 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play910201192 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 910201192
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play910201193(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 then
				arg_781_1.var_.moveOldPos1080ui_story = arg_781_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_784_0 = 0.001

			if 0 <= arg_781_1.time_ and arg_781_1.time_ < 0 + var_784_0 then
				arg_781_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_781_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_781_1.time_ - 0) / var_784_0)
				arg_781_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_781_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_781_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_781_1.actors_["1080ui_story"].transform.position).z)
				arg_781_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_781_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_781_1.actors_["1080ui_story"].transform.localEulerAngles = arg_781_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_781_1.time_ >= 0 + var_784_0 and arg_781_1.time_ < 0 + var_784_0 + arg_784_0 then
				arg_781_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_781_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_781_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_781_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_781_1.actors_["1080ui_story"].transform.position).z)
				arg_781_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_781_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_781_1.actors_["1080ui_story"].transform.localEulerAngles = arg_781_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_784_1 = 0
			local var_784_2 = 0.25

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= var_784_1 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				arg_781_1.leftNameTxt_.text = arg_781_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, true)
				arg_781_1.iconController_:SetSelectedState("hero")

				arg_781_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_781_1.callingController_:SetSelectedState("normal")

				arg_781_1.keyicon_.color = Color.New(1, 1, 1)
				arg_781_1.icon_.color = Color.New(1, 1, 1)

				local var_784_3 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(910201192).content)

				arg_781_1.text_.text = var_784_3

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_5 = 10 <= 0 and var_784_2 or var_784_2 * (utf8.len(var_784_3) / 10)

				if (10 <= 0 and var_784_2 or var_784_2 * (utf8.len(var_784_3) / 10)) > 0 and var_784_2 < var_784_5 then
					arg_781_1.talkMaxDuration = var_784_5

					if var_784_5 + var_784_1 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_5 + var_784_1
					end
				end

				arg_781_1.text_.text = var_784_3
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_6 = math.max(var_784_2, arg_781_1.talkMaxDuration)

			if var_784_1 <= arg_781_1.time_ and arg_781_1.time_ < var_784_1 + var_784_6 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_1) / var_784_6

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_1 + var_784_6 and arg_781_1.time_ < var_784_1 + var_784_6 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_781_1:InitPlayNodeList()
	end,
	Play910201193 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 910201193
		arg_785_1.duration_ = 5

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play910201194(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			if arg_785_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_788_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_785_1.stage_.transform)

				var_788_0.name = "1059ui_story"
				var_788_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_785_1.actors_["1059ui_story"] = var_788_0

				local var_788_1 = var_788_0:GetComponentInChildren(typeof(CharacterEffect))

				var_788_1.enabled = true

				local var_788_2 = GameObjectTools.GetOrAddComponent(var_788_0, typeof(DynamicBoneHelper))

				if var_788_2 then
					var_788_2:EnableDynamicBone(false)
				end

				arg_785_1:ShowWeapon(var_788_1.transform, false)

				arg_785_1.var_["1059ui_story" .. "Animator"] = var_788_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_785_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_785_1.var_["1059ui_story" .. "LipSync"] = var_788_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_788_3 = arg_785_1.actors_["1059ui_story"].transform

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1.var_.moveOldPos1059ui_story = var_788_3.localPosition
			end

			local var_788_4 = 0.001

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_4 then
				var_788_3.localPosition = Vector3.Lerp(arg_785_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_785_1.time_ - 0) / var_788_4)
				var_788_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_788_3.position).x, (manager.ui.mainCamera.transform.position - var_788_3.position).y, (manager.ui.mainCamera.transform.position - var_788_3.position).z)
				var_788_3.localEulerAngles.z = 0
				var_788_3.localEulerAngles.x = 0
				var_788_3.localEulerAngles = var_788_3.localEulerAngles
			end

			if arg_785_1.time_ >= 0 + var_788_4 and arg_785_1.time_ < 0 + var_788_4 + arg_788_0 then
				var_788_3.localPosition = Vector3.New(0, -1.05, -6)
				var_788_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_788_3.position).x, (manager.ui.mainCamera.transform.position - var_788_3.position).y, (manager.ui.mainCamera.transform.position - var_788_3.position).z)
				var_788_3.localEulerAngles.z = 0
				var_788_3.localEulerAngles.x = 0
				var_788_3.localEulerAngles = var_788_3.localEulerAngles
			end

			local var_788_5 = arg_785_1.actors_["1059ui_story"]

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 and not isNil(var_788_5) and arg_785_1.var_.characterEffect1059ui_story == nil then
				arg_785_1.var_.characterEffect1059ui_story = var_788_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_6 = 0.2

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_6 and not isNil(var_788_5) then
				if arg_785_1.var_.characterEffect1059ui_story and not isNil(var_788_5) then
					arg_785_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_785_1.time_ >= 0 + var_788_6 and arg_785_1.time_ < 0 + var_788_6 + arg_788_0 and not isNil(var_788_5) and arg_785_1.var_.characterEffect1059ui_story then
				arg_785_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_788_8 = 0
			local var_788_9 = 0.5

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_8 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				arg_785_1.leftNameTxt_.text = arg_785_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_10 = arg_785_1:FormatText(arg_785_1:GetWordFromCfg(910201193).content)

				arg_785_1.text_.text = var_788_10

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_12 = 20 <= 0 and var_788_9 or var_788_9 * (utf8.len(var_788_10) / 20)

				if (20 <= 0 and var_788_9 or var_788_9 * (utf8.len(var_788_10) / 20)) > 0 and var_788_9 < var_788_12 then
					arg_785_1.talkMaxDuration = var_788_12

					if var_788_12 + var_788_8 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_12 + var_788_8
					end
				end

				arg_785_1.text_.text = var_788_10
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_13 = math.max(var_788_9, arg_785_1.talkMaxDuration)

			if var_788_8 <= arg_785_1.time_ and arg_785_1.time_ < var_788_8 + var_788_13 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_8) / var_788_13

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_8 + var_788_13 and arg_785_1.time_ < var_788_8 + var_788_13 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_785_1:InitPlayNodeList()
	end,
	Play910201194 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 910201194
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play910201195(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action425")
			end

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_792_0 = 0
			local var_792_1 = 1.05

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_0 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				arg_789_1.leftNameTxt_.text = arg_789_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_2 = arg_789_1:FormatText(arg_789_1:GetWordFromCfg(910201194).content)

				arg_789_1.text_.text = var_792_2

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_4 = 42 <= 0 and var_792_1 or var_792_1 * (utf8.len(var_792_2) / 42)

				if (42 <= 0 and var_792_1 or var_792_1 * (utf8.len(var_792_2) / 42)) > 0 and var_792_1 < var_792_4 then
					arg_789_1.talkMaxDuration = var_792_4

					if var_792_4 + var_792_0 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_4 + var_792_0
					end
				end

				arg_789_1.text_.text = var_792_2
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_5 = math.max(var_792_1, arg_789_1.talkMaxDuration)

			if var_792_0 <= arg_789_1.time_ and arg_789_1.time_ < var_792_0 + var_792_5 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_0) / var_792_5

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_0 + var_792_5 and arg_789_1.time_ < var_792_0 + var_792_5 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play910201195 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 910201195
		arg_793_1.duration_ = 5

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play910201196(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 and not isNil(arg_793_1.actors_["1059ui_story"]) and arg_793_1.var_.characterEffect1059ui_story == nil then
				arg_793_1.var_.characterEffect1059ui_story = arg_793_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_0 = 0.2

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_0 and not isNil(arg_793_1.actors_["1059ui_story"]) then
				if arg_793_1.var_.characterEffect1059ui_story and not isNil(arg_793_1.actors_["1059ui_story"]) then
					arg_793_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_793_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_793_1.time_ - 0) / var_796_0)
				end
			end

			if arg_793_1.time_ >= 0 + var_796_0 and arg_793_1.time_ < 0 + var_796_0 + arg_796_0 and not isNil(arg_793_1.actors_["1059ui_story"]) and arg_793_1.var_.characterEffect1059ui_story then
				arg_793_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_793_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_796_1 = 0
			local var_796_2 = 0.725

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= var_796_1 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				arg_793_1.leftNameTxt_.text = arg_793_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, true)
				arg_793_1.iconController_:SetSelectedState("hero")

				arg_793_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_793_1.callingController_:SetSelectedState("normal")

				arg_793_1.keyicon_.color = Color.New(1, 1, 1)
				arg_793_1.icon_.color = Color.New(1, 1, 1)

				local var_796_3 = arg_793_1:FormatText(arg_793_1:GetWordFromCfg(910201195).content)

				arg_793_1.text_.text = var_796_3

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_5 = 29 <= 0 and var_796_2 or var_796_2 * (utf8.len(var_796_3) / 29)

				if (29 <= 0 and var_796_2 or var_796_2 * (utf8.len(var_796_3) / 29)) > 0 and var_796_2 < var_796_5 then
					arg_793_1.talkMaxDuration = var_796_5

					if var_796_5 + var_796_1 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_5 + var_796_1
					end
				end

				arg_793_1.text_.text = var_796_3
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)
				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_6 = math.max(var_796_2, arg_793_1.talkMaxDuration)

			if var_796_1 <= arg_793_1.time_ and arg_793_1.time_ < var_796_1 + var_796_6 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_1) / var_796_6

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_1 + var_796_6 and arg_793_1.time_ < var_796_1 + var_796_6 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play910201196 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 910201196
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play910201197(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 and not isNil(arg_797_1.actors_["1059ui_story"]) and arg_797_1.var_.characterEffect1059ui_story == nil then
				arg_797_1.var_.characterEffect1059ui_story = arg_797_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_0 = 0.2

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_0 and not isNil(arg_797_1.actors_["1059ui_story"]) then
				if arg_797_1.var_.characterEffect1059ui_story and not isNil(arg_797_1.actors_["1059ui_story"]) then
					arg_797_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_797_1.time_ >= 0 + var_800_0 and arg_797_1.time_ < 0 + var_800_0 + arg_800_0 and not isNil(arg_797_1.actors_["1059ui_story"]) and arg_797_1.var_.characterEffect1059ui_story then
				arg_797_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 then
				arg_797_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action452")
			end

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 then
				arg_797_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_800_2 = 0
			local var_800_3 = 0.7

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= var_800_2 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				arg_797_1.leftNameTxt_.text = arg_797_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_4 = arg_797_1:FormatText(arg_797_1:GetWordFromCfg(910201196).content)

				arg_797_1.text_.text = var_800_4

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_6 = 28 <= 0 and var_800_3 or var_800_3 * (utf8.len(var_800_4) / 28)

				if (28 <= 0 and var_800_3 or var_800_3 * (utf8.len(var_800_4) / 28)) > 0 and var_800_3 < var_800_6 then
					arg_797_1.talkMaxDuration = var_800_6

					if var_800_6 + var_800_2 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_6 + var_800_2
					end
				end

				arg_797_1.text_.text = var_800_4
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_7 = math.max(var_800_3, arg_797_1.talkMaxDuration)

			if var_800_2 <= arg_797_1.time_ and arg_797_1.time_ < var_800_2 + var_800_7 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_2) / var_800_7

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_2 + var_800_7 and arg_797_1.time_ < var_800_2 + var_800_7 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play910201197 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 910201197
		arg_801_1.duration_ = 5

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play910201198(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 and not isNil(arg_801_1.actors_["1059ui_story"]) and arg_801_1.var_.characterEffect1059ui_story == nil then
				arg_801_1.var_.characterEffect1059ui_story = arg_801_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_0 = 0.2

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_0 and not isNil(arg_801_1.actors_["1059ui_story"]) then
				if arg_801_1.var_.characterEffect1059ui_story and not isNil(arg_801_1.actors_["1059ui_story"]) then
					arg_801_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_801_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_801_1.time_ - 0) / var_804_0)
				end
			end

			if arg_801_1.time_ >= 0 + var_804_0 and arg_801_1.time_ < 0 + var_804_0 + arg_804_0 and not isNil(arg_801_1.actors_["1059ui_story"]) and arg_801_1.var_.characterEffect1059ui_story then
				arg_801_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_801_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_804_1 = 0
			local var_804_2 = 0.125

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= var_804_1 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				arg_801_1.leftNameTxt_.text = arg_801_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, true)
				arg_801_1.iconController_:SetSelectedState("hero")

				arg_801_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_801_1.callingController_:SetSelectedState("normal")

				arg_801_1.keyicon_.color = Color.New(1, 1, 1)
				arg_801_1.icon_.color = Color.New(1, 1, 1)

				local var_804_3 = arg_801_1:FormatText(arg_801_1:GetWordFromCfg(910201197).content)

				arg_801_1.text_.text = var_804_3

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_5 = 5 <= 0 and var_804_2 or var_804_2 * (utf8.len(var_804_3) / 5)

				if (5 <= 0 and var_804_2 or var_804_2 * (utf8.len(var_804_3) / 5)) > 0 and var_804_2 < var_804_5 then
					arg_801_1.talkMaxDuration = var_804_5

					if var_804_5 + var_804_1 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_5 + var_804_1
					end
				end

				arg_801_1.text_.text = var_804_3
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)
				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_6 = math.max(var_804_2, arg_801_1.talkMaxDuration)

			if var_804_1 <= arg_801_1.time_ and arg_801_1.time_ < var_804_1 + var_804_6 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_1) / var_804_6

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_1 + var_804_6 and arg_801_1.time_ < var_804_1 + var_804_6 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play910201198 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 910201198
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play910201199(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1.var_.moveOldPos1059ui_story = arg_805_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_808_0 = 0.001

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_0 then
				arg_805_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_805_1.time_ - 0) / var_808_0)
				arg_805_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1059ui_story"].transform.position).z)
				arg_805_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["1059ui_story"].transform.localEulerAngles = arg_805_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_805_1.time_ >= 0 + var_808_0 and arg_805_1.time_ < 0 + var_808_0 + arg_808_0 then
				arg_805_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_805_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1059ui_story"].transform.position).z)
				arg_805_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["1059ui_story"].transform.localEulerAngles = arg_805_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_808_1 = "1032ui_story"

			if arg_805_1.actors_["1032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1032ui_story"))) then
				local var_808_2 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_805_1.stage_.transform)

				var_808_2.name = var_808_1
				var_808_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_805_1.actors_[var_808_1] = var_808_2

				local var_808_3 = var_808_2:GetComponentInChildren(typeof(CharacterEffect))

				var_808_3.enabled = true

				local var_808_4 = GameObjectTools.GetOrAddComponent(var_808_2, typeof(DynamicBoneHelper))

				if var_808_4 then
					var_808_4:EnableDynamicBone(false)
				end

				arg_805_1:ShowWeapon(var_808_3.transform, false)

				arg_805_1.var_[var_808_1 .. "Animator"] = var_808_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_805_1.var_[var_808_1 .. "Animator"].applyRootMotion = true
				arg_805_1.var_[var_808_1 .. "LipSync"] = var_808_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action8_1")
			end

			local var_808_5 = arg_805_1.actors_["1032ui_story"].transform

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1.var_.moveOldPos1032ui_story = var_808_5.localPosition
			end

			local var_808_6 = 0.001

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_6 then
				var_808_5.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1032ui_story, Vector3.New(0, -1.05, -6.2), (arg_805_1.time_ - 0) / var_808_6)
				var_808_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_808_5.position).x, (manager.ui.mainCamera.transform.position - var_808_5.position).y, (manager.ui.mainCamera.transform.position - var_808_5.position).z)
				var_808_5.localEulerAngles.z = 0
				var_808_5.localEulerAngles.x = 0
				var_808_5.localEulerAngles = var_808_5.localEulerAngles
			end

			if arg_805_1.time_ >= 0 + var_808_6 and arg_805_1.time_ < 0 + var_808_6 + arg_808_0 then
				var_808_5.localPosition = Vector3.New(0, -1.05, -6.2)
				var_808_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_808_5.position).x, (manager.ui.mainCamera.transform.position - var_808_5.position).y, (manager.ui.mainCamera.transform.position - var_808_5.position).z)
				var_808_5.localEulerAngles.z = 0
				var_808_5.localEulerAngles.x = 0
				var_808_5.localEulerAngles = var_808_5.localEulerAngles
			end

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_808_7 = arg_805_1.actors_["1032ui_story"]

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 and not isNil(var_808_7) and arg_805_1.var_.characterEffect1032ui_story == nil then
				arg_805_1.var_.characterEffect1032ui_story = var_808_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_808_8 = 0.2

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_8 and not isNil(var_808_7) then
				if arg_805_1.var_.characterEffect1032ui_story and not isNil(var_808_7) then
					arg_805_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_805_1.time_ >= 0 + var_808_8 and arg_805_1.time_ < 0 + var_808_8 + arg_808_0 and not isNil(var_808_7) and arg_805_1.var_.characterEffect1032ui_story then
				arg_805_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_808_10 = 0
			local var_808_11 = 0.925

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_10 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				arg_805_1.leftNameTxt_.text = arg_805_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_12 = arg_805_1:FormatText(arg_805_1:GetWordFromCfg(910201198).content)

				arg_805_1.text_.text = var_808_12

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_14 = 37 <= 0 and var_808_11 or var_808_11 * (utf8.len(var_808_12) / 37)

				if (37 <= 0 and var_808_11 or var_808_11 * (utf8.len(var_808_12) / 37)) > 0 and var_808_11 < var_808_14 then
					arg_805_1.talkMaxDuration = var_808_14

					if var_808_14 + var_808_10 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_14 + var_808_10
					end
				end

				arg_805_1.text_.text = var_808_12
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_15 = math.max(var_808_11, arg_805_1.talkMaxDuration)

			if var_808_10 <= arg_805_1.time_ and arg_805_1.time_ < var_808_10 + var_808_15 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_10) / var_808_15

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_10 + var_808_15 and arg_805_1.time_ < var_808_10 + var_808_15 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_805_1:InitPlayNodeList()
	end,
	Play910201199 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 910201199
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play910201200(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action486")
			end

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_812_0 = 0
			local var_812_1 = 0.775

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= var_812_0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				arg_809_1.leftNameTxt_.text = arg_809_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, false)
				arg_809_1.callingController_:SetSelectedState("normal")

				local var_812_2 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(910201199).content)

				arg_809_1.text_.text = var_812_2

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_4 = 31 <= 0 and var_812_1 or var_812_1 * (utf8.len(var_812_2) / 31)

				if (31 <= 0 and var_812_1 or var_812_1 * (utf8.len(var_812_2) / 31)) > 0 and var_812_1 < var_812_4 then
					arg_809_1.talkMaxDuration = var_812_4

					if var_812_4 + var_812_0 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_4 + var_812_0
					end
				end

				arg_809_1.text_.text = var_812_2
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_5 = math.max(var_812_1, arg_809_1.talkMaxDuration)

			if var_812_0 <= arg_809_1.time_ and arg_809_1.time_ < var_812_0 + var_812_5 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_0) / var_812_5

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_0 + var_812_5 and arg_809_1.time_ < var_812_0 + var_812_5 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play910201200 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 910201200
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play910201201(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1.var_.moveOldPos1032ui_story = arg_813_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_816_0 = 0.001

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_0 then
				arg_813_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_813_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_813_1.time_ - 0) / var_816_0)
				arg_813_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_813_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1032ui_story"].transform.position).z)
				arg_813_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_813_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_813_1.actors_["1032ui_story"].transform.localEulerAngles = arg_813_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_813_1.time_ >= 0 + var_816_0 and arg_813_1.time_ < 0 + var_816_0 + arg_816_0 then
				arg_813_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_813_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_813_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_813_1.actors_["1032ui_story"].transform.position).z)
				arg_813_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_813_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_813_1.actors_["1032ui_story"].transform.localEulerAngles = arg_813_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_816_1 = 0
			local var_816_2 = 0.375

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= var_816_1 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				arg_813_1.leftNameTxt_.text = arg_813_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_3 = arg_813_1:FormatText(arg_813_1:GetWordFromCfg(910201200).content)

				arg_813_1.text_.text = var_816_3

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_5 = 15 <= 0 and var_816_2 or var_816_2 * (utf8.len(var_816_3) / 15)

				if (15 <= 0 and var_816_2 or var_816_2 * (utf8.len(var_816_3) / 15)) > 0 and var_816_2 < var_816_5 then
					arg_813_1.talkMaxDuration = var_816_5

					if var_816_5 + var_816_1 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_5 + var_816_1
					end
				end

				arg_813_1.text_.text = var_816_3
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_6 = math.max(var_816_2, arg_813_1.talkMaxDuration)

			if var_816_1 <= arg_813_1.time_ and arg_813_1.time_ < var_816_1 + var_816_6 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_1) / var_816_6

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_1 + var_816_6 and arg_813_1.time_ < var_816_1 + var_816_6 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_813_1:InitPlayNodeList()
	end,
	Play910201201 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 910201201
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play910201202(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1.var_.moveOldPos1096ui_story = arg_817_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_820_0 = 0.001

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_0 then
				arg_817_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_817_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_817_1.time_ - 0) / var_820_0)
				arg_817_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_817_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["1096ui_story"].transform.position).z)
				arg_817_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_817_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_817_1.actors_["1096ui_story"].transform.localEulerAngles = arg_817_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_817_1.time_ >= 0 + var_820_0 and arg_817_1.time_ < 0 + var_820_0 + arg_820_0 then
				arg_817_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, -1.13, -5.6)
				arg_817_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_817_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["1096ui_story"].transform.position).z)
				arg_817_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_817_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_817_1.actors_["1096ui_story"].transform.localEulerAngles = arg_817_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_820_1 = arg_817_1.actors_["1096ui_story"]

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 and not isNil(var_820_1) and arg_817_1.var_.characterEffect1096ui_story == nil then
				arg_817_1.var_.characterEffect1096ui_story = var_820_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_2 = 0.2

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_2 and not isNil(var_820_1) then
				if arg_817_1.var_.characterEffect1096ui_story and not isNil(var_820_1) then
					arg_817_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_817_1.time_ >= 0 + var_820_2 and arg_817_1.time_ < 0 + var_820_2 + arg_820_0 and not isNil(var_820_1) and arg_817_1.var_.characterEffect1096ui_story then
				arg_817_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_820_4 = 0
			local var_820_5 = 0.15

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= var_820_4 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				arg_817_1.leftNameTxt_.text = arg_817_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_6 = arg_817_1:FormatText(arg_817_1:GetWordFromCfg(910201201).content)

				arg_817_1.text_.text = var_820_6

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_8 = 6 <= 0 and var_820_5 or var_820_5 * (utf8.len(var_820_6) / 6)

				if (6 <= 0 and var_820_5 or var_820_5 * (utf8.len(var_820_6) / 6)) > 0 and var_820_5 < var_820_8 then
					arg_817_1.talkMaxDuration = var_820_8

					if var_820_8 + var_820_4 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_8 + var_820_4
					end
				end

				arg_817_1.text_.text = var_820_6
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_9 = math.max(var_820_5, arg_817_1.talkMaxDuration)

			if var_820_4 <= arg_817_1.time_ and arg_817_1.time_ < var_820_4 + var_820_9 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_4) / var_820_9

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_4 + var_820_9 and arg_817_1.time_ < var_820_4 + var_820_9 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_817_1:InitPlayNodeList()
	end,
	Play910201202 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 910201202
		arg_821_1.duration_ = 9

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play910201203(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			if arg_821_1.bgs_.HB0101 == nil then
				local var_824_0 = Object.Instantiate(arg_821_1.paintGo_)

				var_824_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "HB0101")
				var_824_0.name = "HB0101"
				var_824_0.transform.parent = arg_821_1.stage_.transform
				var_824_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_821_1.bgs_.HB0101 = var_824_0
			end

			if 2 < arg_821_1.time_ and arg_821_1.time_ <= 2 + arg_824_0 then
				local var_824_1 = arg_821_1.bgs_.HB0101

				arg_821_1.bgs_.HB0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_824_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_824_2 = var_824_1:GetComponent("SpriteRenderer")

				if var_824_2 and var_824_2.sprite then
					local var_824_3 = 2 * (var_824_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_824_1.transform.localScale = Vector3.New(var_824_3 / var_824_2.sprite.bounds.size.y < var_824_3 * manager.ui.mainCameraCom_.aspect / var_824_2.sprite.bounds.size.x and var_824_3 * manager.ui.mainCameraCom_.aspect / var_824_2.sprite.bounds.size.x or var_824_3 / var_824_2.sprite.bounds.size.y, var_824_3 / var_824_2.sprite.bounds.size.y < var_824_3 * manager.ui.mainCameraCom_.aspect / var_824_2.sprite.bounds.size.x and var_824_3 * manager.ui.mainCameraCom_.aspect / var_824_2.sprite.bounds.size.x or var_824_3 / var_824_2.sprite.bounds.size.y, 0)
				end

				for iter_824_0, iter_824_1 in pairs(arg_821_1.bgs_) do
					if iter_824_0 ~= "HB0101" then
						iter_824_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_824_4 = arg_821_1.actors_["1096ui_story"].transform

			if 1.966 < arg_821_1.time_ and arg_821_1.time_ <= 1.966 + arg_824_0 then
				arg_821_1.var_.moveOldPos1096ui_story = var_824_4.localPosition
			end

			local var_824_5 = 0.001

			if 1.966 <= arg_821_1.time_ and arg_821_1.time_ < 1.966 + var_824_5 then
				var_824_4.localPosition = Vector3.Lerp(arg_821_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_821_1.time_ - 1.966) / var_824_5)
				var_824_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_824_4.position).x, (manager.ui.mainCamera.transform.position - var_824_4.position).y, (manager.ui.mainCamera.transform.position - var_824_4.position).z)
				var_824_4.localEulerAngles.z = 0
				var_824_4.localEulerAngles.x = 0
				var_824_4.localEulerAngles = var_824_4.localEulerAngles
			end

			if arg_821_1.time_ >= 1.966 + var_824_5 and arg_821_1.time_ < 1.966 + var_824_5 + arg_824_0 then
				var_824_4.localPosition = Vector3.New(0, 100, 0)
				var_824_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_824_4.position).x, (manager.ui.mainCamera.transform.position - var_824_4.position).y, (manager.ui.mainCamera.transform.position - var_824_4.position).z)
				var_824_4.localEulerAngles.z = 0
				var_824_4.localEulerAngles.x = 0
				var_824_4.localEulerAngles = var_824_4.localEulerAngles
			end

			local var_824_6 = 0

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= var_824_6 + arg_824_0 then
				arg_821_1.mask_.enabled = true
				arg_821_1.mask_.raycastTarget = true

				arg_821_1:SetGaussion(false)
			end

			local var_824_7 = 2

			if var_824_6 <= arg_821_1.time_ and arg_821_1.time_ < var_824_6 + var_824_7 then
				local var_824_8 = Color.New(0, 0, 0)

				var_824_8.a = Mathf.Lerp(0, 1, (arg_821_1.time_ - var_824_6) / var_824_7)
				arg_821_1.mask_.color = var_824_8
			end

			if arg_821_1.time_ >= var_824_6 + var_824_7 and arg_821_1.time_ < var_824_6 + var_824_7 + arg_824_0 then
				local var_824_9 = Color.New(0, 0, 0)

				var_824_9.a = 1
				arg_821_1.mask_.color = var_824_9
			end

			local var_824_10 = 2

			if 2 < arg_821_1.time_ and arg_821_1.time_ <= var_824_10 + arg_824_0 then
				arg_821_1.mask_.enabled = true
				arg_821_1.mask_.raycastTarget = true

				arg_821_1:SetGaussion(false)
			end

			local var_824_11 = 2

			if var_824_10 <= arg_821_1.time_ and arg_821_1.time_ < var_824_10 + var_824_11 then
				local var_824_12 = Color.New(0, 0, 0)

				var_824_12.a = Mathf.Lerp(1, 0, (arg_821_1.time_ - var_824_10) / var_824_11)
				arg_821_1.mask_.color = var_824_12
			end

			if arg_821_1.time_ >= var_824_10 + var_824_11 and arg_821_1.time_ < var_824_10 + var_824_11 + arg_824_0 then
				local var_824_13 = Color.New(0, 0, 0)

				arg_821_1.mask_.enabled = false
				var_824_13.a = 0
				arg_821_1.mask_.color = var_824_13
			end

			if arg_821_1.frameCnt_ <= 1 then
				arg_821_1.dialog_:SetActive(false)
			end

			local var_824_14 = 4
			local var_824_15 = 0.375

			if 4 < arg_821_1.time_ and arg_821_1.time_ <= var_824_14 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0

				arg_821_1.dialog_:SetActive(true)

				arg_821_1.dialogCg_.alpha = 0

				local var_824_16 = LeanTween.value(arg_821_1.dialog_, 0, 1, 0.3)

				var_824_16:setOnUpdate(LuaHelper.FloatAction(function(arg_825_0)
					arg_821_1.dialogCg_.alpha = arg_825_0
				end))
				var_824_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_821_1.dialog_)
					var_824_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_821_1.duration_ = arg_821_1.duration_ + 0.3

				SetActive(arg_821_1.leftNameGo_, true)

				arg_821_1.leftNameTxt_.text = arg_821_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_17 = arg_821_1:FormatText(arg_821_1:GetWordFromCfg(910201202).content)

				arg_821_1.text_.text = var_824_17

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_19 = 15 <= 0 and var_824_15 or var_824_15 * (utf8.len(var_824_17) / 15)

				if (15 <= 0 and var_824_15 or var_824_15 * (utf8.len(var_824_17) / 15)) > 0 and var_824_15 < var_824_19 then
					arg_821_1.talkMaxDuration = var_824_19
					var_824_14 = var_824_14 + 0.3

					if var_824_19 + var_824_14 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_19 + var_824_14
					end
				end

				arg_821_1.text_.text = var_824_17
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_20 = var_824_14 + 0.3
			local var_824_21 = math.max(var_824_15, arg_821_1.talkMaxDuration)

			if var_824_14 + 0.3 <= arg_821_1.time_ and arg_821_1.time_ < var_824_20 + var_824_21 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_20) / var_824_21

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_20 + var_824_21 and arg_821_1.time_ < var_824_20 + var_824_21 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_821_1:InitPlayNodeList()
	end,
	Play910201203 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 910201203
		arg_827_1.duration_ = 5

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play910201204(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			local var_830_0 = 0.8

			if 0 < arg_827_1.time_ and arg_827_1.time_ <= 0 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, true)

				arg_827_1.leftNameTxt_.text = arg_827_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_827_1.leftNameTxt_.transform)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1.leftNameTxt_.text)
				SetActive(arg_827_1.iconTrs_.gameObject, false)
				arg_827_1.callingController_:SetSelectedState("normal")

				local var_830_1 = arg_827_1:FormatText(arg_827_1:GetWordFromCfg(910201203).content)

				arg_827_1.text_.text = var_830_1

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_3 = 32 <= 0 and var_830_0 or var_830_0 * (utf8.len(var_830_1) / 32)

				if (32 <= 0 and var_830_0 or var_830_0 * (utf8.len(var_830_1) / 32)) > 0 and var_830_0 < var_830_3 then
					arg_827_1.talkMaxDuration = var_830_3

					if var_830_3 + 0 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_3 + 0
					end
				end

				arg_827_1.text_.text = var_830_1
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)
				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_4 = math.max(var_830_0, arg_827_1.talkMaxDuration)

			if 0 <= arg_827_1.time_ and arg_827_1.time_ < 0 + var_830_4 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - 0) / var_830_4

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= 0 + var_830_4 and arg_827_1.time_ < 0 + var_830_4 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end

		arg_827_1.nodeConfigList_ = {}

		arg_827_1:InitPlayNodeList()
	end,
	Play910201204 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 910201204
		arg_831_1.duration_ = 5

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
		end

		function arg_831_1.playNext_(arg_833_0)
			if arg_833_0 == 1 then
				arg_831_0:Play910201205(arg_831_1)
			end
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			local var_834_0 = 0.55

			if 0 < arg_831_1.time_ and arg_831_1.time_ <= 0 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, true)

				arg_831_1.leftNameTxt_.text = arg_831_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_831_1.leftNameTxt_.transform)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1.leftNameTxt_.text)
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_1 = arg_831_1:FormatText(arg_831_1:GetWordFromCfg(910201204).content)

				arg_831_1.text_.text = var_834_1

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_3 = 22 <= 0 and var_834_0 or var_834_0 * (utf8.len(var_834_1) / 22)

				if (22 <= 0 and var_834_0 or var_834_0 * (utf8.len(var_834_1) / 22)) > 0 and var_834_0 < var_834_3 then
					arg_831_1.talkMaxDuration = var_834_3

					if var_834_3 + 0 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_3 + 0
					end
				end

				arg_831_1.text_.text = var_834_1
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)
				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_4 = math.max(var_834_0, arg_831_1.talkMaxDuration)

			if 0 <= arg_831_1.time_ and arg_831_1.time_ < 0 + var_834_4 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - 0) / var_834_4

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= 0 + var_834_4 and arg_831_1.time_ < 0 + var_834_4 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end

		arg_831_1.nodeConfigList_ = {}

		arg_831_1:InitPlayNodeList()
	end,
	Play910201205 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 910201205
		arg_835_1.duration_ = 5

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play910201206(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			local var_838_0 = 1.075

			if 0 < arg_835_1.time_ and arg_835_1.time_ <= 0 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, true)

				arg_835_1.leftNameTxt_.text = arg_835_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_835_1.leftNameTxt_.transform)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1.leftNameTxt_.text)
				SetActive(arg_835_1.iconTrs_.gameObject, false)
				arg_835_1.callingController_:SetSelectedState("normal")

				local var_838_1 = arg_835_1:FormatText(arg_835_1:GetWordFromCfg(910201205).content)

				arg_835_1.text_.text = var_838_1

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_3 = 43 <= 0 and var_838_0 or var_838_0 * (utf8.len(var_838_1) / 43)

				if (43 <= 0 and var_838_0 or var_838_0 * (utf8.len(var_838_1) / 43)) > 0 and var_838_0 < var_838_3 then
					arg_835_1.talkMaxDuration = var_838_3

					if var_838_3 + 0 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_3 + 0
					end
				end

				arg_835_1.text_.text = var_838_1
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)
				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_4 = math.max(var_838_0, arg_835_1.talkMaxDuration)

			if 0 <= arg_835_1.time_ and arg_835_1.time_ < 0 + var_838_4 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - 0) / var_838_4

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= 0 + var_838_4 and arg_835_1.time_ < 0 + var_838_4 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end

		arg_835_1.nodeConfigList_ = {}

		arg_835_1:InitPlayNodeList()
	end,
	Play910201206 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 910201206
		arg_839_1.duration_ = 5

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
		end

		function arg_839_1.playNext_(arg_841_0)
			if arg_841_0 == 1 then
				arg_839_0:Play910201207(arg_839_1)
			end
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			local var_842_0 = 0.8

			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				arg_839_1.leftNameTxt_.text = arg_839_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, false)
				arg_839_1.callingController_:SetSelectedState("normal")

				local var_842_1 = arg_839_1:FormatText(arg_839_1:GetWordFromCfg(910201206).content)

				arg_839_1.text_.text = var_842_1

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_3 = 32 <= 0 and var_842_0 or var_842_0 * (utf8.len(var_842_1) / 32)

				if (32 <= 0 and var_842_0 or var_842_0 * (utf8.len(var_842_1) / 32)) > 0 and var_842_0 < var_842_3 then
					arg_839_1.talkMaxDuration = var_842_3

					if var_842_3 + 0 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_3 + 0
					end
				end

				arg_839_1.text_.text = var_842_1
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)
				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_4 = math.max(var_842_0, arg_839_1.talkMaxDuration)

			if 0 <= arg_839_1.time_ and arg_839_1.time_ < 0 + var_842_4 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - 0) / var_842_4

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= 0 + var_842_4 and arg_839_1.time_ < 0 + var_842_4 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end

		arg_839_1.nodeConfigList_ = {}

		arg_839_1:InitPlayNodeList()
	end,
	Play910201207 = function(arg_843_0, arg_843_1)
		arg_843_1.time_ = 0
		arg_843_1.frameCnt_ = 0
		arg_843_1.state_ = "playing"
		arg_843_1.curTalkId_ = 910201207
		arg_843_1.duration_ = 5

		SetActive(arg_843_1.tipsGo_, false)

		function arg_843_1.onSingleLineFinish_()
			arg_843_1.onSingleLineUpdate_ = nil
			arg_843_1.onSingleLineFinish_ = nil
			arg_843_1.state_ = "waiting"
		end

		function arg_843_1.playNext_(arg_845_0)
			if arg_845_0 == 1 then
				arg_843_0:Play910201208(arg_843_1)
			end
		end

		function arg_843_1.onSingleLineUpdate_(arg_846_0)
			local var_846_0 = 0.975

			if 0 < arg_843_1.time_ and arg_843_1.time_ <= 0 + arg_846_0 then
				arg_843_1.talkMaxDuration = 0
				arg_843_1.dialogCg_.alpha = 1

				arg_843_1.dialog_:SetActive(true)
				SetActive(arg_843_1.leftNameGo_, true)

				arg_843_1.leftNameTxt_.text = arg_843_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_843_1.leftNameTxt_.transform)

				arg_843_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_843_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_843_1:RecordName(arg_843_1.leftNameTxt_.text)
				SetActive(arg_843_1.iconTrs_.gameObject, false)
				arg_843_1.callingController_:SetSelectedState("normal")

				local var_846_1 = arg_843_1:FormatText(arg_843_1:GetWordFromCfg(910201207).content)

				arg_843_1.text_.text = var_846_1

				LuaForUtil.ClearLinePrefixSymbol(arg_843_1.text_)

				local var_846_3 = 39 <= 0 and var_846_0 or var_846_0 * (utf8.len(var_846_1) / 39)

				if (39 <= 0 and var_846_0 or var_846_0 * (utf8.len(var_846_1) / 39)) > 0 and var_846_0 < var_846_3 then
					arg_843_1.talkMaxDuration = var_846_3

					if var_846_3 + 0 > arg_843_1.duration_ then
						arg_843_1.duration_ = var_846_3 + 0
					end
				end

				arg_843_1.text_.text = var_846_1
				arg_843_1.typewritter.percent = 0

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(false)
				arg_843_1:RecordContent(arg_843_1.text_.text)
			end

			local var_846_4 = math.max(var_846_0, arg_843_1.talkMaxDuration)

			if 0 <= arg_843_1.time_ and arg_843_1.time_ < 0 + var_846_4 then
				arg_843_1.typewritter.percent = (arg_843_1.time_ - 0) / var_846_4

				arg_843_1.typewritter:SetDirty()
			end

			if arg_843_1.time_ >= 0 + var_846_4 and arg_843_1.time_ < 0 + var_846_4 + arg_846_0 then
				arg_843_1.typewritter.percent = 1

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(true)
			end
		end

		arg_843_1.nodeConfigList_ = {}

		arg_843_1:InitPlayNodeList()
	end,
	Play910201208 = function(arg_847_0, arg_847_1)
		arg_847_1.time_ = 0
		arg_847_1.frameCnt_ = 0
		arg_847_1.state_ = "playing"
		arg_847_1.curTalkId_ = 910201208
		arg_847_1.duration_ = 5

		SetActive(arg_847_1.tipsGo_, false)

		function arg_847_1.onSingleLineFinish_()
			arg_847_1.onSingleLineUpdate_ = nil
			arg_847_1.onSingleLineFinish_ = nil
			arg_847_1.state_ = "waiting"
		end

		function arg_847_1.playNext_(arg_849_0)
			if arg_849_0 == 1 then
				arg_847_0:Play910201209(arg_847_1)
			end
		end

		function arg_847_1.onSingleLineUpdate_(arg_850_0)
			local var_850_0 = 0.2

			if 0 < arg_847_1.time_ and arg_847_1.time_ <= 0 + arg_850_0 then
				arg_847_1.talkMaxDuration = 0
				arg_847_1.dialogCg_.alpha = 1

				arg_847_1.dialog_:SetActive(true)
				SetActive(arg_847_1.leftNameGo_, true)

				arg_847_1.leftNameTxt_.text = arg_847_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_847_1.leftNameTxt_.transform)

				arg_847_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_847_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_847_1:RecordName(arg_847_1.leftNameTxt_.text)
				SetActive(arg_847_1.iconTrs_.gameObject, false)
				arg_847_1.callingController_:SetSelectedState("normal")

				local var_850_1 = arg_847_1:FormatText(arg_847_1:GetWordFromCfg(910201208).content)

				arg_847_1.text_.text = var_850_1

				LuaForUtil.ClearLinePrefixSymbol(arg_847_1.text_)

				local var_850_3 = 8 <= 0 and var_850_0 or var_850_0 * (utf8.len(var_850_1) / 8)

				if (8 <= 0 and var_850_0 or var_850_0 * (utf8.len(var_850_1) / 8)) > 0 and var_850_0 < var_850_3 then
					arg_847_1.talkMaxDuration = var_850_3

					if var_850_3 + 0 > arg_847_1.duration_ then
						arg_847_1.duration_ = var_850_3 + 0
					end
				end

				arg_847_1.text_.text = var_850_1
				arg_847_1.typewritter.percent = 0

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(false)
				arg_847_1:RecordContent(arg_847_1.text_.text)
			end

			local var_850_4 = math.max(var_850_0, arg_847_1.talkMaxDuration)

			if 0 <= arg_847_1.time_ and arg_847_1.time_ < 0 + var_850_4 then
				arg_847_1.typewritter.percent = (arg_847_1.time_ - 0) / var_850_4

				arg_847_1.typewritter:SetDirty()
			end

			if arg_847_1.time_ >= 0 + var_850_4 and arg_847_1.time_ < 0 + var_850_4 + arg_850_0 then
				arg_847_1.typewritter.percent = 1

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(true)
			end
		end

		arg_847_1.nodeConfigList_ = {}

		arg_847_1:InitPlayNodeList()
	end,
	Play910201209 = function(arg_851_0, arg_851_1)
		arg_851_1.time_ = 0
		arg_851_1.frameCnt_ = 0
		arg_851_1.state_ = "playing"
		arg_851_1.curTalkId_ = 910201209
		arg_851_1.duration_ = 5

		SetActive(arg_851_1.tipsGo_, false)

		function arg_851_1.onSingleLineFinish_()
			arg_851_1.onSingleLineUpdate_ = nil
			arg_851_1.onSingleLineFinish_ = nil
			arg_851_1.state_ = "waiting"
		end

		function arg_851_1.playNext_(arg_853_0)
			if arg_853_0 == 1 then
				arg_851_0:Play910201210(arg_851_1)
			end
		end

		function arg_851_1.onSingleLineUpdate_(arg_854_0)
			local var_854_0 = 0.175

			if 0 < arg_851_1.time_ and arg_851_1.time_ <= 0 + arg_854_0 then
				arg_851_1.talkMaxDuration = 0
				arg_851_1.dialogCg_.alpha = 1

				arg_851_1.dialog_:SetActive(true)
				SetActive(arg_851_1.leftNameGo_, true)

				arg_851_1.leftNameTxt_.text = arg_851_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_851_1.leftNameTxt_.transform)

				arg_851_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_851_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_851_1:RecordName(arg_851_1.leftNameTxt_.text)
				SetActive(arg_851_1.iconTrs_.gameObject, false)
				arg_851_1.callingController_:SetSelectedState("normal")

				local var_854_1 = arg_851_1:FormatText(arg_851_1:GetWordFromCfg(910201209).content)

				arg_851_1.text_.text = var_854_1

				LuaForUtil.ClearLinePrefixSymbol(arg_851_1.text_)

				local var_854_3 = 7 <= 0 and var_854_0 or var_854_0 * (utf8.len(var_854_1) / 7)

				if (7 <= 0 and var_854_0 or var_854_0 * (utf8.len(var_854_1) / 7)) > 0 and var_854_0 < var_854_3 then
					arg_851_1.talkMaxDuration = var_854_3

					if var_854_3 + 0 > arg_851_1.duration_ then
						arg_851_1.duration_ = var_854_3 + 0
					end
				end

				arg_851_1.text_.text = var_854_1
				arg_851_1.typewritter.percent = 0

				arg_851_1.typewritter:SetDirty()
				arg_851_1:ShowNextGo(false)
				arg_851_1:RecordContent(arg_851_1.text_.text)
			end

			local var_854_4 = math.max(var_854_0, arg_851_1.talkMaxDuration)

			if 0 <= arg_851_1.time_ and arg_851_1.time_ < 0 + var_854_4 then
				arg_851_1.typewritter.percent = (arg_851_1.time_ - 0) / var_854_4

				arg_851_1.typewritter:SetDirty()
			end

			if arg_851_1.time_ >= 0 + var_854_4 and arg_851_1.time_ < 0 + var_854_4 + arg_854_0 then
				arg_851_1.typewritter.percent = 1

				arg_851_1.typewritter:SetDirty()
				arg_851_1:ShowNextGo(true)
			end
		end

		arg_851_1.nodeConfigList_ = {}

		arg_851_1:InitPlayNodeList()
	end,
	Play910201210 = function(arg_855_0, arg_855_1)
		arg_855_1.time_ = 0
		arg_855_1.frameCnt_ = 0
		arg_855_1.state_ = "playing"
		arg_855_1.curTalkId_ = 910201210
		arg_855_1.duration_ = 5

		SetActive(arg_855_1.tipsGo_, false)

		function arg_855_1.onSingleLineFinish_()
			arg_855_1.onSingleLineUpdate_ = nil
			arg_855_1.onSingleLineFinish_ = nil
			arg_855_1.state_ = "waiting"
		end

		function arg_855_1.playNext_(arg_857_0)
			if arg_857_0 == 1 then
				arg_855_0:Play910201211(arg_855_1)
			end
		end

		function arg_855_1.onSingleLineUpdate_(arg_858_0)
			local var_858_0 = 0.7

			if 0 < arg_855_1.time_ and arg_855_1.time_ <= 0 + arg_858_0 then
				arg_855_1.talkMaxDuration = 0
				arg_855_1.dialogCg_.alpha = 1

				arg_855_1.dialog_:SetActive(true)
				SetActive(arg_855_1.leftNameGo_, true)

				arg_855_1.leftNameTxt_.text = arg_855_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_855_1.leftNameTxt_.transform)

				arg_855_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_855_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_855_1:RecordName(arg_855_1.leftNameTxt_.text)
				SetActive(arg_855_1.iconTrs_.gameObject, false)
				arg_855_1.callingController_:SetSelectedState("normal")

				local var_858_1 = arg_855_1:FormatText(arg_855_1:GetWordFromCfg(910201210).content)

				arg_855_1.text_.text = var_858_1

				LuaForUtil.ClearLinePrefixSymbol(arg_855_1.text_)

				local var_858_3 = 28 <= 0 and var_858_0 or var_858_0 * (utf8.len(var_858_1) / 28)

				if (28 <= 0 and var_858_0 or var_858_0 * (utf8.len(var_858_1) / 28)) > 0 and var_858_0 < var_858_3 then
					arg_855_1.talkMaxDuration = var_858_3

					if var_858_3 + 0 > arg_855_1.duration_ then
						arg_855_1.duration_ = var_858_3 + 0
					end
				end

				arg_855_1.text_.text = var_858_1
				arg_855_1.typewritter.percent = 0

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(false)
				arg_855_1:RecordContent(arg_855_1.text_.text)
			end

			local var_858_4 = math.max(var_858_0, arg_855_1.talkMaxDuration)

			if 0 <= arg_855_1.time_ and arg_855_1.time_ < 0 + var_858_4 then
				arg_855_1.typewritter.percent = (arg_855_1.time_ - 0) / var_858_4

				arg_855_1.typewritter:SetDirty()
			end

			if arg_855_1.time_ >= 0 + var_858_4 and arg_855_1.time_ < 0 + var_858_4 + arg_858_0 then
				arg_855_1.typewritter.percent = 1

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(true)
			end
		end

		arg_855_1.nodeConfigList_ = {}

		arg_855_1:InitPlayNodeList()
	end,
	Play910201211 = function(arg_859_0, arg_859_1)
		arg_859_1.time_ = 0
		arg_859_1.frameCnt_ = 0
		arg_859_1.state_ = "playing"
		arg_859_1.curTalkId_ = 910201211
		arg_859_1.duration_ = 5

		SetActive(arg_859_1.tipsGo_, false)

		function arg_859_1.onSingleLineFinish_()
			arg_859_1.onSingleLineUpdate_ = nil
			arg_859_1.onSingleLineFinish_ = nil
			arg_859_1.state_ = "waiting"
		end

		function arg_859_1.playNext_(arg_861_0)
			if arg_861_0 == 1 then
				arg_859_0:Play910201212(arg_859_1)
			end
		end

		function arg_859_1.onSingleLineUpdate_(arg_862_0)
			local var_862_0 = 0.5

			if 0 < arg_859_1.time_ and arg_859_1.time_ <= 0 + arg_862_0 then
				arg_859_1.talkMaxDuration = 0
				arg_859_1.dialogCg_.alpha = 1

				arg_859_1.dialog_:SetActive(true)
				SetActive(arg_859_1.leftNameGo_, true)

				arg_859_1.leftNameTxt_.text = arg_859_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_859_1.leftNameTxt_.transform)

				arg_859_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_859_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_859_1:RecordName(arg_859_1.leftNameTxt_.text)
				SetActive(arg_859_1.iconTrs_.gameObject, false)
				arg_859_1.callingController_:SetSelectedState("normal")

				local var_862_1 = arg_859_1:FormatText(arg_859_1:GetWordFromCfg(910201211).content)

				arg_859_1.text_.text = var_862_1

				LuaForUtil.ClearLinePrefixSymbol(arg_859_1.text_)

				local var_862_3 = 21 <= 0 and var_862_0 or var_862_0 * (utf8.len(var_862_1) / 21)

				if (21 <= 0 and var_862_0 or var_862_0 * (utf8.len(var_862_1) / 21)) > 0 and var_862_0 < var_862_3 then
					arg_859_1.talkMaxDuration = var_862_3

					if var_862_3 + 0 > arg_859_1.duration_ then
						arg_859_1.duration_ = var_862_3 + 0
					end
				end

				arg_859_1.text_.text = var_862_1
				arg_859_1.typewritter.percent = 0

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(false)
				arg_859_1:RecordContent(arg_859_1.text_.text)
			end

			local var_862_4 = math.max(var_862_0, arg_859_1.talkMaxDuration)

			if 0 <= arg_859_1.time_ and arg_859_1.time_ < 0 + var_862_4 then
				arg_859_1.typewritter.percent = (arg_859_1.time_ - 0) / var_862_4

				arg_859_1.typewritter:SetDirty()
			end

			if arg_859_1.time_ >= 0 + var_862_4 and arg_859_1.time_ < 0 + var_862_4 + arg_862_0 then
				arg_859_1.typewritter.percent = 1

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(true)
			end
		end

		arg_859_1.nodeConfigList_ = {}

		arg_859_1:InitPlayNodeList()
	end,
	Play910201212 = function(arg_863_0, arg_863_1)
		arg_863_1.time_ = 0
		arg_863_1.frameCnt_ = 0
		arg_863_1.state_ = "playing"
		arg_863_1.curTalkId_ = 910201212
		arg_863_1.duration_ = 9

		SetActive(arg_863_1.tipsGo_, false)

		function arg_863_1.onSingleLineFinish_()
			arg_863_1.onSingleLineUpdate_ = nil
			arg_863_1.onSingleLineFinish_ = nil
			arg_863_1.state_ = "waiting"
		end

		function arg_863_1.playNext_(arg_865_0)
			if arg_865_0 == 1 then
				arg_863_0:Play910201213(arg_863_1)
			end
		end

		function arg_863_1.onSingleLineUpdate_(arg_866_0)
			if 3.8 < arg_863_1.time_ and arg_863_1.time_ <= 3.8 + arg_866_0 then
				arg_863_1.var_.moveOldPos1039ui_story = arg_863_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_866_0 = 0.001

			if 3.8 <= arg_863_1.time_ and arg_863_1.time_ < 3.8 + var_866_0 then
				arg_863_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_863_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_863_1.time_ - 3.8) / var_866_0)
				arg_863_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_863_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_863_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_863_1.actors_["1039ui_story"].transform.position).z)
				arg_863_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_863_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_863_1.actors_["1039ui_story"].transform.localEulerAngles = arg_863_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_863_1.time_ >= 3.8 + var_866_0 and arg_863_1.time_ < 3.8 + var_866_0 + arg_866_0 then
				arg_863_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_863_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_863_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_863_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_863_1.actors_["1039ui_story"].transform.position).z)
				arg_863_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_863_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_863_1.actors_["1039ui_story"].transform.localEulerAngles = arg_863_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 3.8 < arg_863_1.time_ and arg_863_1.time_ <= 3.8 + arg_866_0 then
				arg_863_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 3.8 < arg_863_1.time_ and arg_863_1.time_ <= 3.8 + arg_866_0 then
				arg_863_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_866_1 = arg_863_1.actors_["1039ui_story"]

			if 3.8 < arg_863_1.time_ and arg_863_1.time_ <= 3.8 + arg_866_0 and not isNil(var_866_1) and arg_863_1.var_.characterEffect1039ui_story == nil then
				arg_863_1.var_.characterEffect1039ui_story = var_866_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_866_2 = 0.2

			if 3.8 <= arg_863_1.time_ and arg_863_1.time_ < 3.8 + var_866_2 and not isNil(var_866_1) then
				if arg_863_1.var_.characterEffect1039ui_story and not isNil(var_866_1) then
					arg_863_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_863_1.time_ >= 3.8 + var_866_2 and arg_863_1.time_ < 3.8 + var_866_2 + arg_866_0 and not isNil(var_866_1) and arg_863_1.var_.characterEffect1039ui_story then
				arg_863_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_866_4 = 0

			if 0 < arg_863_1.time_ and arg_863_1.time_ <= var_866_4 + arg_866_0 then
				arg_863_1.mask_.enabled = true
				arg_863_1.mask_.raycastTarget = true

				arg_863_1:SetGaussion(false)
			end

			local var_866_5 = 2

			if var_866_4 <= arg_863_1.time_ and arg_863_1.time_ < var_866_4 + var_866_5 then
				local var_866_6 = Color.New(0, 0, 0)

				var_866_6.a = Mathf.Lerp(0, 1, (arg_863_1.time_ - var_866_4) / var_866_5)
				arg_863_1.mask_.color = var_866_6
			end

			if arg_863_1.time_ >= var_866_4 + var_866_5 and arg_863_1.time_ < var_866_4 + var_866_5 + arg_866_0 then
				local var_866_7 = Color.New(0, 0, 0)

				var_866_7.a = 1
				arg_863_1.mask_.color = var_866_7
			end

			local var_866_8 = 2

			if 2 < arg_863_1.time_ and arg_863_1.time_ <= var_866_8 + arg_866_0 then
				arg_863_1.mask_.enabled = true
				arg_863_1.mask_.raycastTarget = true

				arg_863_1:SetGaussion(false)
			end

			local var_866_9 = 2

			if var_866_8 <= arg_863_1.time_ and arg_863_1.time_ < var_866_8 + var_866_9 then
				local var_866_10 = Color.New(0, 0, 0)

				var_866_10.a = Mathf.Lerp(1, 0, (arg_863_1.time_ - var_866_8) / var_866_9)
				arg_863_1.mask_.color = var_866_10
			end

			if arg_863_1.time_ >= var_866_8 + var_866_9 and arg_863_1.time_ < var_866_8 + var_866_9 + arg_866_0 then
				local var_866_11 = Color.New(0, 0, 0)

				arg_863_1.mask_.enabled = false
				var_866_11.a = 0
				arg_863_1.mask_.color = var_866_11
			end

			if 2 < arg_863_1.time_ and arg_863_1.time_ <= 2 + arg_866_0 then
				local var_866_12 = arg_863_1.bgs_.ST05

				arg_863_1.bgs_.ST05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_866_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_866_13 = var_866_12:GetComponent("SpriteRenderer")

				if var_866_13 and var_866_13.sprite then
					local var_866_14 = 2 * (var_866_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_866_12.transform.localScale = Vector3.New(var_866_14 / var_866_13.sprite.bounds.size.y < var_866_14 * manager.ui.mainCameraCom_.aspect / var_866_13.sprite.bounds.size.x and var_866_14 * manager.ui.mainCameraCom_.aspect / var_866_13.sprite.bounds.size.x or var_866_14 / var_866_13.sprite.bounds.size.y, var_866_14 / var_866_13.sprite.bounds.size.y < var_866_14 * manager.ui.mainCameraCom_.aspect / var_866_13.sprite.bounds.size.x and var_866_14 * manager.ui.mainCameraCom_.aspect / var_866_13.sprite.bounds.size.x or var_866_14 / var_866_13.sprite.bounds.size.y, 0)
				end

				for iter_866_0, iter_866_1 in pairs(arg_863_1.bgs_) do
					if iter_866_0 ~= "ST05" then
						iter_866_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_866_15 = 4
			local var_866_16 = 0.975

			if 4 < arg_863_1.time_ and arg_863_1.time_ <= var_866_15 + arg_866_0 then
				arg_863_1.talkMaxDuration = 0
				arg_863_1.dialogCg_.alpha = 1

				arg_863_1.dialog_:SetActive(true)
				SetActive(arg_863_1.leftNameGo_, true)

				arg_863_1.leftNameTxt_.text = arg_863_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_863_1.leftNameTxt_.transform)

				arg_863_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_863_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_863_1:RecordName(arg_863_1.leftNameTxt_.text)
				SetActive(arg_863_1.iconTrs_.gameObject, false)
				arg_863_1.callingController_:SetSelectedState("normal")

				local var_866_17 = arg_863_1:FormatText(arg_863_1:GetWordFromCfg(910201212).content)

				arg_863_1.text_.text = var_866_17

				LuaForUtil.ClearLinePrefixSymbol(arg_863_1.text_)

				local var_866_19 = 39 <= 0 and var_866_16 or var_866_16 * (utf8.len(var_866_17) / 39)

				if (39 <= 0 and var_866_16 or var_866_16 * (utf8.len(var_866_17) / 39)) > 0 and var_866_16 < var_866_19 then
					arg_863_1.talkMaxDuration = var_866_19

					if var_866_19 + var_866_15 > arg_863_1.duration_ then
						arg_863_1.duration_ = var_866_19 + var_866_15
					end
				end

				arg_863_1.text_.text = var_866_17
				arg_863_1.typewritter.percent = 0

				arg_863_1.typewritter:SetDirty()
				arg_863_1:ShowNextGo(false)
				arg_863_1:RecordContent(arg_863_1.text_.text)
			end

			local var_866_20 = math.max(var_866_16, arg_863_1.talkMaxDuration)

			if var_866_15 <= arg_863_1.time_ and arg_863_1.time_ < var_866_15 + var_866_20 then
				arg_863_1.typewritter.percent = (arg_863_1.time_ - var_866_15) / var_866_20

				arg_863_1.typewritter:SetDirty()
			end

			if arg_863_1.time_ >= var_866_15 + var_866_20 and arg_863_1.time_ < var_866_15 + var_866_20 + arg_866_0 then
				arg_863_1.typewritter.percent = 1

				arg_863_1.typewritter:SetDirty()
				arg_863_1:ShowNextGo(true)
			end
		end

		arg_863_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_863_1:InitPlayNodeList()
	end,
	Play910201213 = function(arg_867_0, arg_867_1)
		arg_867_1.time_ = 0
		arg_867_1.frameCnt_ = 0
		arg_867_1.state_ = "playing"
		arg_867_1.curTalkId_ = 910201213
		arg_867_1.duration_ = 5

		SetActive(arg_867_1.tipsGo_, false)

		function arg_867_1.onSingleLineFinish_()
			arg_867_1.onSingleLineUpdate_ = nil
			arg_867_1.onSingleLineFinish_ = nil
			arg_867_1.state_ = "waiting"
		end

		function arg_867_1.playNext_(arg_869_0)
			if arg_869_0 == 1 then
				arg_867_0:Play910201214(arg_867_1)
			end
		end

		function arg_867_1.onSingleLineUpdate_(arg_870_0)
			if 0 < arg_867_1.time_ and arg_867_1.time_ <= 0 + arg_870_0 then
				arg_867_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			if 0 < arg_867_1.time_ and arg_867_1.time_ <= 0 + arg_870_0 then
				arg_867_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_870_0 = 0
			local var_870_1 = 0.575

			if 0 < arg_867_1.time_ and arg_867_1.time_ <= var_870_0 + arg_870_0 then
				arg_867_1.talkMaxDuration = 0
				arg_867_1.dialogCg_.alpha = 1

				arg_867_1.dialog_:SetActive(true)
				SetActive(arg_867_1.leftNameGo_, true)

				arg_867_1.leftNameTxt_.text = arg_867_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_867_1.leftNameTxt_.transform)

				arg_867_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_867_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_867_1:RecordName(arg_867_1.leftNameTxt_.text)
				SetActive(arg_867_1.iconTrs_.gameObject, false)
				arg_867_1.callingController_:SetSelectedState("normal")

				local var_870_2 = arg_867_1:FormatText(arg_867_1:GetWordFromCfg(910201213).content)

				arg_867_1.text_.text = var_870_2

				LuaForUtil.ClearLinePrefixSymbol(arg_867_1.text_)

				local var_870_4 = 23 <= 0 and var_870_1 or var_870_1 * (utf8.len(var_870_2) / 23)

				if (23 <= 0 and var_870_1 or var_870_1 * (utf8.len(var_870_2) / 23)) > 0 and var_870_1 < var_870_4 then
					arg_867_1.talkMaxDuration = var_870_4

					if var_870_4 + var_870_0 > arg_867_1.duration_ then
						arg_867_1.duration_ = var_870_4 + var_870_0
					end
				end

				arg_867_1.text_.text = var_870_2
				arg_867_1.typewritter.percent = 0

				arg_867_1.typewritter:SetDirty()
				arg_867_1:ShowNextGo(false)
				arg_867_1:RecordContent(arg_867_1.text_.text)
			end

			local var_870_5 = math.max(var_870_1, arg_867_1.talkMaxDuration)

			if var_870_0 <= arg_867_1.time_ and arg_867_1.time_ < var_870_0 + var_870_5 then
				arg_867_1.typewritter.percent = (arg_867_1.time_ - var_870_0) / var_870_5

				arg_867_1.typewritter:SetDirty()
			end

			if arg_867_1.time_ >= var_870_0 + var_870_5 and arg_867_1.time_ < var_870_0 + var_870_5 + arg_870_0 then
				arg_867_1.typewritter.percent = 1

				arg_867_1.typewritter:SetDirty()
				arg_867_1:ShowNextGo(true)
			end
		end

		arg_867_1.nodeConfigList_ = {}

		arg_867_1:InitPlayNodeList()
	end,
	Play910201214 = function(arg_871_0, arg_871_1)
		arg_871_1.time_ = 0
		arg_871_1.frameCnt_ = 0
		arg_871_1.state_ = "playing"
		arg_871_1.curTalkId_ = 910201214
		arg_871_1.duration_ = 5

		SetActive(arg_871_1.tipsGo_, false)

		function arg_871_1.onSingleLineFinish_()
			arg_871_1.onSingleLineUpdate_ = nil
			arg_871_1.onSingleLineFinish_ = nil
			arg_871_1.state_ = "waiting"
		end

		function arg_871_1.playNext_(arg_873_0)
			if arg_873_0 == 1 then
				arg_871_0:Play910201215(arg_871_1)
			end
		end

		function arg_871_1.onSingleLineUpdate_(arg_874_0)
			if 0 < arg_871_1.time_ and arg_871_1.time_ <= 0 + arg_874_0 and not isNil(arg_871_1.actors_["1039ui_story"]) and arg_871_1.var_.characterEffect1039ui_story == nil then
				arg_871_1.var_.characterEffect1039ui_story = arg_871_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_874_0 = 0.2

			if 0 <= arg_871_1.time_ and arg_871_1.time_ < 0 + var_874_0 and not isNil(arg_871_1.actors_["1039ui_story"]) then
				if arg_871_1.var_.characterEffect1039ui_story and not isNil(arg_871_1.actors_["1039ui_story"]) then
					arg_871_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_871_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_871_1.time_ - 0) / var_874_0)
				end
			end

			if arg_871_1.time_ >= 0 + var_874_0 and arg_871_1.time_ < 0 + var_874_0 + arg_874_0 and not isNil(arg_871_1.actors_["1039ui_story"]) and arg_871_1.var_.characterEffect1039ui_story then
				arg_871_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_871_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_874_1 = 0
			local var_874_2 = 0.35

			if 0 < arg_871_1.time_ and arg_871_1.time_ <= var_874_1 + arg_874_0 then
				arg_871_1.talkMaxDuration = 0
				arg_871_1.dialogCg_.alpha = 1

				arg_871_1.dialog_:SetActive(true)
				SetActive(arg_871_1.leftNameGo_, true)

				arg_871_1.leftNameTxt_.text = arg_871_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_871_1.leftNameTxt_.transform)

				arg_871_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_871_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_871_1:RecordName(arg_871_1.leftNameTxt_.text)
				SetActive(arg_871_1.iconTrs_.gameObject, true)
				arg_871_1.iconController_:SetSelectedState("hero")

				arg_871_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_871_1.callingController_:SetSelectedState("normal")

				arg_871_1.keyicon_.color = Color.New(1, 1, 1)
				arg_871_1.icon_.color = Color.New(1, 1, 1)

				local var_874_3 = arg_871_1:FormatText(arg_871_1:GetWordFromCfg(910201214).content)

				arg_871_1.text_.text = var_874_3

				LuaForUtil.ClearLinePrefixSymbol(arg_871_1.text_)

				local var_874_5 = 14 <= 0 and var_874_2 or var_874_2 * (utf8.len(var_874_3) / 14)

				if (14 <= 0 and var_874_2 or var_874_2 * (utf8.len(var_874_3) / 14)) > 0 and var_874_2 < var_874_5 then
					arg_871_1.talkMaxDuration = var_874_5

					if var_874_5 + var_874_1 > arg_871_1.duration_ then
						arg_871_1.duration_ = var_874_5 + var_874_1
					end
				end

				arg_871_1.text_.text = var_874_3
				arg_871_1.typewritter.percent = 0

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(false)
				arg_871_1:RecordContent(arg_871_1.text_.text)
			end

			local var_874_6 = math.max(var_874_2, arg_871_1.talkMaxDuration)

			if var_874_1 <= arg_871_1.time_ and arg_871_1.time_ < var_874_1 + var_874_6 then
				arg_871_1.typewritter.percent = (arg_871_1.time_ - var_874_1) / var_874_6

				arg_871_1.typewritter:SetDirty()
			end

			if arg_871_1.time_ >= var_874_1 + var_874_6 and arg_871_1.time_ < var_874_1 + var_874_6 + arg_874_0 then
				arg_871_1.typewritter.percent = 1

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(true)
			end
		end

		arg_871_1.nodeConfigList_ = {}

		arg_871_1:InitPlayNodeList()
	end,
	Play910201215 = function(arg_875_0, arg_875_1)
		arg_875_1.time_ = 0
		arg_875_1.frameCnt_ = 0
		arg_875_1.state_ = "playing"
		arg_875_1.curTalkId_ = 910201215
		arg_875_1.duration_ = 5

		SetActive(arg_875_1.tipsGo_, false)

		function arg_875_1.onSingleLineFinish_()
			arg_875_1.onSingleLineUpdate_ = nil
			arg_875_1.onSingleLineFinish_ = nil
			arg_875_1.state_ = "waiting"
		end

		function arg_875_1.playNext_(arg_877_0)
			if arg_877_0 == 1 then
				arg_875_0:Play910201216(arg_875_1)
			end
		end

		function arg_875_1.onSingleLineUpdate_(arg_878_0)
			if 0 < arg_875_1.time_ and arg_875_1.time_ <= 0 + arg_878_0 and not isNil(arg_875_1.actors_["1039ui_story"]) and arg_875_1.var_.characterEffect1039ui_story == nil then
				arg_875_1.var_.characterEffect1039ui_story = arg_875_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_878_0 = 0.2

			if 0 <= arg_875_1.time_ and arg_875_1.time_ < 0 + var_878_0 and not isNil(arg_875_1.actors_["1039ui_story"]) then
				if arg_875_1.var_.characterEffect1039ui_story and not isNil(arg_875_1.actors_["1039ui_story"]) then
					arg_875_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_875_1.time_ >= 0 + var_878_0 and arg_875_1.time_ < 0 + var_878_0 + arg_878_0 and not isNil(arg_875_1.actors_["1039ui_story"]) and arg_875_1.var_.characterEffect1039ui_story then
				arg_875_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_875_1.time_ and arg_875_1.time_ <= 0 + arg_878_0 then
				arg_875_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			if 0 < arg_875_1.time_ and arg_875_1.time_ <= 0 + arg_878_0 then
				arg_875_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_878_2 = 0
			local var_878_3 = 0.25

			if 0 < arg_875_1.time_ and arg_875_1.time_ <= var_878_2 + arg_878_0 then
				arg_875_1.talkMaxDuration = 0
				arg_875_1.dialogCg_.alpha = 1

				arg_875_1.dialog_:SetActive(true)
				SetActive(arg_875_1.leftNameGo_, true)

				arg_875_1.leftNameTxt_.text = arg_875_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_875_1.leftNameTxt_.transform)

				arg_875_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_875_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_875_1:RecordName(arg_875_1.leftNameTxt_.text)
				SetActive(arg_875_1.iconTrs_.gameObject, false)
				arg_875_1.callingController_:SetSelectedState("normal")

				local var_878_4 = arg_875_1:FormatText(arg_875_1:GetWordFromCfg(910201215).content)

				arg_875_1.text_.text = var_878_4

				LuaForUtil.ClearLinePrefixSymbol(arg_875_1.text_)

				local var_878_6 = 10 <= 0 and var_878_3 or var_878_3 * (utf8.len(var_878_4) / 10)

				if (10 <= 0 and var_878_3 or var_878_3 * (utf8.len(var_878_4) / 10)) > 0 and var_878_3 < var_878_6 then
					arg_875_1.talkMaxDuration = var_878_6

					if var_878_6 + var_878_2 > arg_875_1.duration_ then
						arg_875_1.duration_ = var_878_6 + var_878_2
					end
				end

				arg_875_1.text_.text = var_878_4
				arg_875_1.typewritter.percent = 0

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(false)
				arg_875_1:RecordContent(arg_875_1.text_.text)
			end

			local var_878_7 = math.max(var_878_3, arg_875_1.talkMaxDuration)

			if var_878_2 <= arg_875_1.time_ and arg_875_1.time_ < var_878_2 + var_878_7 then
				arg_875_1.typewritter.percent = (arg_875_1.time_ - var_878_2) / var_878_7

				arg_875_1.typewritter:SetDirty()
			end

			if arg_875_1.time_ >= var_878_2 + var_878_7 and arg_875_1.time_ < var_878_2 + var_878_7 + arg_878_0 then
				arg_875_1.typewritter.percent = 1

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(true)
			end
		end

		arg_875_1.nodeConfigList_ = {}

		arg_875_1:InitPlayNodeList()
	end,
	Play910201216 = function(arg_879_0, arg_879_1)
		arg_879_1.time_ = 0
		arg_879_1.frameCnt_ = 0
		arg_879_1.state_ = "playing"
		arg_879_1.curTalkId_ = 910201216
		arg_879_1.duration_ = 5

		SetActive(arg_879_1.tipsGo_, false)

		function arg_879_1.onSingleLineFinish_()
			arg_879_1.onSingleLineUpdate_ = nil
			arg_879_1.onSingleLineFinish_ = nil
			arg_879_1.state_ = "waiting"
		end

		function arg_879_1.playNext_(arg_881_0)
			if arg_881_0 == 1 then
				arg_879_0:Play910201217(arg_879_1)
			end
		end

		function arg_879_1.onSingleLineUpdate_(arg_882_0)
			if 0 < arg_879_1.time_ and arg_879_1.time_ <= 0 + arg_882_0 then
				arg_879_1.var_.moveOldPos1084ui_story = arg_879_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_882_0 = 0.001

			if 0 <= arg_879_1.time_ and arg_879_1.time_ < 0 + var_882_0 then
				arg_879_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_879_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_879_1.time_ - 0) / var_882_0)
				arg_879_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_879_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_879_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_879_1.actors_["1084ui_story"].transform.position).z)
				arg_879_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_879_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_879_1.actors_["1084ui_story"].transform.localEulerAngles = arg_879_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_879_1.time_ >= 0 + var_882_0 and arg_879_1.time_ < 0 + var_882_0 + arg_882_0 then
				arg_879_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_879_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_879_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_879_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_879_1.actors_["1084ui_story"].transform.position).z)
				arg_879_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_879_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_879_1.actors_["1084ui_story"].transform.localEulerAngles = arg_879_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_882_1 = arg_879_1.actors_["1039ui_story"].transform

			if 0 < arg_879_1.time_ and arg_879_1.time_ <= 0 + arg_882_0 then
				arg_879_1.var_.moveOldPos1039ui_story = var_882_1.localPosition
			end

			local var_882_2 = 0.001

			if 0 <= arg_879_1.time_ and arg_879_1.time_ < 0 + var_882_2 then
				var_882_1.localPosition = Vector3.Lerp(arg_879_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_879_1.time_ - 0) / var_882_2)
				var_882_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_882_1.position).x, (manager.ui.mainCamera.transform.position - var_882_1.position).y, (manager.ui.mainCamera.transform.position - var_882_1.position).z)
				var_882_1.localEulerAngles.z = 0
				var_882_1.localEulerAngles.x = 0
				var_882_1.localEulerAngles = var_882_1.localEulerAngles
			end

			if arg_879_1.time_ >= 0 + var_882_2 and arg_879_1.time_ < 0 + var_882_2 + arg_882_0 then
				var_882_1.localPosition = Vector3.New(0, 100, 0)
				var_882_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_882_1.position).x, (manager.ui.mainCamera.transform.position - var_882_1.position).y, (manager.ui.mainCamera.transform.position - var_882_1.position).z)
				var_882_1.localEulerAngles.z = 0
				var_882_1.localEulerAngles.x = 0
				var_882_1.localEulerAngles = var_882_1.localEulerAngles
			end

			if 0 < arg_879_1.time_ and arg_879_1.time_ <= 0 + arg_882_0 then
				arg_879_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_882_3 = arg_879_1.actors_["1084ui_story"]

			if 0 < arg_879_1.time_ and arg_879_1.time_ <= 0 + arg_882_0 and not isNil(var_882_3) and arg_879_1.var_.characterEffect1084ui_story == nil then
				arg_879_1.var_.characterEffect1084ui_story = var_882_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_882_4 = 0.2

			if 0 <= arg_879_1.time_ and arg_879_1.time_ < 0 + var_882_4 and not isNil(var_882_3) then
				if arg_879_1.var_.characterEffect1084ui_story and not isNil(var_882_3) then
					arg_879_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_879_1.time_ >= 0 + var_882_4 and arg_879_1.time_ < 0 + var_882_4 + arg_882_0 and not isNil(var_882_3) and arg_879_1.var_.characterEffect1084ui_story then
				arg_879_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_879_1.time_ and arg_879_1.time_ <= 0 + arg_882_0 then
				arg_879_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_882_6 = 0
			local var_882_7 = 0.8

			if 0 < arg_879_1.time_ and arg_879_1.time_ <= var_882_6 + arg_882_0 then
				arg_879_1.talkMaxDuration = 0
				arg_879_1.dialogCg_.alpha = 1

				arg_879_1.dialog_:SetActive(true)
				SetActive(arg_879_1.leftNameGo_, true)

				arg_879_1.leftNameTxt_.text = arg_879_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_879_1.leftNameTxt_.transform)

				arg_879_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_879_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_879_1:RecordName(arg_879_1.leftNameTxt_.text)
				SetActive(arg_879_1.iconTrs_.gameObject, false)
				arg_879_1.callingController_:SetSelectedState("normal")

				local var_882_8 = arg_879_1:FormatText(arg_879_1:GetWordFromCfg(910201216).content)

				arg_879_1.text_.text = var_882_8

				LuaForUtil.ClearLinePrefixSymbol(arg_879_1.text_)

				local var_882_10 = 32 <= 0 and var_882_7 or var_882_7 * (utf8.len(var_882_8) / 32)

				if (32 <= 0 and var_882_7 or var_882_7 * (utf8.len(var_882_8) / 32)) > 0 and var_882_7 < var_882_10 then
					arg_879_1.talkMaxDuration = var_882_10

					if var_882_10 + var_882_6 > arg_879_1.duration_ then
						arg_879_1.duration_ = var_882_10 + var_882_6
					end
				end

				arg_879_1.text_.text = var_882_8
				arg_879_1.typewritter.percent = 0

				arg_879_1.typewritter:SetDirty()
				arg_879_1:ShowNextGo(false)
				arg_879_1:RecordContent(arg_879_1.text_.text)
			end

			local var_882_11 = math.max(var_882_7, arg_879_1.talkMaxDuration)

			if var_882_6 <= arg_879_1.time_ and arg_879_1.time_ < var_882_6 + var_882_11 then
				arg_879_1.typewritter.percent = (arg_879_1.time_ - var_882_6) / var_882_11

				arg_879_1.typewritter:SetDirty()
			end

			if arg_879_1.time_ >= var_882_6 + var_882_11 and arg_879_1.time_ < var_882_6 + var_882_11 + arg_882_0 then
				arg_879_1.typewritter.percent = 1

				arg_879_1.typewritter:SetDirty()
				arg_879_1:ShowNextGo(true)
			end
		end

		arg_879_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_879_1:InitPlayNodeList()
	end,
	Play910201217 = function(arg_883_0, arg_883_1)
		arg_883_1.time_ = 0
		arg_883_1.frameCnt_ = 0
		arg_883_1.state_ = "playing"
		arg_883_1.curTalkId_ = 910201217
		arg_883_1.duration_ = 0.2

		SetActive(arg_883_1.tipsGo_, false)

		function arg_883_1.onSingleLineFinish_()
			arg_883_1.onSingleLineUpdate_ = nil
			arg_883_1.onSingleLineFinish_ = nil
			arg_883_1.state_ = "waiting"

			SetActive(arg_883_1.choicesGo_, true)

			for iter_884_0, iter_884_1 in ipairs(arg_883_1.choices_) do
				SetActive(iter_884_1.go, iter_884_0 <= 2)
			end

			arg_883_1.choices_[1].txt.text = arg_883_1:FormatText(StoryChoiceCfg[250].name)
			arg_883_1.choices_[2].txt.text = arg_883_1:FormatText(StoryChoiceCfg[251].name)
		end

		function arg_883_1.playNext_(arg_885_0)
			if arg_885_0 == 1 then
				arg_883_0:Play910201218(arg_883_1)
			end

			if arg_885_0 == 2 then
				arg_883_0:Play910201218(arg_883_1)
			end

			arg_883_1:RecordChoiceLog(910201217, 250, 251)
		end

		function arg_883_1.onSingleLineUpdate_(arg_886_0)
			if 0 < arg_883_1.time_ and arg_883_1.time_ <= 0 + arg_886_0 and not isNil(arg_883_1.actors_["1084ui_story"]) and arg_883_1.var_.characterEffect1084ui_story == nil then
				arg_883_1.var_.characterEffect1084ui_story = arg_883_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_886_0 = 0.2

			if 0 <= arg_883_1.time_ and arg_883_1.time_ < 0 + var_886_0 and not isNil(arg_883_1.actors_["1084ui_story"]) then
				if arg_883_1.var_.characterEffect1084ui_story and not isNil(arg_883_1.actors_["1084ui_story"]) then
					arg_883_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_883_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_883_1.time_ - 0) / var_886_0)
				end
			end

			if arg_883_1.time_ >= 0 + var_886_0 and arg_883_1.time_ < 0 + var_886_0 + arg_886_0 and not isNil(arg_883_1.actors_["1084ui_story"]) and arg_883_1.var_.characterEffect1084ui_story then
				arg_883_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_883_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_883_1.nodeConfigList_ = {}

		arg_883_1:InitPlayNodeList()
	end,
	Play910201218 = function(arg_887_0, arg_887_1)
		arg_887_1.time_ = 0
		arg_887_1.frameCnt_ = 0
		arg_887_1.state_ = "playing"
		arg_887_1.curTalkId_ = 910201218
		arg_887_1.duration_ = 5

		SetActive(arg_887_1.tipsGo_, false)

		function arg_887_1.onSingleLineFinish_()
			arg_887_1.onSingleLineUpdate_ = nil
			arg_887_1.onSingleLineFinish_ = nil
			arg_887_1.state_ = "waiting"
		end

		function arg_887_1.playNext_(arg_889_0)
			if arg_889_0 == 1 then
				arg_887_0:Play910201219(arg_887_1)
			end
		end

		function arg_887_1.onSingleLineUpdate_(arg_890_0)
			if arg_887_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_890_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_887_1.stage_.transform)

				var_890_0.name = "1084ui_story"
				var_890_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_887_1.actors_["1084ui_story"] = var_890_0

				local var_890_1 = var_890_0:GetComponentInChildren(typeof(CharacterEffect))

				var_890_1.enabled = true

				local var_890_2 = GameObjectTools.GetOrAddComponent(var_890_0, typeof(DynamicBoneHelper))

				if var_890_2 then
					var_890_2:EnableDynamicBone(false)
				end

				arg_887_1:ShowWeapon(var_890_1.transform, false)

				arg_887_1.var_["1084ui_story" .. "Animator"] = var_890_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_887_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_887_1.var_["1084ui_story" .. "LipSync"] = var_890_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_887_1.time_ and arg_887_1.time_ <= 0 + arg_890_0 then
				arg_887_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_890_3 = 0
			local var_890_4 = 0.95

			if 0 < arg_887_1.time_ and arg_887_1.time_ <= var_890_3 + arg_890_0 then
				arg_887_1.talkMaxDuration = 0
				arg_887_1.dialogCg_.alpha = 1

				arg_887_1.dialog_:SetActive(true)
				SetActive(arg_887_1.leftNameGo_, true)

				arg_887_1.leftNameTxt_.text = arg_887_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_887_1.leftNameTxt_.transform)

				arg_887_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_887_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_887_1:RecordName(arg_887_1.leftNameTxt_.text)
				SetActive(arg_887_1.iconTrs_.gameObject, true)
				arg_887_1.iconController_:SetSelectedState("hero")

				arg_887_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_887_1.callingController_:SetSelectedState("normal")

				arg_887_1.keyicon_.color = Color.New(1, 1, 1)
				arg_887_1.icon_.color = Color.New(1, 1, 1)

				local var_890_5 = arg_887_1:FormatText(arg_887_1:GetWordFromCfg(910201218).content)

				arg_887_1.text_.text = var_890_5

				LuaForUtil.ClearLinePrefixSymbol(arg_887_1.text_)

				local var_890_7 = 38 <= 0 and var_890_4 or var_890_4 * (utf8.len(var_890_5) / 38)

				if (38 <= 0 and var_890_4 or var_890_4 * (utf8.len(var_890_5) / 38)) > 0 and var_890_4 < var_890_7 then
					arg_887_1.talkMaxDuration = var_890_7

					if var_890_7 + var_890_3 > arg_887_1.duration_ then
						arg_887_1.duration_ = var_890_7 + var_890_3
					end
				end

				arg_887_1.text_.text = var_890_5
				arg_887_1.typewritter.percent = 0

				arg_887_1.typewritter:SetDirty()
				arg_887_1:ShowNextGo(false)
				arg_887_1:RecordContent(arg_887_1.text_.text)
			end

			local var_890_8 = math.max(var_890_4, arg_887_1.talkMaxDuration)

			if var_890_3 <= arg_887_1.time_ and arg_887_1.time_ < var_890_3 + var_890_8 then
				arg_887_1.typewritter.percent = (arg_887_1.time_ - var_890_3) / var_890_8

				arg_887_1.typewritter:SetDirty()
			end

			if arg_887_1.time_ >= var_890_3 + var_890_8 and arg_887_1.time_ < var_890_3 + var_890_8 + arg_890_0 then
				arg_887_1.typewritter.percent = 1

				arg_887_1.typewritter:SetDirty()
				arg_887_1:ShowNextGo(true)
			end
		end

		arg_887_1.nodeConfigList_ = {}

		arg_887_1:InitPlayNodeList()
	end,
	Play910201219 = function(arg_891_0, arg_891_1)
		arg_891_1.time_ = 0
		arg_891_1.frameCnt_ = 0
		arg_891_1.state_ = "playing"
		arg_891_1.curTalkId_ = 910201219
		arg_891_1.duration_ = 5

		SetActive(arg_891_1.tipsGo_, false)

		function arg_891_1.onSingleLineFinish_()
			arg_891_1.onSingleLineUpdate_ = nil
			arg_891_1.onSingleLineFinish_ = nil
			arg_891_1.state_ = "waiting"
		end

		function arg_891_1.playNext_(arg_893_0)
			if arg_893_0 == 1 then
				arg_891_0:Play910201220(arg_891_1)
			end
		end

		function arg_891_1.onSingleLineUpdate_(arg_894_0)
			local var_894_0 = 0.875

			if 0 < arg_891_1.time_ and arg_891_1.time_ <= 0 + arg_894_0 then
				arg_891_1.talkMaxDuration = 0
				arg_891_1.dialogCg_.alpha = 1

				arg_891_1.dialog_:SetActive(true)
				SetActive(arg_891_1.leftNameGo_, true)

				arg_891_1.leftNameTxt_.text = arg_891_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_891_1.leftNameTxt_.transform)

				arg_891_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_891_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_891_1:RecordName(arg_891_1.leftNameTxt_.text)
				SetActive(arg_891_1.iconTrs_.gameObject, true)
				arg_891_1.iconController_:SetSelectedState("hero")

				arg_891_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_891_1.callingController_:SetSelectedState("normal")

				arg_891_1.keyicon_.color = Color.New(1, 1, 1)
				arg_891_1.icon_.color = Color.New(1, 1, 1)

				local var_894_1 = arg_891_1:FormatText(arg_891_1:GetWordFromCfg(910201219).content)

				arg_891_1.text_.text = var_894_1

				LuaForUtil.ClearLinePrefixSymbol(arg_891_1.text_)

				local var_894_3 = 35 <= 0 and var_894_0 or var_894_0 * (utf8.len(var_894_1) / 35)

				if (35 <= 0 and var_894_0 or var_894_0 * (utf8.len(var_894_1) / 35)) > 0 and var_894_0 < var_894_3 then
					arg_891_1.talkMaxDuration = var_894_3

					if var_894_3 + 0 > arg_891_1.duration_ then
						arg_891_1.duration_ = var_894_3 + 0
					end
				end

				arg_891_1.text_.text = var_894_1
				arg_891_1.typewritter.percent = 0

				arg_891_1.typewritter:SetDirty()
				arg_891_1:ShowNextGo(false)
				arg_891_1:RecordContent(arg_891_1.text_.text)
			end

			local var_894_4 = math.max(var_894_0, arg_891_1.talkMaxDuration)

			if 0 <= arg_891_1.time_ and arg_891_1.time_ < 0 + var_894_4 then
				arg_891_1.typewritter.percent = (arg_891_1.time_ - 0) / var_894_4

				arg_891_1.typewritter:SetDirty()
			end

			if arg_891_1.time_ >= 0 + var_894_4 and arg_891_1.time_ < 0 + var_894_4 + arg_894_0 then
				arg_891_1.typewritter.percent = 1

				arg_891_1.typewritter:SetDirty()
				arg_891_1:ShowNextGo(true)
			end
		end

		arg_891_1.nodeConfigList_ = {}

		arg_891_1:InitPlayNodeList()
	end,
	Play910201220 = function(arg_895_0, arg_895_1)
		arg_895_1.time_ = 0
		arg_895_1.frameCnt_ = 0
		arg_895_1.state_ = "playing"
		arg_895_1.curTalkId_ = 910201220
		arg_895_1.duration_ = 5

		SetActive(arg_895_1.tipsGo_, false)

		function arg_895_1.onSingleLineFinish_()
			arg_895_1.onSingleLineUpdate_ = nil
			arg_895_1.onSingleLineFinish_ = nil
			arg_895_1.state_ = "waiting"
		end

		function arg_895_1.playNext_(arg_897_0)
			if arg_897_0 == 1 then
				arg_895_0:Play910201221(arg_895_1)
			end
		end

		function arg_895_1.onSingleLineUpdate_(arg_898_0)
			local var_898_0 = 0.8

			if 0 < arg_895_1.time_ and arg_895_1.time_ <= 0 + arg_898_0 then
				arg_895_1.talkMaxDuration = 0
				arg_895_1.dialogCg_.alpha = 1

				arg_895_1.dialog_:SetActive(true)
				SetActive(arg_895_1.leftNameGo_, true)

				arg_895_1.leftNameTxt_.text = arg_895_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_895_1.leftNameTxt_.transform)

				arg_895_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_895_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_895_1:RecordName(arg_895_1.leftNameTxt_.text)
				SetActive(arg_895_1.iconTrs_.gameObject, true)
				arg_895_1.iconController_:SetSelectedState("hero")

				arg_895_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_895_1.callingController_:SetSelectedState("normal")

				arg_895_1.keyicon_.color = Color.New(1, 1, 1)
				arg_895_1.icon_.color = Color.New(1, 1, 1)

				local var_898_1 = arg_895_1:FormatText(arg_895_1:GetWordFromCfg(910201220).content)

				arg_895_1.text_.text = var_898_1

				LuaForUtil.ClearLinePrefixSymbol(arg_895_1.text_)

				local var_898_3 = 32 <= 0 and var_898_0 or var_898_0 * (utf8.len(var_898_1) / 32)

				if (32 <= 0 and var_898_0 or var_898_0 * (utf8.len(var_898_1) / 32)) > 0 and var_898_0 < var_898_3 then
					arg_895_1.talkMaxDuration = var_898_3

					if var_898_3 + 0 > arg_895_1.duration_ then
						arg_895_1.duration_ = var_898_3 + 0
					end
				end

				arg_895_1.text_.text = var_898_1
				arg_895_1.typewritter.percent = 0

				arg_895_1.typewritter:SetDirty()
				arg_895_1:ShowNextGo(false)
				arg_895_1:RecordContent(arg_895_1.text_.text)
			end

			local var_898_4 = math.max(var_898_0, arg_895_1.talkMaxDuration)

			if 0 <= arg_895_1.time_ and arg_895_1.time_ < 0 + var_898_4 then
				arg_895_1.typewritter.percent = (arg_895_1.time_ - 0) / var_898_4

				arg_895_1.typewritter:SetDirty()
			end

			if arg_895_1.time_ >= 0 + var_898_4 and arg_895_1.time_ < 0 + var_898_4 + arg_898_0 then
				arg_895_1.typewritter.percent = 1

				arg_895_1.typewritter:SetDirty()
				arg_895_1:ShowNextGo(true)
			end
		end

		arg_895_1.nodeConfigList_ = {}

		arg_895_1:InitPlayNodeList()
	end,
	Play910201221 = function(arg_899_0, arg_899_1)
		arg_899_1.time_ = 0
		arg_899_1.frameCnt_ = 0
		arg_899_1.state_ = "playing"
		arg_899_1.curTalkId_ = 910201221
		arg_899_1.duration_ = 5

		SetActive(arg_899_1.tipsGo_, false)

		function arg_899_1.onSingleLineFinish_()
			arg_899_1.onSingleLineUpdate_ = nil
			arg_899_1.onSingleLineFinish_ = nil
			arg_899_1.state_ = "waiting"
		end

		function arg_899_1.playNext_(arg_901_0)
			if arg_901_0 == 1 then
				arg_899_0:Play910201222(arg_899_1)
			end
		end

		function arg_899_1.onSingleLineUpdate_(arg_902_0)
			local var_902_0 = 0.425

			if 0 < arg_899_1.time_ and arg_899_1.time_ <= 0 + arg_902_0 then
				arg_899_1.talkMaxDuration = 0
				arg_899_1.dialogCg_.alpha = 1

				arg_899_1.dialog_:SetActive(true)
				SetActive(arg_899_1.leftNameGo_, true)

				arg_899_1.leftNameTxt_.text = arg_899_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_899_1.leftNameTxt_.transform)

				arg_899_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_899_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_899_1:RecordName(arg_899_1.leftNameTxt_.text)
				SetActive(arg_899_1.iconTrs_.gameObject, true)
				arg_899_1.iconController_:SetSelectedState("hero")

				arg_899_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_899_1.callingController_:SetSelectedState("normal")

				arg_899_1.keyicon_.color = Color.New(1, 1, 1)
				arg_899_1.icon_.color = Color.New(1, 1, 1)

				local var_902_1 = arg_899_1:FormatText(arg_899_1:GetWordFromCfg(910201221).content)

				arg_899_1.text_.text = var_902_1

				LuaForUtil.ClearLinePrefixSymbol(arg_899_1.text_)

				local var_902_3 = 17 <= 0 and var_902_0 or var_902_0 * (utf8.len(var_902_1) / 17)

				if (17 <= 0 and var_902_0 or var_902_0 * (utf8.len(var_902_1) / 17)) > 0 and var_902_0 < var_902_3 then
					arg_899_1.talkMaxDuration = var_902_3

					if var_902_3 + 0 > arg_899_1.duration_ then
						arg_899_1.duration_ = var_902_3 + 0
					end
				end

				arg_899_1.text_.text = var_902_1
				arg_899_1.typewritter.percent = 0

				arg_899_1.typewritter:SetDirty()
				arg_899_1:ShowNextGo(false)
				arg_899_1:RecordContent(arg_899_1.text_.text)
			end

			local var_902_4 = math.max(var_902_0, arg_899_1.talkMaxDuration)

			if 0 <= arg_899_1.time_ and arg_899_1.time_ < 0 + var_902_4 then
				arg_899_1.typewritter.percent = (arg_899_1.time_ - 0) / var_902_4

				arg_899_1.typewritter:SetDirty()
			end

			if arg_899_1.time_ >= 0 + var_902_4 and arg_899_1.time_ < 0 + var_902_4 + arg_902_0 then
				arg_899_1.typewritter.percent = 1

				arg_899_1.typewritter:SetDirty()
				arg_899_1:ShowNextGo(true)
			end
		end

		arg_899_1.nodeConfigList_ = {}

		arg_899_1:InitPlayNodeList()
	end,
	Play910201222 = function(arg_903_0, arg_903_1)
		arg_903_1.time_ = 0
		arg_903_1.frameCnt_ = 0
		arg_903_1.state_ = "playing"
		arg_903_1.curTalkId_ = 910201222
		arg_903_1.duration_ = 5

		SetActive(arg_903_1.tipsGo_, false)

		function arg_903_1.onSingleLineFinish_()
			arg_903_1.onSingleLineUpdate_ = nil
			arg_903_1.onSingleLineFinish_ = nil
			arg_903_1.state_ = "waiting"
		end

		function arg_903_1.playNext_(arg_905_0)
			if arg_905_0 == 1 then
				arg_903_0:Play910201223(arg_903_1)
			end
		end

		function arg_903_1.onSingleLineUpdate_(arg_906_0)
			if 0 < arg_903_1.time_ and arg_903_1.time_ <= 0 + arg_906_0 and not isNil(arg_903_1.actors_["1084ui_story"]) and arg_903_1.var_.characterEffect1084ui_story == nil then
				arg_903_1.var_.characterEffect1084ui_story = arg_903_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_906_0 = 0.2

			if 0 <= arg_903_1.time_ and arg_903_1.time_ < 0 + var_906_0 and not isNil(arg_903_1.actors_["1084ui_story"]) then
				if arg_903_1.var_.characterEffect1084ui_story and not isNil(arg_903_1.actors_["1084ui_story"]) then
					arg_903_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_903_1.time_ >= 0 + var_906_0 and arg_903_1.time_ < 0 + var_906_0 + arg_906_0 and not isNil(arg_903_1.actors_["1084ui_story"]) and arg_903_1.var_.characterEffect1084ui_story then
				arg_903_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_903_1.time_ and arg_903_1.time_ <= 0 + arg_906_0 then
				arg_903_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_903_1.time_ and arg_903_1.time_ <= 0 + arg_906_0 then
				arg_903_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_906_2 = 0
			local var_906_3 = 0.375

			if 0 < arg_903_1.time_ and arg_903_1.time_ <= var_906_2 + arg_906_0 then
				arg_903_1.talkMaxDuration = 0
				arg_903_1.dialogCg_.alpha = 1

				arg_903_1.dialog_:SetActive(true)
				SetActive(arg_903_1.leftNameGo_, true)

				arg_903_1.leftNameTxt_.text = arg_903_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_903_1.leftNameTxt_.transform)

				arg_903_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_903_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_903_1:RecordName(arg_903_1.leftNameTxt_.text)
				SetActive(arg_903_1.iconTrs_.gameObject, false)
				arg_903_1.callingController_:SetSelectedState("normal")

				local var_906_4 = arg_903_1:FormatText(arg_903_1:GetWordFromCfg(910201222).content)

				arg_903_1.text_.text = var_906_4

				LuaForUtil.ClearLinePrefixSymbol(arg_903_1.text_)

				local var_906_6 = 15 <= 0 and var_906_3 or var_906_3 * (utf8.len(var_906_4) / 15)

				if (15 <= 0 and var_906_3 or var_906_3 * (utf8.len(var_906_4) / 15)) > 0 and var_906_3 < var_906_6 then
					arg_903_1.talkMaxDuration = var_906_6

					if var_906_6 + var_906_2 > arg_903_1.duration_ then
						arg_903_1.duration_ = var_906_6 + var_906_2
					end
				end

				arg_903_1.text_.text = var_906_4
				arg_903_1.typewritter.percent = 0

				arg_903_1.typewritter:SetDirty()
				arg_903_1:ShowNextGo(false)
				arg_903_1:RecordContent(arg_903_1.text_.text)
			end

			local var_906_7 = math.max(var_906_3, arg_903_1.talkMaxDuration)

			if var_906_2 <= arg_903_1.time_ and arg_903_1.time_ < var_906_2 + var_906_7 then
				arg_903_1.typewritter.percent = (arg_903_1.time_ - var_906_2) / var_906_7

				arg_903_1.typewritter:SetDirty()
			end

			if arg_903_1.time_ >= var_906_2 + var_906_7 and arg_903_1.time_ < var_906_2 + var_906_7 + arg_906_0 then
				arg_903_1.typewritter.percent = 1

				arg_903_1.typewritter:SetDirty()
				arg_903_1:ShowNextGo(true)
			end
		end

		arg_903_1.nodeConfigList_ = {}

		arg_903_1:InitPlayNodeList()
	end,
	Play910201223 = function(arg_907_0, arg_907_1)
		arg_907_1.time_ = 0
		arg_907_1.frameCnt_ = 0
		arg_907_1.state_ = "playing"
		arg_907_1.curTalkId_ = 910201223
		arg_907_1.duration_ = 5

		SetActive(arg_907_1.tipsGo_, false)

		function arg_907_1.onSingleLineFinish_()
			arg_907_1.onSingleLineUpdate_ = nil
			arg_907_1.onSingleLineFinish_ = nil
			arg_907_1.state_ = "waiting"
		end

		function arg_907_1.playNext_(arg_909_0)
			if arg_909_0 == 1 then
				arg_907_0:Play910201224(arg_907_1)
			end
		end

		function arg_907_1.onSingleLineUpdate_(arg_910_0)
			if 0 < arg_907_1.time_ and arg_907_1.time_ <= 0 + arg_910_0 then
				arg_907_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_910_0 = arg_907_1.actors_["1084ui_story"].transform

			if 0 < arg_907_1.time_ and arg_907_1.time_ <= 0 + arg_910_0 then
				arg_907_1.var_.moveOldPos1084ui_story = var_910_0.localPosition
			end

			local var_910_1 = 0.001

			if 0 <= arg_907_1.time_ and arg_907_1.time_ < 0 + var_910_1 then
				var_910_0.localPosition = Vector3.Lerp(arg_907_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_907_1.time_ - 0) / var_910_1)
				var_910_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_910_0.position).x, (manager.ui.mainCamera.transform.position - var_910_0.position).y, (manager.ui.mainCamera.transform.position - var_910_0.position).z)
				var_910_0.localEulerAngles.z = 0
				var_910_0.localEulerAngles.x = 0
				var_910_0.localEulerAngles = var_910_0.localEulerAngles
			end

			if arg_907_1.time_ >= 0 + var_910_1 and arg_907_1.time_ < 0 + var_910_1 + arg_910_0 then
				var_910_0.localPosition = Vector3.New(0, 100, 0)
				var_910_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_910_0.position).x, (manager.ui.mainCamera.transform.position - var_910_0.position).y, (manager.ui.mainCamera.transform.position - var_910_0.position).z)
				var_910_0.localEulerAngles.z = 0
				var_910_0.localEulerAngles.x = 0
				var_910_0.localEulerAngles = var_910_0.localEulerAngles
			end

			local var_910_2 = 0
			local var_910_3 = 0.25

			if 0 < arg_907_1.time_ and arg_907_1.time_ <= var_910_2 + arg_910_0 then
				arg_907_1.talkMaxDuration = 0
				arg_907_1.dialogCg_.alpha = 1

				arg_907_1.dialog_:SetActive(true)
				SetActive(arg_907_1.leftNameGo_, true)

				arg_907_1.leftNameTxt_.text = arg_907_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_907_1.leftNameTxt_.transform)

				arg_907_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_907_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_907_1:RecordName(arg_907_1.leftNameTxt_.text)
				SetActive(arg_907_1.iconTrs_.gameObject, true)
				arg_907_1.iconController_:SetSelectedState("hero")

				arg_907_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_907_1.callingController_:SetSelectedState("normal")

				arg_907_1.keyicon_.color = Color.New(1, 1, 1)
				arg_907_1.icon_.color = Color.New(1, 1, 1)

				local var_910_4 = arg_907_1:FormatText(arg_907_1:GetWordFromCfg(910201223).content)

				arg_907_1.text_.text = var_910_4

				LuaForUtil.ClearLinePrefixSymbol(arg_907_1.text_)

				local var_910_6 = 10 <= 0 and var_910_3 or var_910_3 * (utf8.len(var_910_4) / 10)

				if (10 <= 0 and var_910_3 or var_910_3 * (utf8.len(var_910_4) / 10)) > 0 and var_910_3 < var_910_6 then
					arg_907_1.talkMaxDuration = var_910_6

					if var_910_6 + var_910_2 > arg_907_1.duration_ then
						arg_907_1.duration_ = var_910_6 + var_910_2
					end
				end

				arg_907_1.text_.text = var_910_4
				arg_907_1.typewritter.percent = 0

				arg_907_1.typewritter:SetDirty()
				arg_907_1:ShowNextGo(false)
				arg_907_1:RecordContent(arg_907_1.text_.text)
			end

			local var_910_7 = math.max(var_910_3, arg_907_1.talkMaxDuration)

			if var_910_2 <= arg_907_1.time_ and arg_907_1.time_ < var_910_2 + var_910_7 then
				arg_907_1.typewritter.percent = (arg_907_1.time_ - var_910_2) / var_910_7

				arg_907_1.typewritter:SetDirty()
			end

			if arg_907_1.time_ >= var_910_2 + var_910_7 and arg_907_1.time_ < var_910_2 + var_910_7 + arg_910_0 then
				arg_907_1.typewritter.percent = 1

				arg_907_1.typewritter:SetDirty()
				arg_907_1:ShowNextGo(true)
			end
		end

		arg_907_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_907_1:InitPlayNodeList()
	end,
	Play910201224 = function(arg_911_0, arg_911_1)
		arg_911_1.time_ = 0
		arg_911_1.frameCnt_ = 0
		arg_911_1.state_ = "playing"
		arg_911_1.curTalkId_ = 910201224
		arg_911_1.duration_ = 5

		SetActive(arg_911_1.tipsGo_, false)

		function arg_911_1.onSingleLineFinish_()
			arg_911_1.onSingleLineUpdate_ = nil
			arg_911_1.onSingleLineFinish_ = nil
			arg_911_1.state_ = "waiting"
		end

		function arg_911_1.playNext_(arg_913_0)
			if arg_913_0 == 1 then
				arg_911_0:Play910201225(arg_911_1)
			end
		end

		function arg_911_1.onSingleLineUpdate_(arg_914_0)
			if 0 < arg_911_1.time_ and arg_911_1.time_ <= 0 + arg_914_0 then
				arg_911_1.var_.moveOldPos1059ui_story = arg_911_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_914_0 = 0.001

			if 0 <= arg_911_1.time_ and arg_911_1.time_ < 0 + var_914_0 then
				arg_911_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_911_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_911_1.time_ - 0) / var_914_0)
				arg_911_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_911_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_911_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_911_1.actors_["1059ui_story"].transform.position).z)
				arg_911_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_911_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_911_1.actors_["1059ui_story"].transform.localEulerAngles = arg_911_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_911_1.time_ >= 0 + var_914_0 and arg_911_1.time_ < 0 + var_914_0 + arg_914_0 then
				arg_911_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_911_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_911_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_911_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_911_1.actors_["1059ui_story"].transform.position).z)
				arg_911_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_911_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_911_1.actors_["1059ui_story"].transform.localEulerAngles = arg_911_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if 0 < arg_911_1.time_ and arg_911_1.time_ <= 0 + arg_914_0 then
				arg_911_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_914_1 = arg_911_1.actors_["1059ui_story"]

			if 0 < arg_911_1.time_ and arg_911_1.time_ <= 0 + arg_914_0 and not isNil(var_914_1) and arg_911_1.var_.characterEffect1059ui_story == nil then
				arg_911_1.var_.characterEffect1059ui_story = var_914_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_914_2 = 0.2

			if 0 <= arg_911_1.time_ and arg_911_1.time_ < 0 + var_914_2 and not isNil(var_914_1) then
				if arg_911_1.var_.characterEffect1059ui_story and not isNil(var_914_1) then
					arg_911_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_911_1.time_ >= 0 + var_914_2 and arg_911_1.time_ < 0 + var_914_2 + arg_914_0 and not isNil(var_914_1) and arg_911_1.var_.characterEffect1059ui_story then
				arg_911_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_914_4 = 0
			local var_914_5 = 0.325

			if 0 < arg_911_1.time_ and arg_911_1.time_ <= var_914_4 + arg_914_0 then
				arg_911_1.talkMaxDuration = 0
				arg_911_1.dialogCg_.alpha = 1

				arg_911_1.dialog_:SetActive(true)
				SetActive(arg_911_1.leftNameGo_, true)

				arg_911_1.leftNameTxt_.text = arg_911_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_911_1.leftNameTxt_.transform)

				arg_911_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_911_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_911_1:RecordName(arg_911_1.leftNameTxt_.text)
				SetActive(arg_911_1.iconTrs_.gameObject, false)
				arg_911_1.callingController_:SetSelectedState("normal")

				local var_914_6 = arg_911_1:FormatText(arg_911_1:GetWordFromCfg(910201224).content)

				arg_911_1.text_.text = var_914_6

				LuaForUtil.ClearLinePrefixSymbol(arg_911_1.text_)

				local var_914_8 = 13 <= 0 and var_914_5 or var_914_5 * (utf8.len(var_914_6) / 13)

				if (13 <= 0 and var_914_5 or var_914_5 * (utf8.len(var_914_6) / 13)) > 0 and var_914_5 < var_914_8 then
					arg_911_1.talkMaxDuration = var_914_8

					if var_914_8 + var_914_4 > arg_911_1.duration_ then
						arg_911_1.duration_ = var_914_8 + var_914_4
					end
				end

				arg_911_1.text_.text = var_914_6
				arg_911_1.typewritter.percent = 0

				arg_911_1.typewritter:SetDirty()
				arg_911_1:ShowNextGo(false)
				arg_911_1:RecordContent(arg_911_1.text_.text)
			end

			local var_914_9 = math.max(var_914_5, arg_911_1.talkMaxDuration)

			if var_914_4 <= arg_911_1.time_ and arg_911_1.time_ < var_914_4 + var_914_9 then
				arg_911_1.typewritter.percent = (arg_911_1.time_ - var_914_4) / var_914_9

				arg_911_1.typewritter:SetDirty()
			end

			if arg_911_1.time_ >= var_914_4 + var_914_9 and arg_911_1.time_ < var_914_4 + var_914_9 + arg_914_0 then
				arg_911_1.typewritter.percent = 1

				arg_911_1.typewritter:SetDirty()
				arg_911_1:ShowNextGo(true)
			end
		end

		arg_911_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_911_1:InitPlayNodeList()
	end,
	Play910201225 = function(arg_915_0, arg_915_1)
		arg_915_1.time_ = 0
		arg_915_1.frameCnt_ = 0
		arg_915_1.state_ = "playing"
		arg_915_1.curTalkId_ = 910201225
		arg_915_1.duration_ = 5

		SetActive(arg_915_1.tipsGo_, false)

		function arg_915_1.onSingleLineFinish_()
			arg_915_1.onSingleLineUpdate_ = nil
			arg_915_1.onSingleLineFinish_ = nil
			arg_915_1.state_ = "waiting"
		end

		function arg_915_1.playNext_(arg_917_0)
			if arg_917_0 == 1 then
				arg_915_0:Play910201226(arg_915_1)
			end
		end

		function arg_915_1.onSingleLineUpdate_(arg_918_0)
			if 0 < arg_915_1.time_ and arg_915_1.time_ <= 0 + arg_918_0 then
				arg_915_1.var_.moveOldPos1084ui_story = arg_915_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_918_0 = 0.001

			if 0 <= arg_915_1.time_ and arg_915_1.time_ < 0 + var_918_0 then
				arg_915_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_915_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_915_1.time_ - 0) / var_918_0)
				arg_915_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_915_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_915_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_915_1.actors_["1084ui_story"].transform.position).z)
				arg_915_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_915_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_915_1.actors_["1084ui_story"].transform.localEulerAngles = arg_915_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_915_1.time_ >= 0 + var_918_0 and arg_915_1.time_ < 0 + var_918_0 + arg_918_0 then
				arg_915_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_915_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_915_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_915_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_915_1.actors_["1084ui_story"].transform.position).z)
				arg_915_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_915_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_915_1.actors_["1084ui_story"].transform.localEulerAngles = arg_915_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_918_1 = arg_915_1.actors_["1059ui_story"].transform

			if 0 < arg_915_1.time_ and arg_915_1.time_ <= 0 + arg_918_0 then
				arg_915_1.var_.moveOldPos1059ui_story = var_918_1.localPosition
			end

			local var_918_2 = 0.001

			if 0 <= arg_915_1.time_ and arg_915_1.time_ < 0 + var_918_2 then
				var_918_1.localPosition = Vector3.Lerp(arg_915_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_915_1.time_ - 0) / var_918_2)
				var_918_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_918_1.position).x, (manager.ui.mainCamera.transform.position - var_918_1.position).y, (manager.ui.mainCamera.transform.position - var_918_1.position).z)
				var_918_1.localEulerAngles.z = 0
				var_918_1.localEulerAngles.x = 0
				var_918_1.localEulerAngles = var_918_1.localEulerAngles
			end

			if arg_915_1.time_ >= 0 + var_918_2 and arg_915_1.time_ < 0 + var_918_2 + arg_918_0 then
				var_918_1.localPosition = Vector3.New(0, 100, 0)
				var_918_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_918_1.position).x, (manager.ui.mainCamera.transform.position - var_918_1.position).y, (manager.ui.mainCamera.transform.position - var_918_1.position).z)
				var_918_1.localEulerAngles.z = 0
				var_918_1.localEulerAngles.x = 0
				var_918_1.localEulerAngles = var_918_1.localEulerAngles
			end

			if 0 < arg_915_1.time_ and arg_915_1.time_ <= 0 + arg_918_0 then
				arg_915_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_918_3 = arg_915_1.actors_["1084ui_story"]

			if 0 < arg_915_1.time_ and arg_915_1.time_ <= 0 + arg_918_0 and not isNil(var_918_3) and arg_915_1.var_.characterEffect1084ui_story == nil then
				arg_915_1.var_.characterEffect1084ui_story = var_918_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_918_4 = 0.2

			if 0 <= arg_915_1.time_ and arg_915_1.time_ < 0 + var_918_4 and not isNil(var_918_3) then
				if arg_915_1.var_.characterEffect1084ui_story and not isNil(var_918_3) then
					arg_915_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_915_1.time_ >= 0 + var_918_4 and arg_915_1.time_ < 0 + var_918_4 + arg_918_0 and not isNil(var_918_3) and arg_915_1.var_.characterEffect1084ui_story then
				arg_915_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_915_1.time_ and arg_915_1.time_ <= 0 + arg_918_0 then
				arg_915_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_918_6 = 0
			local var_918_7 = 0.725

			if 0 < arg_915_1.time_ and arg_915_1.time_ <= var_918_6 + arg_918_0 then
				arg_915_1.talkMaxDuration = 0
				arg_915_1.dialogCg_.alpha = 1

				arg_915_1.dialog_:SetActive(true)
				SetActive(arg_915_1.leftNameGo_, true)

				arg_915_1.leftNameTxt_.text = arg_915_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_915_1.leftNameTxt_.transform)

				arg_915_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_915_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_915_1:RecordName(arg_915_1.leftNameTxt_.text)
				SetActive(arg_915_1.iconTrs_.gameObject, false)
				arg_915_1.callingController_:SetSelectedState("normal")

				local var_918_8 = arg_915_1:FormatText(arg_915_1:GetWordFromCfg(910201225).content)

				arg_915_1.text_.text = var_918_8

				LuaForUtil.ClearLinePrefixSymbol(arg_915_1.text_)

				local var_918_10 = 29 <= 0 and var_918_7 or var_918_7 * (utf8.len(var_918_8) / 29)

				if (29 <= 0 and var_918_7 or var_918_7 * (utf8.len(var_918_8) / 29)) > 0 and var_918_7 < var_918_10 then
					arg_915_1.talkMaxDuration = var_918_10

					if var_918_10 + var_918_6 > arg_915_1.duration_ then
						arg_915_1.duration_ = var_918_10 + var_918_6
					end
				end

				arg_915_1.text_.text = var_918_8
				arg_915_1.typewritter.percent = 0

				arg_915_1.typewritter:SetDirty()
				arg_915_1:ShowNextGo(false)
				arg_915_1:RecordContent(arg_915_1.text_.text)
			end

			local var_918_11 = math.max(var_918_7, arg_915_1.talkMaxDuration)

			if var_918_6 <= arg_915_1.time_ and arg_915_1.time_ < var_918_6 + var_918_11 then
				arg_915_1.typewritter.percent = (arg_915_1.time_ - var_918_6) / var_918_11

				arg_915_1.typewritter:SetDirty()
			end

			if arg_915_1.time_ >= var_918_6 + var_918_11 and arg_915_1.time_ < var_918_6 + var_918_11 + arg_918_0 then
				arg_915_1.typewritter.percent = 1

				arg_915_1.typewritter:SetDirty()
				arg_915_1:ShowNextGo(true)
			end
		end

		arg_915_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_915_1:InitPlayNodeList()
	end,
	Play910201226 = function(arg_919_0, arg_919_1)
		arg_919_1.time_ = 0
		arg_919_1.frameCnt_ = 0
		arg_919_1.state_ = "playing"
		arg_919_1.curTalkId_ = 910201226
		arg_919_1.duration_ = 5

		SetActive(arg_919_1.tipsGo_, false)

		function arg_919_1.onSingleLineFinish_()
			arg_919_1.onSingleLineUpdate_ = nil
			arg_919_1.onSingleLineFinish_ = nil
			arg_919_1.state_ = "waiting"
		end

		function arg_919_1.playNext_(arg_921_0)
			if arg_921_0 == 1 then
				arg_919_0:Play910201227(arg_919_1)
			end
		end

		function arg_919_1.onSingleLineUpdate_(arg_922_0)
			if 0 < arg_919_1.time_ and arg_919_1.time_ <= 0 + arg_922_0 then
				arg_919_1.var_.moveOldPos1084ui_story = arg_919_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_922_0 = 0.001

			if 0 <= arg_919_1.time_ and arg_919_1.time_ < 0 + var_922_0 then
				arg_919_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_919_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_919_1.time_ - 0) / var_922_0)
				arg_919_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_919_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_919_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_919_1.actors_["1084ui_story"].transform.position).z)
				arg_919_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_919_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_919_1.actors_["1084ui_story"].transform.localEulerAngles = arg_919_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_919_1.time_ >= 0 + var_922_0 and arg_919_1.time_ < 0 + var_922_0 + arg_922_0 then
				arg_919_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_919_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_919_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_919_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_919_1.actors_["1084ui_story"].transform.position).z)
				arg_919_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_919_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_919_1.actors_["1084ui_story"].transform.localEulerAngles = arg_919_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_922_1 = 0
			local var_922_2 = 0.35

			if 0 < arg_919_1.time_ and arg_919_1.time_ <= var_922_1 + arg_922_0 then
				arg_919_1.talkMaxDuration = 0
				arg_919_1.dialogCg_.alpha = 1

				arg_919_1.dialog_:SetActive(true)
				SetActive(arg_919_1.leftNameGo_, true)

				arg_919_1.leftNameTxt_.text = arg_919_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_919_1.leftNameTxt_.transform)

				arg_919_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_919_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_919_1:RecordName(arg_919_1.leftNameTxt_.text)
				SetActive(arg_919_1.iconTrs_.gameObject, false)
				arg_919_1.callingController_:SetSelectedState("normal")

				local var_922_3 = arg_919_1:FormatText(arg_919_1:GetWordFromCfg(910201226).content)

				arg_919_1.text_.text = var_922_3

				LuaForUtil.ClearLinePrefixSymbol(arg_919_1.text_)

				local var_922_5 = 14 <= 0 and var_922_2 or var_922_2 * (utf8.len(var_922_3) / 14)

				if (14 <= 0 and var_922_2 or var_922_2 * (utf8.len(var_922_3) / 14)) > 0 and var_922_2 < var_922_5 then
					arg_919_1.talkMaxDuration = var_922_5

					if var_922_5 + var_922_1 > arg_919_1.duration_ then
						arg_919_1.duration_ = var_922_5 + var_922_1
					end
				end

				arg_919_1.text_.text = var_922_3
				arg_919_1.typewritter.percent = 0

				arg_919_1.typewritter:SetDirty()
				arg_919_1:ShowNextGo(false)
				arg_919_1:RecordContent(arg_919_1.text_.text)
			end

			local var_922_6 = math.max(var_922_2, arg_919_1.talkMaxDuration)

			if var_922_1 <= arg_919_1.time_ and arg_919_1.time_ < var_922_1 + var_922_6 then
				arg_919_1.typewritter.percent = (arg_919_1.time_ - var_922_1) / var_922_6

				arg_919_1.typewritter:SetDirty()
			end

			if arg_919_1.time_ >= var_922_1 + var_922_6 and arg_919_1.time_ < var_922_1 + var_922_6 + arg_922_0 then
				arg_919_1.typewritter.percent = 1

				arg_919_1.typewritter:SetDirty()
				arg_919_1:ShowNextGo(true)
			end
		end

		arg_919_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_919_1:InitPlayNodeList()
	end,
	Play910201227 = function(arg_923_0, arg_923_1)
		arg_923_1.time_ = 0
		arg_923_1.frameCnt_ = 0
		arg_923_1.state_ = "playing"
		arg_923_1.curTalkId_ = 910201227
		arg_923_1.duration_ = 5

		SetActive(arg_923_1.tipsGo_, false)

		function arg_923_1.onSingleLineFinish_()
			arg_923_1.onSingleLineUpdate_ = nil
			arg_923_1.onSingleLineFinish_ = nil
			arg_923_1.state_ = "waiting"
			arg_923_1.auto_ = false
		end

		function arg_923_1.playNext_(arg_925_0)
			arg_923_1.onStoryFinished_()
		end

		function arg_923_1.onSingleLineUpdate_(arg_926_0)
			local var_926_0 = 0.25

			if 0 < arg_923_1.time_ and arg_923_1.time_ <= 0 + arg_926_0 then
				arg_923_1.talkMaxDuration = 0
				arg_923_1.dialogCg_.alpha = 1

				arg_923_1.dialog_:SetActive(true)
				SetActive(arg_923_1.leftNameGo_, false)

				arg_923_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_923_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_923_1:RecordName(arg_923_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_923_1.iconTrs_.gameObject, false)
				arg_923_1.callingController_:SetSelectedState("normal")

				local var_926_1 = arg_923_1:FormatText(arg_923_1:GetWordFromCfg(910201227).content)

				arg_923_1.text_.text = var_926_1

				LuaForUtil.ClearLinePrefixSymbol(arg_923_1.text_)

				local var_926_3 = 10 <= 0 and var_926_0 or var_926_0 * (utf8.len(var_926_1) / 10)

				if (10 <= 0 and var_926_0 or var_926_0 * (utf8.len(var_926_1) / 10)) > 0 and var_926_0 < var_926_3 then
					arg_923_1.talkMaxDuration = var_926_3

					if var_926_3 + 0 > arg_923_1.duration_ then
						arg_923_1.duration_ = var_926_3 + 0
					end
				end

				arg_923_1.text_.text = var_926_1
				arg_923_1.typewritter.percent = 0

				arg_923_1.typewritter:SetDirty()
				arg_923_1:ShowNextGo(false)
				arg_923_1:RecordContent(arg_923_1.text_.text)
			end

			local var_926_4 = math.max(var_926_0, arg_923_1.talkMaxDuration)

			if 0 <= arg_923_1.time_ and arg_923_1.time_ < 0 + var_926_4 then
				arg_923_1.typewritter.percent = (arg_923_1.time_ - 0) / var_926_4

				arg_923_1.typewritter:SetDirty()
			end

			if arg_923_1.time_ >= 0 + var_926_4 and arg_923_1.time_ < 0 + var_926_4 + arg_926_0 then
				arg_923_1.typewritter.percent = 1

				arg_923_1.typewritter:SetDirty()
				arg_923_1:ShowNextGo(true)
			end
		end

		arg_923_1.nodeConfigList_ = {}

		arg_923_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST05",
		"TextureConfig/Background/HB0101"
	},
	voices = {}
}
