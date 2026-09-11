return {
	Play325611001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325611001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325611002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J26h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J26h")
				var_4_0.name = "J26h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J26h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J26h

				arg_1_1.bgs_.J26h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J26h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_battleground_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 1.999999999999
			local var_4_14 = 0.5

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325611001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 20 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 20)

				if (20 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 20)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325611002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325611002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325611003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325611002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 40 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 40)

				if (40 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 40)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325611003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325611003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325611004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325611003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 53 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 53)

				if (53 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 53)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325611004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325611004
		arg_16_1.duration_ = 6.3

		local var_16_0 = {
			zh = 5.266,
			ja = 6.3
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325611005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "6148ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["6148ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["6148ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["6148ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["6148ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -0.985, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["6148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_19_10 = 0
			local var_19_11 = 0.525

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(325611004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 21 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 21)

				if (21 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 21)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611004", "story_v_out_325611.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_325611", "325611004", "story_v_out_325611.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_325611", "325611004", "story_v_out_325611.awb")

						arg_16_1:RecordAudio("325611004", var_19_17)
						arg_16_1:RecordAudio("325611004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325611", "325611004", "story_v_out_325611.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325611", "325611004", "story_v_out_325611.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325611005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325611005
		arg_20_1.duration_ = 4.4

		local var_20_0 = {
			zh = 3.3,
			ja = 4.4
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325611006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:GetWordFromCfg(325611005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 17)

				if (17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 17)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611005", "story_v_out_325611.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_325611", "325611005", "story_v_out_325611.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_325611", "325611005", "story_v_out_325611.awb")

						arg_20_1:RecordAudio("325611005", var_23_6)
						arg_20_1:RecordAudio("325611005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325611", "325611005", "story_v_out_325611.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325611", "325611005", "story_v_out_325611.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325611006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325611006
		arg_24_1.duration_ = 2.93

		local var_24_0 = {
			zh = 2.366,
			ja = 2.933
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325611007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos6148ui_story = arg_24_1.actors_["6148ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).z)
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles = arg_24_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_24_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).z)
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles = arg_24_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = "10175ui_story"

			if arg_24_1.actors_["10175ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10175ui_story"))) then
				local var_27_4 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_24_1.stage_.transform)

				var_27_4.name = var_27_3
				var_27_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_[var_27_3] = var_27_4

				local var_27_5 = var_27_4:GetComponentInChildren(typeof(CharacterEffect))

				var_27_5.enabled = true

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_4, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_5.transform, false)

				arg_24_1.var_[var_27_3 .. "Animator"] = var_27_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_[var_27_3 .. "Animator"].applyRootMotion = true
				arg_24_1.var_[var_27_3 .. "LipSync"] = var_27_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_7 = arg_24_1.actors_["10175ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10175ui_story = var_27_7.localPosition

				local var_27_8 = GameObjectTools.GetOrAddComponent(var_27_7.gameObject, typeof(DynamicBoneHelper))

				if var_27_8 then
					var_27_8:EnableDynamicBone(false)
				end
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_7.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_24_1.time_ - 0) / var_27_9)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_7.localPosition = Vector3.New(0.7, -1, -6.05)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_7.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["10175ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect10175ui_story == nil then
				arg_24_1.var_.characterEffect10175ui_story = var_27_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_12 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_12 and not isNil(var_27_11) then
				if arg_24_1.var_.characterEffect10175ui_story and not isNil(var_27_11) then
					arg_24_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_12 and arg_24_1.time_ < 0 + var_27_12 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect10175ui_story then
				arg_24_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_27_14 = arg_24_1.actors_["6148ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect6148ui_story == nil then
				arg_24_1.var_.characterEffect6148ui_story = var_27_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_15 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_15 and not isNil(var_27_14) then
				if arg_24_1.var_.characterEffect6148ui_story and not isNil(var_27_14) then
					arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_24_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_15)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_15 and arg_24_1.time_ < 0 + var_27_15 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect6148ui_story then
				arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_24_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_27_16 = 0
			local var_27_17 = 0.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_18 = arg_24_1:GetWordFromCfg(325611006)
				local var_27_19 = arg_24_1:FormatText(var_27_18.content)

				arg_24_1.text_.text = var_27_19

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_21 = 13 <= 0 and var_27_17 or var_27_17 * (utf8.len(var_27_19) / 13)

				if (13 <= 0 and var_27_17 or var_27_17 * (utf8.len(var_27_19) / 13)) > 0 and var_27_17 < var_27_21 then
					arg_24_1.talkMaxDuration = var_27_21

					if var_27_21 + var_27_16 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_21 + var_27_16
					end
				end

				arg_24_1.text_.text = var_27_19
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611006", "story_v_out_325611.awb") ~= 0 then
					local var_27_22 = manager.audio:GetVoiceLength("story_v_out_325611", "325611006", "story_v_out_325611.awb") / 1000

					if var_27_22 + var_27_16 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_16
					end

					if var_27_18.prefab_name ~= "" and arg_24_1.actors_[var_27_18.prefab_name] ~= nil then
						local var_27_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_18.prefab_name].transform, "story_v_out_325611", "325611006", "story_v_out_325611.awb")

						arg_24_1:RecordAudio("325611006", var_27_23)
						arg_24_1:RecordAudio("325611006", var_27_23)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325611", "325611006", "story_v_out_325611.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325611", "325611006", "story_v_out_325611.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_24 = math.max(var_27_17, arg_24_1.talkMaxDuration)

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_24 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_16) / var_27_24

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_16 + var_27_24 and arg_24_1.time_ < var_27_16 + var_27_24 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play325611007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325611007
		arg_28_1.duration_ = 2.83

		local var_28_0 = {
			zh = 2.833,
			ja = 2.2
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325611008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = arg_28_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) then
				if arg_28_1.var_.characterEffect6148ui_story and not isNil(arg_28_1.actors_["6148ui_story"]) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["10175ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect10175ui_story == nil then
				arg_28_1.var_.characterEffect10175ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect10175ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect10175ui_story then
				arg_28_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_31_4 = 0
			local var_31_5 = 0.3

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(325611007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 12 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 12)

				if (12 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 12)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611007", "story_v_out_325611.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611007", "story_v_out_325611.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_325611", "325611007", "story_v_out_325611.awb")

						arg_28_1:RecordAudio("325611007", var_31_11)
						arg_28_1:RecordAudio("325611007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325611", "325611007", "story_v_out_325611.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325611", "325611007", "story_v_out_325611.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325611008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325611008
		arg_32_1.duration_ = 4.7

		local var_32_0 = {
			zh = 3.033,
			ja = 4.7
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325611009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10175ui_story"]) and arg_32_1.var_.characterEffect10175ui_story == nil then
				arg_32_1.var_.characterEffect10175ui_story = arg_32_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10175ui_story"]) then
				if arg_32_1.var_.characterEffect10175ui_story and not isNil(arg_32_1.actors_["10175ui_story"]) then
					arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10175ui_story"]) and arg_32_1.var_.characterEffect10175ui_story then
				arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["6148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect6148ui_story then
				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_35_4 = 0
			local var_35_5 = 0.425

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(325611008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 17 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 17)

				if (17 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 17)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611008", "story_v_out_325611.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611008", "story_v_out_325611.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_325611", "325611008", "story_v_out_325611.awb")

						arg_32_1:RecordAudio("325611008", var_35_11)
						arg_32_1:RecordAudio("325611008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325611", "325611008", "story_v_out_325611.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325611", "325611008", "story_v_out_325611.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325611009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325611009
		arg_36_1.duration_ = 4.93

		local var_36_0 = {
			zh = 3.3,
			ja = 4.933
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325611010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_39_0 = 0
			local var_39_1 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(325611009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 17 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 17)

				if (17 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 17)) > 0 and var_39_1 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611009", "story_v_out_325611.awb") ~= 0 then
					local var_39_6 = manager.audio:GetVoiceLength("story_v_out_325611", "325611009", "story_v_out_325611.awb") / 1000

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end

					if var_39_2.prefab_name ~= "" and arg_36_1.actors_[var_39_2.prefab_name] ~= nil then
						local var_39_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_2.prefab_name].transform, "story_v_out_325611", "325611009", "story_v_out_325611.awb")

						arg_36_1:RecordAudio("325611009", var_39_7)
						arg_36_1:RecordAudio("325611009", var_39_7)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325611", "325611009", "story_v_out_325611.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325611", "325611009", "story_v_out_325611.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325611010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325611010
		arg_40_1.duration_ = 4.73

		local var_40_0 = {
			zh = 4,
			ja = 4.733
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325611011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10175ui_story = arg_40_1.actors_["10175ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10175ui_story"].transform.position).z)
				arg_40_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10175ui_story"].transform.localEulerAngles = arg_40_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10175ui_story"].transform.position).z)
				arg_40_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10175ui_story"].transform.localEulerAngles = arg_40_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = "1054ui_story"

			if arg_40_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_43_4 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_40_1.stage_.transform)

				var_43_4.name = var_43_3
				var_43_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_[var_43_3] = var_43_4

				local var_43_5 = var_43_4:GetComponentInChildren(typeof(CharacterEffect))

				var_43_5.enabled = true

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_4, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_5.transform, false)

				arg_40_1.var_[var_43_3 .. "Animator"] = var_43_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_[var_43_3 .. "Animator"].applyRootMotion = true
				arg_40_1.var_[var_43_3 .. "LipSync"] = var_43_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_7 = arg_40_1.actors_["1054ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = var_43_7.localPosition

				local var_43_8 = GameObjectTools.GetOrAddComponent(var_43_7.gameObject, typeof(DynamicBoneHelper))

				if var_43_8 then
					var_43_8:EnableDynamicBone(false)
				end
			end

			local var_43_9 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_9 then
				var_43_7.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_40_1.time_ - 0) / var_43_9)
				var_43_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_7.position).x, (manager.ui.mainCamera.transform.position - var_43_7.position).y, (manager.ui.mainCamera.transform.position - var_43_7.position).z)
				var_43_7.localEulerAngles.z = 0
				var_43_7.localEulerAngles.x = 0
				var_43_7.localEulerAngles = var_43_7.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_9 and arg_40_1.time_ < 0 + var_43_9 + arg_43_0 then
				var_43_7.localPosition = Vector3.New(0, -0.985, -6)
				var_43_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_7.position).x, (manager.ui.mainCamera.transform.position - var_43_7.position).y, (manager.ui.mainCamera.transform.position - var_43_7.position).z)
				var_43_7.localEulerAngles.z = 0
				var_43_7.localEulerAngles.x = 0
				var_43_7.localEulerAngles = var_43_7.localEulerAngles

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_7.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["6148ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = var_43_11.localPosition

				local var_43_12 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_12 then
					var_43_12:EnableDynamicBone(false)
				end
			end

			local var_43_13 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_13 then
				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_13)
				var_43_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_11.position).x, (manager.ui.mainCamera.transform.position - var_43_11.position).y, (manager.ui.mainCamera.transform.position - var_43_11.position).z)
				var_43_11.localEulerAngles.z = 0
				var_43_11.localEulerAngles.x = 0
				var_43_11.localEulerAngles = var_43_11.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_13 and arg_40_1.time_ < 0 + var_43_13 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0, 100, 0)
				var_43_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_11.position).x, (manager.ui.mainCamera.transform.position - var_43_11.position).y, (manager.ui.mainCamera.transform.position - var_43_11.position).z)
				var_43_11.localEulerAngles.z = 0
				var_43_11.localEulerAngles.x = 0
				var_43_11.localEulerAngles = var_43_11.localEulerAngles

				local var_43_14 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_14 then
					var_43_14:EnableDynamicBone(true)
				end
			end

			local var_43_15 = arg_40_1.actors_["1054ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_15) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_16 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_16 and not isNil(var_43_15) then
				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_15) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_16 and arg_40_1.time_ < 0 + var_43_16 + arg_43_0 and not isNil(var_43_15) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_43_18 = arg_40_1.actors_["10175ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_18) and arg_40_1.var_.characterEffect10175ui_story == nil then
				arg_40_1.var_.characterEffect10175ui_story = var_43_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_19 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_19 and not isNil(var_43_18) then
				if arg_40_1.var_.characterEffect10175ui_story and not isNil(var_43_18) then
					arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_19)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_19 and arg_40_1.time_ < 0 + var_43_19 + arg_43_0 and not isNil(var_43_18) and arg_40_1.var_.characterEffect10175ui_story then
				arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_43_20 = 0
			local var_43_21 = 0.375

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_22 = arg_40_1:GetWordFromCfg(325611010)
				local var_43_23 = arg_40_1:FormatText(var_43_22.content)

				arg_40_1.text_.text = var_43_23

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_25 = 15 <= 0 and var_43_21 or var_43_21 * (utf8.len(var_43_23) / 15)

				if (15 <= 0 and var_43_21 or var_43_21 * (utf8.len(var_43_23) / 15)) > 0 and var_43_21 < var_43_25 then
					arg_40_1.talkMaxDuration = var_43_25

					if var_43_25 + var_43_20 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_25 + var_43_20
					end
				end

				arg_40_1.text_.text = var_43_23
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611010", "story_v_out_325611.awb") ~= 0 then
					local var_43_26 = manager.audio:GetVoiceLength("story_v_out_325611", "325611010", "story_v_out_325611.awb") / 1000

					if var_43_26 + var_43_20 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_26 + var_43_20
					end

					if var_43_22.prefab_name ~= "" and arg_40_1.actors_[var_43_22.prefab_name] ~= nil then
						local var_43_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_22.prefab_name].transform, "story_v_out_325611", "325611010", "story_v_out_325611.awb")

						arg_40_1:RecordAudio("325611010", var_43_27)
						arg_40_1:RecordAudio("325611010", var_43_27)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325611", "325611010", "story_v_out_325611.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325611", "325611010", "story_v_out_325611.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_28 = math.max(var_43_21, arg_40_1.talkMaxDuration)

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_28 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_20) / var_43_28

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_20 + var_43_28 and arg_40_1.time_ < var_43_20 + var_43_28 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play325611011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325611011
		arg_44_1.duration_ = 9.2

		local var_44_0 = {
			zh = 6.733,
			ja = 9.2
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325611012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = arg_44_1.actors_["1054ui_story"].transform.localPosition

				local var_47_0 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_0 then
					var_47_0:EnableDynamicBone(false)
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_44_1.time_ - 0) / var_47_1)
				arg_44_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).z)
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles = arg_44_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_44_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1054ui_story"].transform.position).z)
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1054ui_story"].transform.localEulerAngles = arg_44_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(true)
				end
			end

			local var_47_3 = arg_44_1.actors_["10175ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10175ui_story = var_47_3.localPosition

				local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_4 then
					var_47_4:EnableDynamicBone(false)
				end
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_44_1.time_ - 0) / var_47_5)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles

				local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_6 then
					var_47_6:EnableDynamicBone(true)
				end
			end

			local var_47_7 = arg_44_1.actors_["10175ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.characterEffect10175ui_story == nil then
				arg_44_1.var_.characterEffect10175ui_story = var_47_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_8 and not isNil(var_47_7) then
				if arg_44_1.var_.characterEffect10175ui_story and not isNil(var_47_7) then
					arg_44_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_8 and arg_44_1.time_ < 0 + var_47_8 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.characterEffect10175ui_story then
				arg_44_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_47_10 = arg_44_1.actors_["1054ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_11 and not isNil(var_47_10) then
				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_10) then
					arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_11)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_11 and arg_44_1.time_ < 0 + var_47_11 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect1054ui_story then
				arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_47_12 = 0
			local var_47_13 = 0.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(325611011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 23 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 23)

				if (23 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 23)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611011", "story_v_out_325611.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611011", "story_v_out_325611.awb") / 1000

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_325611", "325611011", "story_v_out_325611.awb")

						arg_44_1:RecordAudio("325611011", var_47_19)
						arg_44_1:RecordAudio("325611011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325611", "325611011", "story_v_out_325611.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325611", "325611011", "story_v_out_325611.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_20 and arg_44_1.time_ < var_47_12 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325611012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325611012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325611013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10175ui_story = arg_48_1.actors_["10175ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10175ui_story"].transform.position).z)
				arg_48_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10175ui_story"].transform.localEulerAngles = arg_48_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10175ui_story"].transform.position).z)
				arg_48_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10175ui_story"].transform.localEulerAngles = arg_48_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["1054ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1054ui_story = var_51_3.localPosition

				local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_3.gameObject, typeof(DynamicBoneHelper))

				if var_51_4 then
					var_51_4:EnableDynamicBone(false)
				end
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_3.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_5)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_3.localPosition = Vector3.New(0, 100, 0)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles

				local var_51_6 = GameObjectTools.GetOrAddComponent(var_51_3.gameObject, typeof(DynamicBoneHelper))

				if var_51_6 then
					var_51_6:EnableDynamicBone(true)
				end
			end

			local var_51_7 = arg_48_1.actors_["10175ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect10175ui_story == nil then
				arg_48_1.var_.characterEffect10175ui_story = var_51_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_8 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_8 and not isNil(var_51_7) then
				if arg_48_1.var_.characterEffect10175ui_story and not isNil(var_51_7) then
					arg_48_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_8)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_8 and arg_48_1.time_ < 0 + var_51_8 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect10175ui_story then
				arg_48_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_51_9 = 0
			local var_51_10 = 0.95

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_11 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(325611012).content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 38 <= 0 and var_51_10 or var_51_10 * (utf8.len(var_51_11) / 38)

				if (38 <= 0 and var_51_10 or var_51_10 * (utf8.len(var_51_11) / 38)) > 0 and var_51_10 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_9 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_9
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_10, arg_48_1.talkMaxDuration)

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_9) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_9 + var_51_14 and arg_48_1.time_ < var_51_9 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325611013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325611013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325611014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(325611013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 40 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 40)

				if (40 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 40)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325611014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325611014
		arg_56_1.duration_ = 4.47

		local var_56_0 = {
			zh = 4.4,
			ja = 4.466
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325611015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10175ui_story = arg_56_1.actors_["10175ui_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10175ui_story"].transform.position).z)
				arg_56_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10175ui_story"].transform.localEulerAngles = arg_56_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_56_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10175ui_story"].transform.position).z)
				arg_56_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10175ui_story"].transform.localEulerAngles = arg_56_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["10175ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect10175ui_story == nil then
				arg_56_1.var_.characterEffect10175ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect10175ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect10175ui_story then
				arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_2")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0
			local var_59_7 = 0.375

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(325611014)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 15 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 15)

				if (15 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 15)) > 0 and var_59_7 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611014", "story_v_out_325611.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_325611", "325611014", "story_v_out_325611.awb") / 1000

					if var_59_12 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_6
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_325611", "325611014", "story_v_out_325611.awb")

						arg_56_1:RecordAudio("325611014", var_59_13)
						arg_56_1:RecordAudio("325611014", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325611", "325611014", "story_v_out_325611.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325611", "325611014", "story_v_out_325611.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play325611015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325611015
		arg_60_1.duration_ = 4.1

		local var_60_0 = {
			zh = 3.733,
			ja = 4.1
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325611016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10175ui_story = arg_60_1.actors_["10175ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).z)
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles = arg_60_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_60_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).z)
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles = arg_60_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = arg_60_1.actors_["6148ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos6148ui_story = var_63_3.localPosition

				local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_3.gameObject, typeof(DynamicBoneHelper))

				if var_63_4 then
					var_63_4:EnableDynamicBone(false)
				end
			end

			local var_63_5 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_5 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_60_1.time_ - 0) / var_63_5)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_5 and arg_60_1.time_ < 0 + var_63_5 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles

				local var_63_6 = GameObjectTools.GetOrAddComponent(var_63_3.gameObject, typeof(DynamicBoneHelper))

				if var_63_6 then
					var_63_6:EnableDynamicBone(true)
				end
			end

			local var_63_7 = arg_60_1.actors_["6148ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect6148ui_story == nil then
				arg_60_1.var_.characterEffect6148ui_story = var_63_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_8 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_8 and not isNil(var_63_7) then
				if arg_60_1.var_.characterEffect6148ui_story and not isNil(var_63_7) then
					arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_8 and arg_60_1.time_ < 0 + var_63_8 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect6148ui_story then
				arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_63_10 = arg_60_1.actors_["10175ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_10) and arg_60_1.var_.characterEffect10175ui_story == nil then
				arg_60_1.var_.characterEffect10175ui_story = var_63_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_11 and not isNil(var_63_10) then
				if arg_60_1.var_.characterEffect10175ui_story and not isNil(var_63_10) then
					arg_60_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_11)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_11 and arg_60_1.time_ < 0 + var_63_11 + arg_63_0 and not isNil(var_63_10) and arg_60_1.var_.characterEffect10175ui_story then
				arg_60_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_63_12 = 0
			local var_63_13 = 0.375

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_14 = arg_60_1:GetWordFromCfg(325611015)
				local var_63_15 = arg_60_1:FormatText(var_63_14.content)

				arg_60_1.text_.text = var_63_15

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 15 <= 0 and var_63_13 or var_63_13 * (utf8.len(var_63_15) / 15)

				if (15 <= 0 and var_63_13 or var_63_13 * (utf8.len(var_63_15) / 15)) > 0 and var_63_13 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_15
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611015", "story_v_out_325611.awb") ~= 0 then
					local var_63_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611015", "story_v_out_325611.awb") / 1000

					if var_63_18 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_12
					end

					if var_63_14.prefab_name ~= "" and arg_60_1.actors_[var_63_14.prefab_name] ~= nil then
						local var_63_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_14.prefab_name].transform, "story_v_out_325611", "325611015", "story_v_out_325611.awb")

						arg_60_1:RecordAudio("325611015", var_63_19)
						arg_60_1:RecordAudio("325611015", var_63_19)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325611", "325611015", "story_v_out_325611.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325611", "325611015", "story_v_out_325611.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_20 and arg_60_1.time_ < var_63_12 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325611016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325611016
		arg_64_1.duration_ = 7.5

		local var_64_0 = {
			zh = 5.2,
			ja = 7.5
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325611017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10175ui_story"]) and arg_64_1.var_.characterEffect10175ui_story == nil then
				arg_64_1.var_.characterEffect10175ui_story = arg_64_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10175ui_story"]) then
				if arg_64_1.var_.characterEffect10175ui_story and not isNil(arg_64_1.actors_["10175ui_story"]) then
					arg_64_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10175ui_story"]) and arg_64_1.var_.characterEffect10175ui_story then
				arg_64_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["6148ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_67_4 = 0
			local var_67_5 = 0.575

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(325611016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 23 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 23)

				if (23 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 23)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611016", "story_v_out_325611.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611016", "story_v_out_325611.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_325611", "325611016", "story_v_out_325611.awb")

						arg_64_1:RecordAudio("325611016", var_67_11)
						arg_64_1:RecordAudio("325611016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325611", "325611016", "story_v_out_325611.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325611", "325611016", "story_v_out_325611.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325611017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325611017
		arg_68_1.duration_ = 5.33

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325611018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_9001
			local var_71_9000

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10175ui_story = arg_68_1.actors_["10175ui_story"].transform.localPosition

				local var_71_0 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_0 then
					var_71_0:EnableDynamicBone(false)
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_1)
				arg_68_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10175ui_story"].transform.position).z)
				arg_68_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["10175ui_story"].transform.localEulerAngles = arg_68_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10175ui_story"].transform.position).z)
				arg_68_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["10175ui_story"].transform.localEulerAngles = arg_68_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(true)
				end
			end

			local var_71_3 = arg_68_1.actors_["6148ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos6148ui_story = var_71_3.localPosition

				local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_3.gameObject, typeof(DynamicBoneHelper))

				if var_71_4 then
					var_71_4:EnableDynamicBone(false)
				end
			end

			local var_71_5 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_5 then
				var_71_3.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_5)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_5 and arg_68_1.time_ < 0 + var_71_5 + arg_71_0 then
				var_71_3.localPosition = Vector3.New(0, 100, 0)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles

				local var_71_6 = GameObjectTools.GetOrAddComponent(var_71_3.gameObject, typeof(DynamicBoneHelper))

				if var_71_6 then
					var_71_6:EnableDynamicBone(true)
				end
			end

			local var_71_7 = arg_68_1.actors_["10175ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_7) and arg_68_1.var_.characterEffect10175ui_story == nil then
				arg_68_1.var_.characterEffect10175ui_story = var_71_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_8 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_8 and not isNil(var_71_7) then
				if arg_68_1.var_.characterEffect10175ui_story and not isNil(var_71_7) then
					arg_68_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_8)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_8 and arg_68_1.time_ < 0 + var_71_8 + arg_71_0 and not isNil(var_71_7) and arg_68_1.var_.characterEffect10175ui_story then
				arg_68_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				local var_71_9 = arg_68_1.var_.effectpikaidaolu1

				if not arg_68_1.var_.effectpikaidaolu1 then
					var_71_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_71_9.name = "pikaidaolu1"
					arg_68_1.var_.effectpikaidaolu1 = var_71_9
				else
					var_71_9.transform:SetParent(var_71_9001)
				end

				var_71_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_71_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				local var_71_11 = arg_68_1.var_.effectpikaidaolu2

				if not arg_68_1.var_.effectpikaidaolu2 then
					var_71_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_71_11.name = "pikaidaolu2"
					arg_68_1.var_.effectpikaidaolu2 = var_71_11
				else
					var_71_11.transform:SetParent(var_71_9000)
				end

				var_71_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_71_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_71_13 = manager.ui.mainCamera.transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.shakeOldPos = var_71_13.localPosition
			end

			local var_71_14 = 0.6

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_14 then
				local var_71_15, var_71_16 = math.modf((arg_68_1.time_ - 0) / 0.066)

				var_71_13.localPosition = Vector3.New(var_71_16 * 0.13, var_71_16 * 0.13, var_71_16 * 0.13) + arg_68_1.var_.shakeOldPos
			end

			if arg_68_1.time_ >= 0 + var_71_14 and arg_68_1.time_ < 0 + var_71_14 + arg_71_0 then
				var_71_13.localPosition = arg_68_1.var_.shakeOldPos
			end

			local var_71_17 = 0

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			if arg_68_1.time_ >= var_71_17 + 1.46666666666667 and arg_68_1.time_ < var_71_17 + 1.46666666666667 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_18 = 0.333333333333333
			local var_71_19 = 1.35

			if 0.333333333333333 < arg_68_1.time_ and arg_68_1.time_ <= var_71_18 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_20 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_20:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_21 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(325611017).content)

				arg_68_1.text_.text = var_71_21

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_23 = 54 <= 0 and var_71_19 or var_71_19 * (utf8.len(var_71_21) / 54)

				if (54 <= 0 and var_71_19 or var_71_19 * (utf8.len(var_71_21) / 54)) > 0 and var_71_19 < var_71_23 then
					arg_68_1.talkMaxDuration = var_71_23
					var_71_18 = var_71_18 + 0.3

					if var_71_23 + var_71_18 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_18
					end
				end

				arg_68_1.text_.text = var_71_21
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_24 = var_71_18 + 0.3
			local var_71_25 = math.max(var_71_19, arg_68_1.talkMaxDuration)

			if var_71_18 + 0.3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_24 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_24) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_24 + var_71_25 and arg_68_1.time_ < var_71_24 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play325611018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325611018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325611019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 1.15

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(325611018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 46 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 46)

				if (46 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 46)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325611019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325611019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325611020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1.275

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(325611019).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 51 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 51)

				if (51 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 51)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325611020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325611020
		arg_82_1.duration_ = 2

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325611021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1054ui_story = arg_82_1.actors_["1054ui_story"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).z)
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles = arg_82_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_82_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).z)
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles = arg_82_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["6148ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos6148ui_story = var_85_3.localPosition

				local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_3.gameObject, typeof(DynamicBoneHelper))

				if var_85_4 then
					var_85_4:EnableDynamicBone(false)
				end
			end

			local var_85_5 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_5 then
				var_85_3.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_82_1.time_ - 0) / var_85_5)
				var_85_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_3.position).x, (manager.ui.mainCamera.transform.position - var_85_3.position).y, (manager.ui.mainCamera.transform.position - var_85_3.position).z)
				var_85_3.localEulerAngles.z = 0
				var_85_3.localEulerAngles.x = 0
				var_85_3.localEulerAngles = var_85_3.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_5 and arg_82_1.time_ < 0 + var_85_5 + arg_85_0 then
				var_85_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_85_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_3.position).x, (manager.ui.mainCamera.transform.position - var_85_3.position).y, (manager.ui.mainCamera.transform.position - var_85_3.position).z)
				var_85_3.localEulerAngles.z = 0
				var_85_3.localEulerAngles.x = 0
				var_85_3.localEulerAngles = var_85_3.localEulerAngles

				local var_85_6 = GameObjectTools.GetOrAddComponent(var_85_3.gameObject, typeof(DynamicBoneHelper))

				if var_85_6 then
					var_85_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_85_7 = arg_82_1.actors_["6148ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_7) and arg_82_1.var_.characterEffect6148ui_story == nil then
				arg_82_1.var_.characterEffect6148ui_story = var_85_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_8 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_8 and not isNil(var_85_7) then
				if arg_82_1.var_.characterEffect6148ui_story and not isNil(var_85_7) then
					arg_82_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_8 and arg_82_1.time_ < 0 + var_85_8 + arg_85_0 and not isNil(var_85_7) and arg_82_1.var_.characterEffect6148ui_story then
				arg_82_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_85_10 = arg_82_1.actors_["1054ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_10) and arg_82_1.var_.characterEffect1054ui_story == nil then
				arg_82_1.var_.characterEffect1054ui_story = var_85_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_11 and not isNil(var_85_10) then
				if arg_82_1.var_.characterEffect1054ui_story and not isNil(var_85_10) then
					arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_11 and arg_82_1.time_ < 0 + var_85_11 + arg_85_0 and not isNil(var_85_10) and arg_82_1.var_.characterEffect1054ui_story then
				arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_85_13 = 0
			local var_85_14 = 0.075

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_15 = arg_82_1:GetWordFromCfg(325611020)
				local var_85_16 = arg_82_1:FormatText(var_85_15.content)

				arg_82_1.text_.text = var_85_16

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_18 = 3 <= 0 and var_85_14 or var_85_14 * (utf8.len(var_85_16) / 3)

				if (3 <= 0 and var_85_14 or var_85_14 * (utf8.len(var_85_16) / 3)) > 0 and var_85_14 < var_85_18 then
					arg_82_1.talkMaxDuration = var_85_18

					if var_85_18 + var_85_13 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_13
					end
				end

				arg_82_1.text_.text = var_85_16
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611020", "story_v_out_325611.awb") ~= 0 then
					local var_85_19 = manager.audio:GetVoiceLength("story_v_out_325611", "325611020", "story_v_out_325611.awb") / 1000

					if var_85_19 + var_85_13 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_13
					end

					if var_85_15.prefab_name ~= "" and arg_82_1.actors_[var_85_15.prefab_name] ~= nil then
						local var_85_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_15.prefab_name].transform, "story_v_out_325611", "325611020", "story_v_out_325611.awb")

						arg_82_1:RecordAudio("325611020", var_85_20)
						arg_82_1:RecordAudio("325611020", var_85_20)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325611", "325611020", "story_v_out_325611.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325611", "325611020", "story_v_out_325611.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_21 = math.max(var_85_14, arg_82_1.talkMaxDuration)

			if var_85_13 <= arg_82_1.time_ and arg_82_1.time_ < var_85_13 + var_85_21 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_13) / var_85_21

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_13 + var_85_21 and arg_82_1.time_ < var_85_13 + var_85_21 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play325611021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325611021
		arg_86_1.duration_ = 4.83

		local var_86_0 = {
			zh = 3.5,
			ja = 4.833
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325611022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10175ui_story = arg_86_1.actors_["10175ui_story"].transform.localPosition

				local var_89_0 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_0 then
					var_89_0:EnableDynamicBone(false)
				end
			end

			local var_89_1 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_1 then
				arg_86_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_86_1.time_ - 0) / var_89_1)
				arg_86_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10175ui_story"].transform.position).z)
				arg_86_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10175ui_story"].transform.localEulerAngles = arg_86_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_1 and arg_86_1.time_ < 0 + var_89_1 + arg_89_0 then
				arg_86_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_86_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10175ui_story"].transform.position).z)
				arg_86_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10175ui_story"].transform.localEulerAngles = arg_86_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_89_2 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(true)
				end
			end

			local var_89_3 = arg_86_1.actors_["6148ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = var_89_3.localPosition

				local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_3.gameObject, typeof(DynamicBoneHelper))

				if var_89_4 then
					var_89_4:EnableDynamicBone(false)
				end
			end

			local var_89_5 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				var_89_3.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_5)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 then
				var_89_3.localPosition = Vector3.New(0, 100, 0)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles

				local var_89_6 = GameObjectTools.GetOrAddComponent(var_89_3.gameObject, typeof(DynamicBoneHelper))

				if var_89_6 then
					var_89_6:EnableDynamicBone(true)
				end
			end

			local var_89_7 = arg_86_1.actors_["1054ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = var_89_7.localPosition

				local var_89_8 = GameObjectTools.GetOrAddComponent(var_89_7.gameObject, typeof(DynamicBoneHelper))

				if var_89_8 then
					var_89_8:EnableDynamicBone(false)
				end
			end

			local var_89_9 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_9 then
				var_89_7.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_9)
				var_89_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_7.position).x, (manager.ui.mainCamera.transform.position - var_89_7.position).y, (manager.ui.mainCamera.transform.position - var_89_7.position).z)
				var_89_7.localEulerAngles.z = 0
				var_89_7.localEulerAngles.x = 0
				var_89_7.localEulerAngles = var_89_7.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_9 and arg_86_1.time_ < 0 + var_89_9 + arg_89_0 then
				var_89_7.localPosition = Vector3.New(0, 100, 0)
				var_89_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_7.position).x, (manager.ui.mainCamera.transform.position - var_89_7.position).y, (manager.ui.mainCamera.transform.position - var_89_7.position).z)
				var_89_7.localEulerAngles.z = 0
				var_89_7.localEulerAngles.x = 0
				var_89_7.localEulerAngles = var_89_7.localEulerAngles

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_7.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["10175ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect10175ui_story == nil then
				arg_86_1.var_.characterEffect10175ui_story = var_89_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_12 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_12 and not isNil(var_89_11) then
				if arg_86_1.var_.characterEffect10175ui_story and not isNil(var_89_11) then
					arg_86_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_12 and arg_86_1.time_ < 0 + var_89_12 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect10175ui_story then
				arg_86_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_89_14 = 0
			local var_89_15 = 0.325

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_16 = arg_86_1:GetWordFromCfg(325611021)
				local var_89_17 = arg_86_1:FormatText(var_89_16.content)

				arg_86_1.text_.text = var_89_17

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_19 = 13 <= 0 and var_89_15 or var_89_15 * (utf8.len(var_89_17) / 13)

				if (13 <= 0 and var_89_15 or var_89_15 * (utf8.len(var_89_17) / 13)) > 0 and var_89_15 < var_89_19 then
					arg_86_1.talkMaxDuration = var_89_19

					if var_89_19 + var_89_14 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_19 + var_89_14
					end
				end

				arg_86_1.text_.text = var_89_17
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611021", "story_v_out_325611.awb") ~= 0 then
					local var_89_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611021", "story_v_out_325611.awb") / 1000

					if var_89_20 + var_89_14 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_20 + var_89_14
					end

					if var_89_16.prefab_name ~= "" and arg_86_1.actors_[var_89_16.prefab_name] ~= nil then
						local var_89_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_16.prefab_name].transform, "story_v_out_325611", "325611021", "story_v_out_325611.awb")

						arg_86_1:RecordAudio("325611021", var_89_21)
						arg_86_1:RecordAudio("325611021", var_89_21)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325611", "325611021", "story_v_out_325611.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325611", "325611021", "story_v_out_325611.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_15, arg_86_1.talkMaxDuration)

			if var_89_14 <= arg_86_1.time_ and arg_86_1.time_ < var_89_14 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_14) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_14 + var_89_22 and arg_86_1.time_ < var_89_14 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play325611022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325611022
		arg_90_1.duration_ = 2.73

		local var_90_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325611023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10175ui_story = arg_90_1.actors_["10175ui_story"].transform.localPosition

				local var_93_0 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_0 then
					var_93_0:EnableDynamicBone(false)
				end
			end

			local var_93_1 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 then
				arg_90_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_90_1.time_ - 0) / var_93_1)
				arg_90_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10175ui_story"].transform.position).z)
				arg_90_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10175ui_story"].transform.localEulerAngles = arg_90_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 then
				arg_90_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_90_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10175ui_story"].transform.position).z)
				arg_90_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10175ui_story"].transform.localEulerAngles = arg_90_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_93_2 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(true)
				end
			end

			local var_93_3 = "1170ui_story"

			if arg_90_1.actors_["1170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1170ui_story"))) then
				local var_93_4 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_90_1.stage_.transform)

				var_93_4.name = var_93_3
				var_93_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_[var_93_3] = var_93_4

				local var_93_5 = var_93_4:GetComponentInChildren(typeof(CharacterEffect))

				var_93_5.enabled = true

				local var_93_6 = GameObjectTools.GetOrAddComponent(var_93_4, typeof(DynamicBoneHelper))

				if var_93_6 then
					var_93_6:EnableDynamicBone(false)
				end

				arg_90_1:ShowWeapon(var_93_5.transform, false)

				arg_90_1.var_[var_93_3 .. "Animator"] = var_93_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_90_1.var_[var_93_3 .. "Animator"].applyRootMotion = true
				arg_90_1.var_[var_93_3 .. "LipSync"] = var_93_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_93_7 = arg_90_1.actors_["1170ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1170ui_story = var_93_7.localPosition

				local var_93_8 = GameObjectTools.GetOrAddComponent(var_93_7.gameObject, typeof(DynamicBoneHelper))

				if var_93_8 then
					var_93_8:EnableDynamicBone(false)
				end
			end

			local var_93_9 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_9 then
				var_93_7.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1170ui_story, Vector3.New(0.74, -0.95, -6.08), (arg_90_1.time_ - 0) / var_93_9)
				var_93_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_7.position).x, (manager.ui.mainCamera.transform.position - var_93_7.position).y, (manager.ui.mainCamera.transform.position - var_93_7.position).z)
				var_93_7.localEulerAngles.z = 0
				var_93_7.localEulerAngles.x = 0
				var_93_7.localEulerAngles = var_93_7.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_9 and arg_90_1.time_ < 0 + var_93_9 + arg_93_0 then
				var_93_7.localPosition = Vector3.New(0.74, -0.95, -6.08)
				var_93_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_7.position).x, (manager.ui.mainCamera.transform.position - var_93_7.position).y, (manager.ui.mainCamera.transform.position - var_93_7.position).z)
				var_93_7.localEulerAngles.z = 0
				var_93_7.localEulerAngles.x = 0
				var_93_7.localEulerAngles = var_93_7.localEulerAngles

				local var_93_10 = GameObjectTools.GetOrAddComponent(var_93_7.gameObject, typeof(DynamicBoneHelper))

				if var_93_10 then
					var_93_10:EnableDynamicBone(true)
				end
			end

			local var_93_11 = arg_90_1.actors_["1170ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_11) and arg_90_1.var_.characterEffect1170ui_story == nil then
				arg_90_1.var_.characterEffect1170ui_story = var_93_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_12 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_12 and not isNil(var_93_11) then
				if arg_90_1.var_.characterEffect1170ui_story and not isNil(var_93_11) then
					arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_12 and arg_90_1.time_ < 0 + var_93_12 + arg_93_0 and not isNil(var_93_11) and arg_90_1.var_.characterEffect1170ui_story then
				arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_93_14 = arg_90_1.actors_["10175ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_14) and arg_90_1.var_.characterEffect10175ui_story == nil then
				arg_90_1.var_.characterEffect10175ui_story = var_93_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_15 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_15 and not isNil(var_93_14) then
				if arg_90_1.var_.characterEffect10175ui_story and not isNil(var_93_14) then
					arg_90_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_15)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_15 and arg_90_1.time_ < 0 + var_93_15 + arg_93_0 and not isNil(var_93_14) and arg_90_1.var_.characterEffect10175ui_story then
				arg_90_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_93_16 = 0
			local var_93_17 = 0.225

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_16 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(325611022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_21 = 9 <= 0 and var_93_17 or var_93_17 * (utf8.len(var_93_19) / 9)

				if (9 <= 0 and var_93_17 or var_93_17 * (utf8.len(var_93_19) / 9)) > 0 and var_93_17 < var_93_21 then
					arg_90_1.talkMaxDuration = var_93_21

					if var_93_21 + var_93_16 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_21 + var_93_16
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611022", "story_v_out_325611.awb") ~= 0 then
					local var_93_22 = manager.audio:GetVoiceLength("story_v_out_325611", "325611022", "story_v_out_325611.awb") / 1000

					if var_93_22 + var_93_16 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_16
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_out_325611", "325611022", "story_v_out_325611.awb")

						arg_90_1:RecordAudio("325611022", var_93_23)
						arg_90_1:RecordAudio("325611022", var_93_23)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325611", "325611022", "story_v_out_325611.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325611", "325611022", "story_v_out_325611.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_24 = math.max(var_93_17, arg_90_1.talkMaxDuration)

			if var_93_16 <= arg_90_1.time_ and arg_90_1.time_ < var_93_16 + var_93_24 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_16) / var_93_24

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_16 + var_93_24 and arg_90_1.time_ < var_93_16 + var_93_24 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play325611023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325611023
		arg_94_1.duration_ = 5.23

		local var_94_0 = {
			zh = 2.8,
			ja = 5.233
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play325611024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10175ui_story"]) and arg_94_1.var_.characterEffect10175ui_story == nil then
				arg_94_1.var_.characterEffect10175ui_story = arg_94_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10175ui_story"]) then
				if arg_94_1.var_.characterEffect10175ui_story and not isNil(arg_94_1.actors_["10175ui_story"]) then
					arg_94_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10175ui_story"]) and arg_94_1.var_.characterEffect10175ui_story then
				arg_94_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["1170ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1170ui_story == nil then
				arg_94_1.var_.characterEffect1170ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect1170ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1170ui_story then
				arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_97_4 = "1071ui_story"

			if arg_94_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_97_5 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_94_1.stage_.transform)

				var_97_5.name = var_97_4
				var_97_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_[var_97_4] = var_97_5

				local var_97_6 = var_97_5:GetComponentInChildren(typeof(CharacterEffect))

				var_97_6.enabled = true

				local var_97_7 = GameObjectTools.GetOrAddComponent(var_97_5, typeof(DynamicBoneHelper))

				if var_97_7 then
					var_97_7:EnableDynamicBone(false)
				end

				arg_94_1:ShowWeapon(var_97_6.transform, false)

				arg_94_1.var_[var_97_4 .. "Animator"] = var_97_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_94_1.var_[var_97_4 .. "Animator"].applyRootMotion = true
				arg_94_1.var_[var_97_4 .. "LipSync"] = var_97_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_97_8 = 0
			local var_97_9 = 0.325

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(325611023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 13 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 13)

				if (13 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 13)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611023", "story_v_out_325611.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_325611", "325611023", "story_v_out_325611.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_325611", "325611023", "story_v_out_325611.awb")

						arg_94_1:RecordAudio("325611023", var_97_15)
						arg_94_1:RecordAudio("325611023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325611", "325611023", "story_v_out_325611.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325611", "325611023", "story_v_out_325611.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325611024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325611024
		arg_98_1.duration_ = 12.67

		local var_98_0 = {
			zh = 8.5,
			ja = 12.666
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325611025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10175ui_story = arg_98_1.actors_["10175ui_story"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10175ui_story"].transform.position).z)
				arg_98_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10175ui_story"].transform.localEulerAngles = arg_98_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10175ui_story"].transform.position).z)
				arg_98_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10175ui_story"].transform.localEulerAngles = arg_98_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = arg_98_1.actors_["1071ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1071ui_story = var_101_3.localPosition
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_3.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_98_1.time_ - 0) / var_101_4)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			local var_101_5 = arg_98_1.actors_["1170ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1170ui_story = var_101_5.localPosition

				local var_101_6 = GameObjectTools.GetOrAddComponent(var_101_5.gameObject, typeof(DynamicBoneHelper))

				if var_101_6 then
					var_101_6:EnableDynamicBone(false)
				end
			end

			local var_101_7 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_7)
				var_101_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_5.position).x, (manager.ui.mainCamera.transform.position - var_101_5.position).y, (manager.ui.mainCamera.transform.position - var_101_5.position).z)
				var_101_5.localEulerAngles.z = 0
				var_101_5.localEulerAngles.x = 0
				var_101_5.localEulerAngles = var_101_5.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(0, 100, 0)
				var_101_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_5.position).x, (manager.ui.mainCamera.transform.position - var_101_5.position).y, (manager.ui.mainCamera.transform.position - var_101_5.position).z)
				var_101_5.localEulerAngles.z = 0
				var_101_5.localEulerAngles.x = 0
				var_101_5.localEulerAngles = var_101_5.localEulerAngles

				local var_101_8 = GameObjectTools.GetOrAddComponent(var_101_5.gameObject, typeof(DynamicBoneHelper))

				if var_101_8 then
					var_101_8:EnableDynamicBone(true)
				end
			end

			local var_101_9 = arg_98_1.actors_["1071ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1071ui_story == nil then
				arg_98_1.var_.characterEffect1071ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_10 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_10 and not isNil(var_101_9) then
				if arg_98_1.var_.characterEffect1071ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_10 and arg_98_1.time_ < 0 + var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1071ui_story then
				arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_101_12 = arg_98_1.actors_["10175ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_12) and arg_98_1.var_.characterEffect10175ui_story == nil then
				arg_98_1.var_.characterEffect10175ui_story = var_101_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_13 and not isNil(var_101_12) then
				if arg_98_1.var_.characterEffect10175ui_story and not isNil(var_101_12) then
					arg_98_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_13)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_13 and arg_98_1.time_ < 0 + var_101_13 + arg_101_0 and not isNil(var_101_12) and arg_98_1.var_.characterEffect10175ui_story then
				arg_98_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_101_14 = 0
			local var_101_15 = 1.025

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_16 = arg_98_1:GetWordFromCfg(325611024)
				local var_101_17 = arg_98_1:FormatText(var_101_16.content)

				arg_98_1.text_.text = var_101_17

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_19 = 41 <= 0 and var_101_15 or var_101_15 * (utf8.len(var_101_17) / 41)

				if (41 <= 0 and var_101_15 or var_101_15 * (utf8.len(var_101_17) / 41)) > 0 and var_101_15 < var_101_19 then
					arg_98_1.talkMaxDuration = var_101_19

					if var_101_19 + var_101_14 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_14
					end
				end

				arg_98_1.text_.text = var_101_17
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611024", "story_v_out_325611.awb") ~= 0 then
					local var_101_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611024", "story_v_out_325611.awb") / 1000

					if var_101_20 + var_101_14 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_20 + var_101_14
					end

					if var_101_16.prefab_name ~= "" and arg_98_1.actors_[var_101_16.prefab_name] ~= nil then
						local var_101_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_16.prefab_name].transform, "story_v_out_325611", "325611024", "story_v_out_325611.awb")

						arg_98_1:RecordAudio("325611024", var_101_21)
						arg_98_1:RecordAudio("325611024", var_101_21)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325611", "325611024", "story_v_out_325611.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325611", "325611024", "story_v_out_325611.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_15, arg_98_1.talkMaxDuration)

			if var_101_14 <= arg_98_1.time_ and arg_98_1.time_ < var_101_14 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_14) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_14 + var_101_22 and arg_98_1.time_ < var_101_14 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play325611025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325611025
		arg_102_1.duration_ = 12.2

		local var_102_0 = {
			zh = 6.733,
			ja = 12.2
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325611026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.9

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(325611025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 36 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 36)

				if (36 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 36)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611025", "story_v_out_325611.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_325611", "325611025", "story_v_out_325611.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_325611", "325611025", "story_v_out_325611.awb")

						arg_102_1:RecordAudio("325611025", var_105_6)
						arg_102_1:RecordAudio("325611025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325611", "325611025", "story_v_out_325611.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325611", "325611025", "story_v_out_325611.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325611026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325611026
		arg_106_1.duration_ = 7.6

		local var_106_0 = {
			zh = 6.133,
			ja = 7.6
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325611027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1071ui_story = arg_106_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1071ui_story"].transform.position).z)
				arg_106_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1071ui_story"].transform.localEulerAngles = arg_106_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_106_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1071ui_story"].transform.position).z)
				arg_106_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1071ui_story"].transform.localEulerAngles = arg_106_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["10175ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10175ui_story = var_109_1.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_1.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 then
				var_109_1.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_106_1.time_ - 0) / var_109_3)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 then
				var_109_1.localPosition = Vector3.New(0.7, -1, -6.05)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles

				local var_109_4 = GameObjectTools.GetOrAddComponent(var_109_1.gameObject, typeof(DynamicBoneHelper))

				if var_109_4 then
					var_109_4:EnableDynamicBone(true)
				end
			end

			local var_109_5 = arg_106_1.actors_["10175ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect10175ui_story == nil then
				arg_106_1.var_.characterEffect10175ui_story = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_6 and not isNil(var_109_5) then
				if arg_106_1.var_.characterEffect10175ui_story and not isNil(var_109_5) then
					arg_106_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_6 and arg_106_1.time_ < 0 + var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect10175ui_story then
				arg_106_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_109_8 = arg_106_1.actors_["1071ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.characterEffect1071ui_story == nil then
				arg_106_1.var_.characterEffect1071ui_story = var_109_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_9 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_9 and not isNil(var_109_8) then
				if arg_106_1.var_.characterEffect1071ui_story and not isNil(var_109_8) then
					arg_106_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_9)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_9 and arg_106_1.time_ < 0 + var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.characterEffect1071ui_story then
				arg_106_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_109_10 = 0
			local var_109_11 = 0.6

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_12 = arg_106_1:GetWordFromCfg(325611026)
				local var_109_13 = arg_106_1:FormatText(var_109_12.content)

				arg_106_1.text_.text = var_109_13

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_15 = 24 <= 0 and var_109_11 or var_109_11 * (utf8.len(var_109_13) / 24)

				if (24 <= 0 and var_109_11 or var_109_11 * (utf8.len(var_109_13) / 24)) > 0 and var_109_11 < var_109_15 then
					arg_106_1.talkMaxDuration = var_109_15

					if var_109_15 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_15 + var_109_10
					end
				end

				arg_106_1.text_.text = var_109_13
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611026", "story_v_out_325611.awb") ~= 0 then
					local var_109_16 = manager.audio:GetVoiceLength("story_v_out_325611", "325611026", "story_v_out_325611.awb") / 1000

					if var_109_16 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_16 + var_109_10
					end

					if var_109_12.prefab_name ~= "" and arg_106_1.actors_[var_109_12.prefab_name] ~= nil then
						local var_109_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_12.prefab_name].transform, "story_v_out_325611", "325611026", "story_v_out_325611.awb")

						arg_106_1:RecordAudio("325611026", var_109_17)
						arg_106_1:RecordAudio("325611026", var_109_17)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325611", "325611026", "story_v_out_325611.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325611", "325611026", "story_v_out_325611.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = math.max(var_109_11, arg_106_1.talkMaxDuration)

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_18 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_10) / var_109_18

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_10 + var_109_18 and arg_106_1.time_ < var_109_10 + var_109_18 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play325611027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325611027
		arg_110_1.duration_ = 7.93

		local var_110_0 = {
			zh = 4.9,
			ja = 7.933
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325611028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.625

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(325611027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 25 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 25)

				if (25 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 25)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611027", "story_v_out_325611.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_325611", "325611027", "story_v_out_325611.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_325611", "325611027", "story_v_out_325611.awb")

						arg_110_1:RecordAudio("325611027", var_113_6)
						arg_110_1:RecordAudio("325611027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325611", "325611027", "story_v_out_325611.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325611", "325611027", "story_v_out_325611.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325611028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325611028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325611029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10175ui_story = arg_114_1.actors_["10175ui_story"].transform.localPosition

				local var_117_0 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_0 then
					var_117_0:EnableDynamicBone(false)
				end
			end

			local var_117_1 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 then
				arg_114_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_1)
				arg_114_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10175ui_story"].transform.position).z)
				arg_114_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["10175ui_story"].transform.localEulerAngles = arg_114_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 then
				arg_114_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10175ui_story"].transform.position).z)
				arg_114_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["10175ui_story"].transform.localEulerAngles = arg_114_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_117_2 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(true)
				end
			end

			local var_117_3 = arg_114_1.actors_["10175ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_3) and arg_114_1.var_.characterEffect10175ui_story == nil then
				arg_114_1.var_.characterEffect10175ui_story = var_117_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_4 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 and not isNil(var_117_3) then
				if arg_114_1.var_.characterEffect10175ui_story and not isNil(var_117_3) then
					arg_114_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_4)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 and not isNil(var_117_3) and arg_114_1.var_.characterEffect10175ui_story then
				arg_114_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_117_5 = arg_114_1.actors_["1071ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1071ui_story = var_117_5.localPosition
			end

			local var_117_6 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 then
				var_117_5.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_6)
				var_117_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_5.position).x, (manager.ui.mainCamera.transform.position - var_117_5.position).y, (manager.ui.mainCamera.transform.position - var_117_5.position).z)
				var_117_5.localEulerAngles.z = 0
				var_117_5.localEulerAngles.x = 0
				var_117_5.localEulerAngles = var_117_5.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 then
				var_117_5.localPosition = Vector3.New(0, 100, 0)
				var_117_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_5.position).x, (manager.ui.mainCamera.transform.position - var_117_5.position).y, (manager.ui.mainCamera.transform.position - var_117_5.position).z)
				var_117_5.localEulerAngles.z = 0
				var_117_5.localEulerAngles.x = 0
				var_117_5.localEulerAngles = var_117_5.localEulerAngles
			end

			local var_117_7 = 0
			local var_117_8 = 1.025

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_9 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(325611028).content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 41 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 41)

				if (41 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 41)) > 0 and var_117_8 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_7 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_7
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_8, arg_114_1.talkMaxDuration)

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_7) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_7 + var_117_12 and arg_114_1.time_ < var_117_7 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play325611029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325611029
		arg_118_1.duration_ = 9

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325611030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.bgs_.J21h == nil then
				local var_121_0 = Object.Instantiate(arg_118_1.paintGo_)

				var_121_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_121_0.name = "J21h"
				var_121_0.transform.parent = arg_118_1.stage_.transform
				var_121_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.bgs_.J21h = var_121_0
			end

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				local var_121_1 = arg_118_1.bgs_.J21h

				arg_118_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_121_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_2 = var_121_1:GetComponent("SpriteRenderer")

				if var_121_2 and var_121_2.sprite then
					local var_121_3 = 2 * (var_121_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_121_1.transform.localScale = Vector3.New(var_121_3 / var_121_2.sprite.bounds.size.y < var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x and var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x or var_121_3 / var_121_2.sprite.bounds.size.y, var_121_3 / var_121_2.sprite.bounds.size.y < var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x and var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x or var_121_3 / var_121_2.sprite.bounds.size.y, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "J21h" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_4 = 4

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_4 + 0.3 and arg_118_1.time_ < var_121_4 + 0.3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_5 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_6 = 2

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 then
				local var_121_7 = Color.New(0, 0, 0)

				var_121_7.a = Mathf.Lerp(0, 1, (arg_118_1.time_ - var_121_5) / var_121_6)
				arg_118_1.mask_.color = var_121_7
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 then
				local var_121_8 = Color.New(0, 0, 0)

				var_121_8.a = 1
				arg_118_1.mask_.color = var_121_8
			end

			local var_121_9 = 2

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_10 = 2

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 then
				local var_121_11 = Color.New(0, 0, 0)

				var_121_11.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - var_121_9) / var_121_10)
				arg_118_1.mask_.color = var_121_11
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 then
				local var_121_12 = Color.New(0, 0, 0)

				arg_118_1.mask_.enabled = false
				var_121_12.a = 0
				arg_118_1.mask_.color = var_121_12
			end

			if 0.1 < arg_118_1.time_ and arg_118_1.time_ <= 0.1 + arg_121_0 then
				arg_118_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_battleground_loop", "")
			end

			if 0.1 < arg_118_1.time_ and arg_118_1.time_ <= 0.1 + arg_121_0 then
				arg_118_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_15 = 4
			local var_121_16 = 1.625

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_17 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_17:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(325611029).content)

				arg_118_1.text_.text = var_121_18

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 65 <= 0 and var_121_16 or var_121_16 * (utf8.len(var_121_18) / 65)

				if (65 <= 0 and var_121_16 or var_121_16 * (utf8.len(var_121_18) / 65)) > 0 and var_121_16 < var_121_20 then
					arg_118_1.talkMaxDuration = var_121_20
					var_121_15 = var_121_15 + 0.3

					if var_121_20 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_20 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_18
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_21 = var_121_15 + 0.3
			local var_121_22 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_22 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_21) / var_121_22

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_21 + var_121_22 and arg_118_1.time_ < var_121_21 + var_121_22 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325611030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325611030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325611031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.975

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(325611030).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 39 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 39)

				if (39 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 39)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325611031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325611031
		arg_128_1.duration_ = 4.6

		local var_128_0 = {
			zh = 2.466,
			ja = 4.6
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325611032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10175ui_story = arg_128_1.actors_["10175ui_story"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10175ui_story"].transform.position).z)
				arg_128_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10175ui_story"].transform.localEulerAngles = arg_128_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_128_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10175ui_story"].transform.position).z)
				arg_128_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10175ui_story"].transform.localEulerAngles = arg_128_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["10175ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect10175ui_story == nil then
				arg_128_1.var_.characterEffect10175ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect10175ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect10175ui_story then
				arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_131_6 = 0
			local var_131_7 = 0.225

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(325611031)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 9 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 9)

				if (9 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 9)) > 0 and var_131_7 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611031", "story_v_out_325611.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_325611", "325611031", "story_v_out_325611.awb") / 1000

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_out_325611", "325611031", "story_v_out_325611.awb")

						arg_128_1:RecordAudio("325611031", var_131_13)
						arg_128_1:RecordAudio("325611031", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325611", "325611031", "story_v_out_325611.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325611", "325611031", "story_v_out_325611.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play325611032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325611032
		arg_132_1.duration_ = 3.33

		local var_132_0 = {
			zh = 3.333,
			ja = 2.8
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325611033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10175ui_story = arg_132_1.actors_["10175ui_story"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10175ui_story"].transform.position).z)
				arg_132_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10175ui_story"].transform.localEulerAngles = arg_132_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_132_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10175ui_story"].transform.position).z)
				arg_132_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10175ui_story"].transform.localEulerAngles = arg_132_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = "10167ui_story"

			if arg_132_1.actors_["10167ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10167ui_story"))) then
				local var_135_4 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_132_1.stage_.transform)

				var_135_4.name = var_135_3
				var_135_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_[var_135_3] = var_135_4

				local var_135_5 = var_135_4:GetComponentInChildren(typeof(CharacterEffect))

				var_135_5.enabled = true

				local var_135_6 = GameObjectTools.GetOrAddComponent(var_135_4, typeof(DynamicBoneHelper))

				if var_135_6 then
					var_135_6:EnableDynamicBone(false)
				end

				arg_132_1:ShowWeapon(var_135_5.transform, false)

				arg_132_1.var_[var_135_3 .. "Animator"] = var_135_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_132_1.var_[var_135_3 .. "Animator"].applyRootMotion = true
				arg_132_1.var_[var_135_3 .. "LipSync"] = var_135_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_135_7 = arg_132_1.actors_["10167ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10167ui_story = var_135_7.localPosition

				local var_135_8 = GameObjectTools.GetOrAddComponent(var_135_7.gameObject, typeof(DynamicBoneHelper))

				if var_135_8 then
					var_135_8:EnableDynamicBone(false)
				end
			end

			local var_135_9 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_9 then
				var_135_7.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10167ui_story, Vector3.New(0.7, -1.28, -5.73), (arg_132_1.time_ - 0) / var_135_9)
				var_135_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_7.position).x, (manager.ui.mainCamera.transform.position - var_135_7.position).y, (manager.ui.mainCamera.transform.position - var_135_7.position).z)
				var_135_7.localEulerAngles.z = 0
				var_135_7.localEulerAngles.x = 0
				var_135_7.localEulerAngles = var_135_7.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_9 and arg_132_1.time_ < 0 + var_135_9 + arg_135_0 then
				var_135_7.localPosition = Vector3.New(0.7, -1.28, -5.73)
				var_135_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_7.position).x, (manager.ui.mainCamera.transform.position - var_135_7.position).y, (manager.ui.mainCamera.transform.position - var_135_7.position).z)
				var_135_7.localEulerAngles.z = 0
				var_135_7.localEulerAngles.x = 0
				var_135_7.localEulerAngles = var_135_7.localEulerAngles

				local var_135_10 = GameObjectTools.GetOrAddComponent(var_135_7.gameObject, typeof(DynamicBoneHelper))

				if var_135_10 then
					var_135_10:EnableDynamicBone(true)
				end
			end

			local var_135_11 = arg_132_1.actors_["10167ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_11) and arg_132_1.var_.characterEffect10167ui_story == nil then
				arg_132_1.var_.characterEffect10167ui_story = var_135_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_12 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_12 and not isNil(var_135_11) then
				if arg_132_1.var_.characterEffect10167ui_story and not isNil(var_135_11) then
					arg_132_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_12 and arg_132_1.time_ < 0 + var_135_12 + arg_135_0 and not isNil(var_135_11) and arg_132_1.var_.characterEffect10167ui_story then
				arg_132_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_135_14 = arg_132_1.actors_["10175ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_14) and arg_132_1.var_.characterEffect10175ui_story == nil then
				arg_132_1.var_.characterEffect10175ui_story = var_135_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_15 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_15 and not isNil(var_135_14) then
				if arg_132_1.var_.characterEffect10175ui_story and not isNil(var_135_14) then
					arg_132_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_15)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_15 and arg_132_1.time_ < 0 + var_135_15 + arg_135_0 and not isNil(var_135_14) and arg_132_1.var_.characterEffect10175ui_story then
				arg_132_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_135_16 = 0
			local var_135_17 = 0.2

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(325611032)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_21 = 8 <= 0 and var_135_17 or var_135_17 * (utf8.len(var_135_19) / 8)

				if (8 <= 0 and var_135_17 or var_135_17 * (utf8.len(var_135_19) / 8)) > 0 and var_135_17 < var_135_21 then
					arg_132_1.talkMaxDuration = var_135_21

					if var_135_21 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_21 + var_135_16
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611032", "story_v_out_325611.awb") ~= 0 then
					local var_135_22 = manager.audio:GetVoiceLength("story_v_out_325611", "325611032", "story_v_out_325611.awb") / 1000

					if var_135_22 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_16
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_325611", "325611032", "story_v_out_325611.awb")

						arg_132_1:RecordAudio("325611032", var_135_23)
						arg_132_1:RecordAudio("325611032", var_135_23)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325611", "325611032", "story_v_out_325611.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325611", "325611032", "story_v_out_325611.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_24 = math.max(var_135_17, arg_132_1.talkMaxDuration)

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_24 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_16) / var_135_24

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_16 + var_135_24 and arg_132_1.time_ < var_135_16 + var_135_24 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play325611033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325611033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325611034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10167ui_story"]) and arg_136_1.var_.characterEffect10167ui_story == nil then
				arg_136_1.var_.characterEffect10167ui_story = arg_136_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10167ui_story"]) then
				if arg_136_1.var_.characterEffect10167ui_story and not isNil(arg_136_1.actors_["10167ui_story"]) then
					arg_136_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10167ui_story"]) and arg_136_1.var_.characterEffect10167ui_story then
				arg_136_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.7

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(325611033).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 28 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 28)

				if (28 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 28)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325611034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325611034
		arg_140_1.duration_ = 6.97

		local var_140_0 = {
			zh = 5.866,
			ja = 6.966
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325611035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10175ui_story"]) and arg_140_1.var_.characterEffect10175ui_story == nil then
				arg_140_1.var_.characterEffect10175ui_story = arg_140_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10175ui_story"]) then
				if arg_140_1.var_.characterEffect10175ui_story and not isNil(arg_140_1.actors_["10175ui_story"]) then
					arg_140_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10175ui_story"]) and arg_140_1.var_.characterEffect10175ui_story then
				arg_140_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_143_2 = 0
			local var_143_3 = 0.65

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(325611034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 26 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 26)

				if (26 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 26)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611034", "story_v_out_325611.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611034", "story_v_out_325611.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_325611", "325611034", "story_v_out_325611.awb")

						arg_140_1:RecordAudio("325611034", var_143_9)
						arg_140_1:RecordAudio("325611034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325611", "325611034", "story_v_out_325611.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325611", "325611034", "story_v_out_325611.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325611035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325611035
		arg_144_1.duration_ = 10.3

		local var_144_0 = {
			zh = 6.166,
			ja = 10.3
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325611036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10167ui_story"]) and arg_144_1.var_.characterEffect10167ui_story == nil then
				arg_144_1.var_.characterEffect10167ui_story = arg_144_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10167ui_story"]) then
				if arg_144_1.var_.characterEffect10167ui_story and not isNil(arg_144_1.actors_["10167ui_story"]) then
					arg_144_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10167ui_story"]) and arg_144_1.var_.characterEffect10167ui_story then
				arg_144_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_147_2 = arg_144_1.actors_["10175ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect10175ui_story == nil then
				arg_144_1.var_.characterEffect10175ui_story = var_147_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_3 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.characterEffect10175ui_story and not isNil(var_147_2) then
					arg_144_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_144_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_3)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect10175ui_story then
				arg_144_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_144_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_147_4 = 0
			local var_147_5 = 0.675

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(325611035)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 27 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 27)

				if (27 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 27)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611035", "story_v_out_325611.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611035", "story_v_out_325611.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_325611", "325611035", "story_v_out_325611.awb")

						arg_144_1:RecordAudio("325611035", var_147_11)
						arg_144_1:RecordAudio("325611035", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325611", "325611035", "story_v_out_325611.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325611", "325611035", "story_v_out_325611.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325611036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325611036
		arg_148_1.duration_ = 13.53

		local var_148_0 = {
			zh = 11.433,
			ja = 13.533
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325611037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_151_0 = 0
			local var_151_1 = 1.1

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(325611036)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 44 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 44)

				if (44 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 44)) > 0 and var_151_1 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611036", "story_v_out_325611.awb") ~= 0 then
					local var_151_6 = manager.audio:GetVoiceLength("story_v_out_325611", "325611036", "story_v_out_325611.awb") / 1000

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end

					if var_151_2.prefab_name ~= "" and arg_148_1.actors_[var_151_2.prefab_name] ~= nil then
						local var_151_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_2.prefab_name].transform, "story_v_out_325611", "325611036", "story_v_out_325611.awb")

						arg_148_1:RecordAudio("325611036", var_151_7)
						arg_148_1:RecordAudio("325611036", var_151_7)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325611", "325611036", "story_v_out_325611.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325611", "325611036", "story_v_out_325611.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325611037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325611037
		arg_152_1.duration_ = 5.57

		local var_152_0 = {
			zh = 3.8,
			ja = 5.566
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325611038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["10175ui_story"]) and arg_152_1.var_.characterEffect10175ui_story == nil then
				arg_152_1.var_.characterEffect10175ui_story = arg_152_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["10175ui_story"]) then
				if arg_152_1.var_.characterEffect10175ui_story and not isNil(arg_152_1.actors_["10175ui_story"]) then
					arg_152_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["10175ui_story"]) and arg_152_1.var_.characterEffect10175ui_story then
				arg_152_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.actors_["10167ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect10167ui_story == nil then
				arg_152_1.var_.characterEffect10167ui_story = var_155_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_3 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.characterEffect10167ui_story and not isNil(var_155_2) then
					arg_152_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_3)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect10167ui_story then
				arg_152_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action4_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 0.475

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(325611037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 19 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 19)

				if (19 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 19)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611037", "story_v_out_325611.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611037", "story_v_out_325611.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_325611", "325611037", "story_v_out_325611.awb")

						arg_152_1:RecordAudio("325611037", var_155_11)
						arg_152_1:RecordAudio("325611037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325611", "325611037", "story_v_out_325611.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325611", "325611037", "story_v_out_325611.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325611038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325611038
		arg_156_1.duration_ = 8.13

		local var_156_0 = {
			zh = 5.7,
			ja = 8.133
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325611039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10175ui_story = arg_156_1.actors_["10175ui_story"].transform.localPosition

				local var_159_0 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_0 then
					var_159_0:EnableDynamicBone(false)
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_1)
				arg_156_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10175ui_story"].transform.position).z)
				arg_156_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10175ui_story"].transform.localEulerAngles = arg_156_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10175ui_story"].transform.position).z)
				arg_156_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10175ui_story"].transform.localEulerAngles = arg_156_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_159_2 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(true)
				end
			end

			local var_159_3 = arg_156_1.actors_["1071ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1071ui_story = var_159_3.localPosition
			end

			local var_159_4 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				var_159_3.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_156_1.time_ - 0) / var_159_4)
				var_159_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_3.position).x, (manager.ui.mainCamera.transform.position - var_159_3.position).y, (manager.ui.mainCamera.transform.position - var_159_3.position).z)
				var_159_3.localEulerAngles.z = 0
				var_159_3.localEulerAngles.x = 0
				var_159_3.localEulerAngles = var_159_3.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				var_159_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_159_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_3.position).x, (manager.ui.mainCamera.transform.position - var_159_3.position).y, (manager.ui.mainCamera.transform.position - var_159_3.position).z)
				var_159_3.localEulerAngles.z = 0
				var_159_3.localEulerAngles.x = 0
				var_159_3.localEulerAngles = var_159_3.localEulerAngles
			end

			local var_159_5 = arg_156_1.actors_["10167ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10167ui_story = var_159_5.localPosition

				local var_159_6 = GameObjectTools.GetOrAddComponent(var_159_5.gameObject, typeof(DynamicBoneHelper))

				if var_159_6 then
					var_159_6:EnableDynamicBone(false)
				end
			end

			local var_159_7 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				var_159_5.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_7)
				var_159_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_5.position).x, (manager.ui.mainCamera.transform.position - var_159_5.position).y, (manager.ui.mainCamera.transform.position - var_159_5.position).z)
				var_159_5.localEulerAngles.z = 0
				var_159_5.localEulerAngles.x = 0
				var_159_5.localEulerAngles = var_159_5.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				var_159_5.localPosition = Vector3.New(0, 100, 0)
				var_159_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_5.position).x, (manager.ui.mainCamera.transform.position - var_159_5.position).y, (manager.ui.mainCamera.transform.position - var_159_5.position).z)
				var_159_5.localEulerAngles.z = 0
				var_159_5.localEulerAngles.x = 0
				var_159_5.localEulerAngles = var_159_5.localEulerAngles

				local var_159_8 = GameObjectTools.GetOrAddComponent(var_159_5.gameObject, typeof(DynamicBoneHelper))

				if var_159_8 then
					var_159_8:EnableDynamicBone(true)
				end
			end

			local var_159_9 = arg_156_1.actors_["1071ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1071ui_story == nil then
				arg_156_1.var_.characterEffect1071ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_10 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_10 and not isNil(var_159_9) then
				if arg_156_1.var_.characterEffect1071ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_10 and arg_156_1.time_ < 0 + var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1071ui_story then
				arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_159_12 = arg_156_1.actors_["10175ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_12) and arg_156_1.var_.characterEffect10175ui_story == nil then
				arg_156_1.var_.characterEffect10175ui_story = var_159_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_13 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_13 and not isNil(var_159_12) then
				if arg_156_1.var_.characterEffect10175ui_story and not isNil(var_159_12) then
					arg_156_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_13)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_13 and arg_156_1.time_ < 0 + var_159_13 + arg_159_0 and not isNil(var_159_12) and arg_156_1.var_.characterEffect10175ui_story then
				arg_156_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_159_14 = 0
			local var_159_15 = 0.65

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_16 = arg_156_1:GetWordFromCfg(325611038)
				local var_159_17 = arg_156_1:FormatText(var_159_16.content)

				arg_156_1.text_.text = var_159_17

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_19 = 26 <= 0 and var_159_15 or var_159_15 * (utf8.len(var_159_17) / 26)

				if (26 <= 0 and var_159_15 or var_159_15 * (utf8.len(var_159_17) / 26)) > 0 and var_159_15 < var_159_19 then
					arg_156_1.talkMaxDuration = var_159_19

					if var_159_19 + var_159_14 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_14
					end
				end

				arg_156_1.text_.text = var_159_17
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611038", "story_v_out_325611.awb") ~= 0 then
					local var_159_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611038", "story_v_out_325611.awb") / 1000

					if var_159_20 + var_159_14 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_14
					end

					if var_159_16.prefab_name ~= "" and arg_156_1.actors_[var_159_16.prefab_name] ~= nil then
						local var_159_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_16.prefab_name].transform, "story_v_out_325611", "325611038", "story_v_out_325611.awb")

						arg_156_1:RecordAudio("325611038", var_159_21)
						arg_156_1:RecordAudio("325611038", var_159_21)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325611", "325611038", "story_v_out_325611.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325611", "325611038", "story_v_out_325611.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_22 = math.max(var_159_15, arg_156_1.talkMaxDuration)

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_22 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_14) / var_159_22

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_14 + var_159_22 and arg_156_1.time_ < var_159_14 + var_159_22 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play325611039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325611039
		arg_160_1.duration_ = 11.97

		local var_160_0 = {
			zh = 9.533,
			ja = 11.966
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325611040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1071ui_story = arg_160_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1071ui_story"].transform.position).z)
				arg_160_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1071ui_story"].transform.localEulerAngles = arg_160_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_160_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1071ui_story"].transform.position).z)
				arg_160_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1071ui_story"].transform.localEulerAngles = arg_160_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["10167ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10167ui_story = var_163_1.localPosition

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_1.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end
			end

			local var_163_3 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_3 then
				var_163_1.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10167ui_story, Vector3.New(0.7, -1.28, -5.73), (arg_160_1.time_ - 0) / var_163_3)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_3 and arg_160_1.time_ < 0 + var_163_3 + arg_163_0 then
				var_163_1.localPosition = Vector3.New(0.7, -1.28, -5.73)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles

				local var_163_4 = GameObjectTools.GetOrAddComponent(var_163_1.gameObject, typeof(DynamicBoneHelper))

				if var_163_4 then
					var_163_4:EnableDynamicBone(true)
				end
			end

			local var_163_5 = arg_160_1.actors_["10167ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_5) and arg_160_1.var_.characterEffect10167ui_story == nil then
				arg_160_1.var_.characterEffect10167ui_story = var_163_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_6 and not isNil(var_163_5) then
				if arg_160_1.var_.characterEffect10167ui_story and not isNil(var_163_5) then
					arg_160_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_6 and arg_160_1.time_ < 0 + var_163_6 + arg_163_0 and not isNil(var_163_5) and arg_160_1.var_.characterEffect10167ui_story then
				arg_160_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_163_8 = arg_160_1.actors_["1071ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_8) and arg_160_1.var_.characterEffect1071ui_story == nil then
				arg_160_1.var_.characterEffect1071ui_story = var_163_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_9 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_9 and not isNil(var_163_8) then
				if arg_160_1.var_.characterEffect1071ui_story and not isNil(var_163_8) then
					arg_160_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_9)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_9 and arg_160_1.time_ < 0 + var_163_9 + arg_163_0 and not isNil(var_163_8) and arg_160_1.var_.characterEffect1071ui_story then
				arg_160_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_163_10 = 0
			local var_163_11 = 0.975

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_12 = arg_160_1:GetWordFromCfg(325611039)
				local var_163_13 = arg_160_1:FormatText(var_163_12.content)

				arg_160_1.text_.text = var_163_13

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 39 <= 0 and var_163_11 or var_163_11 * (utf8.len(var_163_13) / 39)

				if (39 <= 0 and var_163_11 or var_163_11 * (utf8.len(var_163_13) / 39)) > 0 and var_163_11 < var_163_15 then
					arg_160_1.talkMaxDuration = var_163_15

					if var_163_15 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_10
					end
				end

				arg_160_1.text_.text = var_163_13
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611039", "story_v_out_325611.awb") ~= 0 then
					local var_163_16 = manager.audio:GetVoiceLength("story_v_out_325611", "325611039", "story_v_out_325611.awb") / 1000

					if var_163_16 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_16 + var_163_10
					end

					if var_163_12.prefab_name ~= "" and arg_160_1.actors_[var_163_12.prefab_name] ~= nil then
						local var_163_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_12.prefab_name].transform, "story_v_out_325611", "325611039", "story_v_out_325611.awb")

						arg_160_1:RecordAudio("325611039", var_163_17)
						arg_160_1:RecordAudio("325611039", var_163_17)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325611", "325611039", "story_v_out_325611.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325611", "325611039", "story_v_out_325611.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_18 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_18 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_10) / var_163_18

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_10 + var_163_18 and arg_160_1.time_ < var_163_10 + var_163_18 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play325611040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325611040
		arg_164_1.duration_ = 6.37

		local var_164_0 = {
			zh = 6.366,
			ja = 5.966
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325611041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_2")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_167_0 = 0
			local var_167_1 = 0.625

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_2 = arg_164_1:GetWordFromCfg(325611040)
				local var_167_3 = arg_164_1:FormatText(var_167_2.content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 25 <= 0 and var_167_1 or var_167_1 * (utf8.len(var_167_3) / 25)

				if (25 <= 0 and var_167_1 or var_167_1 * (utf8.len(var_167_3) / 25)) > 0 and var_167_1 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611040", "story_v_out_325611.awb") ~= 0 then
					local var_167_6 = manager.audio:GetVoiceLength("story_v_out_325611", "325611040", "story_v_out_325611.awb") / 1000

					if var_167_6 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_0
					end

					if var_167_2.prefab_name ~= "" and arg_164_1.actors_[var_167_2.prefab_name] ~= nil then
						local var_167_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_2.prefab_name].transform, "story_v_out_325611", "325611040", "story_v_out_325611.awb")

						arg_164_1:RecordAudio("325611040", var_167_7)
						arg_164_1:RecordAudio("325611040", var_167_7)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325611", "325611040", "story_v_out_325611.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325611", "325611040", "story_v_out_325611.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play325611041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325611041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325611042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["10167ui_story"]) and arg_168_1.var_.characterEffect10167ui_story == nil then
				arg_168_1.var_.characterEffect10167ui_story = arg_168_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["10167ui_story"]) then
				if arg_168_1.var_.characterEffect10167ui_story and not isNil(arg_168_1.actors_["10167ui_story"]) then
					arg_168_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["10167ui_story"]) and arg_168_1.var_.characterEffect10167ui_story then
				arg_168_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_171_1 = arg_168_1.actors_["1071ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1071ui_story = var_171_1.localPosition
			end

			local var_171_2 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 then
				var_171_1.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_2)
				var_171_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_1.position).x, (manager.ui.mainCamera.transform.position - var_171_1.position).y, (manager.ui.mainCamera.transform.position - var_171_1.position).z)
				var_171_1.localEulerAngles.z = 0
				var_171_1.localEulerAngles.x = 0
				var_171_1.localEulerAngles = var_171_1.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 then
				var_171_1.localPosition = Vector3.New(0, 100, 0)
				var_171_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_1.position).x, (manager.ui.mainCamera.transform.position - var_171_1.position).y, (manager.ui.mainCamera.transform.position - var_171_1.position).z)
				var_171_1.localEulerAngles.z = 0
				var_171_1.localEulerAngles.x = 0
				var_171_1.localEulerAngles = var_171_1.localEulerAngles
			end

			local var_171_3 = arg_168_1.actors_["10167ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10167ui_story = var_171_3.localPosition

				local var_171_4 = GameObjectTools.GetOrAddComponent(var_171_3.gameObject, typeof(DynamicBoneHelper))

				if var_171_4 then
					var_171_4:EnableDynamicBone(false)
				end
			end

			local var_171_5 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				var_171_3.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_5)
				var_171_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_3.position).x, (manager.ui.mainCamera.transform.position - var_171_3.position).y, (manager.ui.mainCamera.transform.position - var_171_3.position).z)
				var_171_3.localEulerAngles.z = 0
				var_171_3.localEulerAngles.x = 0
				var_171_3.localEulerAngles = var_171_3.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				var_171_3.localPosition = Vector3.New(0, 100, 0)
				var_171_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_3.position).x, (manager.ui.mainCamera.transform.position - var_171_3.position).y, (manager.ui.mainCamera.transform.position - var_171_3.position).z)
				var_171_3.localEulerAngles.z = 0
				var_171_3.localEulerAngles.x = 0
				var_171_3.localEulerAngles = var_171_3.localEulerAngles

				local var_171_6 = GameObjectTools.GetOrAddComponent(var_171_3.gameObject, typeof(DynamicBoneHelper))

				if var_171_6 then
					var_171_6:EnableDynamicBone(true)
				end
			end

			local var_171_7 = 0
			local var_171_8 = 1.025

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_9 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(325611041).content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 41 <= 0 and var_171_8 or var_171_8 * (utf8.len(var_171_9) / 41)

				if (41 <= 0 and var_171_8 or var_171_8 * (utf8.len(var_171_9) / 41)) > 0 and var_171_8 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_7 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_7
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_8, arg_168_1.talkMaxDuration)

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_7) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_7 + var_171_12 and arg_168_1.time_ < var_171_7 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play325611042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325611042
		arg_172_1.duration_ = 5.33

		local var_172_0 = {
			zh = 5.333,
			ja = 3.233
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325611043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10167ui_story"]) and arg_172_1.var_.characterEffect10167ui_story == nil then
				arg_172_1.var_.characterEffect10167ui_story = arg_172_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10167ui_story"]) then
				if arg_172_1.var_.characterEffect10167ui_story and not isNil(arg_172_1.actors_["10167ui_story"]) then
					arg_172_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10167ui_story"]) and arg_172_1.var_.characterEffect10167ui_story then
				arg_172_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_175_2 = arg_172_1.actors_["10167ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos10167ui_story = var_175_2.localPosition

				local var_175_3 = GameObjectTools.GetOrAddComponent(var_175_2.gameObject, typeof(DynamicBoneHelper))

				if var_175_3 then
					var_175_3:EnableDynamicBone(false)
				end
			end

			local var_175_4 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				var_175_2.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10167ui_story, Vector3.New(0, -1.28, -5.73), (arg_172_1.time_ - 0) / var_175_4)
				var_175_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_2.position).x, (manager.ui.mainCamera.transform.position - var_175_2.position).y, (manager.ui.mainCamera.transform.position - var_175_2.position).z)
				var_175_2.localEulerAngles.z = 0
				var_175_2.localEulerAngles.x = 0
				var_175_2.localEulerAngles = var_175_2.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				var_175_2.localPosition = Vector3.New(0, -1.28, -5.73)
				var_175_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_2.position).x, (manager.ui.mainCamera.transform.position - var_175_2.position).y, (manager.ui.mainCamera.transform.position - var_175_2.position).z)
				var_175_2.localEulerAngles.z = 0
				var_175_2.localEulerAngles.x = 0
				var_175_2.localEulerAngles = var_175_2.localEulerAngles

				local var_175_5 = GameObjectTools.GetOrAddComponent(var_175_2.gameObject, typeof(DynamicBoneHelper))

				if var_175_5 then
					var_175_5:EnableDynamicBone(true)
				end
			end

			local var_175_6 = 0
			local var_175_7 = 0.575

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(325611042)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 23 <= 0 and var_175_7 or var_175_7 * (utf8.len(var_175_9) / 23)

				if (23 <= 0 and var_175_7 or var_175_7 * (utf8.len(var_175_9) / 23)) > 0 and var_175_7 < var_175_11 then
					arg_172_1.talkMaxDuration = var_175_11

					if var_175_11 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_9
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611042", "story_v_out_325611.awb") ~= 0 then
					local var_175_12 = manager.audio:GetVoiceLength("story_v_out_325611", "325611042", "story_v_out_325611.awb") / 1000

					if var_175_12 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_6
					end

					if var_175_8.prefab_name ~= "" and arg_172_1.actors_[var_175_8.prefab_name] ~= nil then
						local var_175_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_8.prefab_name].transform, "story_v_out_325611", "325611042", "story_v_out_325611.awb")

						arg_172_1:RecordAudio("325611042", var_175_13)
						arg_172_1:RecordAudio("325611042", var_175_13)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_325611", "325611042", "story_v_out_325611.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_325611", "325611042", "story_v_out_325611.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play325611043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325611043
		arg_176_1.duration_ = 9.73

		local var_176_0 = {
			zh = 6.5,
			ja = 9.733
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325611044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10167ui_story = arg_176_1.actors_["10167ui_story"].transform.localPosition

				local var_179_0 = GameObjectTools.GetOrAddComponent(arg_176_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_179_0 then
					var_179_0:EnableDynamicBone(false)
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_1)
				arg_176_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10167ui_story"].transform.position).z)
				arg_176_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10167ui_story"].transform.localEulerAngles = arg_176_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_176_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10167ui_story"].transform.position).z)
				arg_176_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10167ui_story"].transform.localEulerAngles = arg_176_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_179_2 = GameObjectTools.GetOrAddComponent(arg_176_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(true)
				end
			end

			local var_179_3 = arg_176_1.actors_["10175ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10175ui_story = var_179_3.localPosition

				local var_179_4 = GameObjectTools.GetOrAddComponent(var_179_3.gameObject, typeof(DynamicBoneHelper))

				if var_179_4 then
					var_179_4:EnableDynamicBone(false)
				end
			end

			local var_179_5 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_5 then
				var_179_3.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_176_1.time_ - 0) / var_179_5)
				var_179_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_3.position).x, (manager.ui.mainCamera.transform.position - var_179_3.position).y, (manager.ui.mainCamera.transform.position - var_179_3.position).z)
				var_179_3.localEulerAngles.z = 0
				var_179_3.localEulerAngles.x = 0
				var_179_3.localEulerAngles = var_179_3.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_5 and arg_176_1.time_ < 0 + var_179_5 + arg_179_0 then
				var_179_3.localPosition = Vector3.New(0, -1, -6.05)
				var_179_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_3.position).x, (manager.ui.mainCamera.transform.position - var_179_3.position).y, (manager.ui.mainCamera.transform.position - var_179_3.position).z)
				var_179_3.localEulerAngles.z = 0
				var_179_3.localEulerAngles.x = 0
				var_179_3.localEulerAngles = var_179_3.localEulerAngles

				local var_179_6 = GameObjectTools.GetOrAddComponent(var_179_3.gameObject, typeof(DynamicBoneHelper))

				if var_179_6 then
					var_179_6:EnableDynamicBone(true)
				end
			end

			local var_179_7 = arg_176_1.actors_["1071ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1071ui_story = var_179_7.localPosition
			end

			local var_179_8 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_8 then
				var_179_7.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_8)
				var_179_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_7.position).x, (manager.ui.mainCamera.transform.position - var_179_7.position).y, (manager.ui.mainCamera.transform.position - var_179_7.position).z)
				var_179_7.localEulerAngles.z = 0
				var_179_7.localEulerAngles.x = 0
				var_179_7.localEulerAngles = var_179_7.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_8 and arg_176_1.time_ < 0 + var_179_8 + arg_179_0 then
				var_179_7.localPosition = Vector3.New(0, 100, 0)
				var_179_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_7.position).x, (manager.ui.mainCamera.transform.position - var_179_7.position).y, (manager.ui.mainCamera.transform.position - var_179_7.position).z)
				var_179_7.localEulerAngles.z = 0
				var_179_7.localEulerAngles.x = 0
				var_179_7.localEulerAngles = var_179_7.localEulerAngles
			end

			local var_179_9 = arg_176_1.actors_["10175ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect10175ui_story == nil then
				arg_176_1.var_.characterEffect10175ui_story = var_179_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_10 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_10 and not isNil(var_179_9) then
				if arg_176_1.var_.characterEffect10175ui_story and not isNil(var_179_9) then
					arg_176_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_10 and arg_176_1.time_ < 0 + var_179_10 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect10175ui_story then
				arg_176_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_179_12 = arg_176_1.actors_["10167ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_12) and arg_176_1.var_.characterEffect10167ui_story == nil then
				arg_176_1.var_.characterEffect10167ui_story = var_179_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_13 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_13 and not isNil(var_179_12) then
				if arg_176_1.var_.characterEffect10167ui_story and not isNil(var_179_12) then
					arg_176_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_13)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_13 and arg_176_1.time_ < 0 + var_179_13 + arg_179_0 and not isNil(var_179_12) and arg_176_1.var_.characterEffect10167ui_story then
				arg_176_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_179_14 = 0
			local var_179_15 = 0.875

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_16 = arg_176_1:GetWordFromCfg(325611043)
				local var_179_17 = arg_176_1:FormatText(var_179_16.content)

				arg_176_1.text_.text = var_179_17

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_19 = 35 <= 0 and var_179_15 or var_179_15 * (utf8.len(var_179_17) / 35)

				if (35 <= 0 and var_179_15 or var_179_15 * (utf8.len(var_179_17) / 35)) > 0 and var_179_15 < var_179_19 then
					arg_176_1.talkMaxDuration = var_179_19

					if var_179_19 + var_179_14 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_19 + var_179_14
					end
				end

				arg_176_1.text_.text = var_179_17
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611043", "story_v_out_325611.awb") ~= 0 then
					local var_179_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611043", "story_v_out_325611.awb") / 1000

					if var_179_20 + var_179_14 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_20 + var_179_14
					end

					if var_179_16.prefab_name ~= "" and arg_176_1.actors_[var_179_16.prefab_name] ~= nil then
						local var_179_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_16.prefab_name].transform, "story_v_out_325611", "325611043", "story_v_out_325611.awb")

						arg_176_1:RecordAudio("325611043", var_179_21)
						arg_176_1:RecordAudio("325611043", var_179_21)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325611", "325611043", "story_v_out_325611.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325611", "325611043", "story_v_out_325611.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_22 = math.max(var_179_15, arg_176_1.talkMaxDuration)

			if var_179_14 <= arg_176_1.time_ and arg_176_1.time_ < var_179_14 + var_179_22 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_14) / var_179_22

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_14 + var_179_22 and arg_176_1.time_ < var_179_14 + var_179_22 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play325611044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325611044
		arg_180_1.duration_ = 6.6

		local var_180_0 = {
			zh = 6.6,
			ja = 5.833
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325611045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10175ui_story = arg_180_1.actors_["10175ui_story"].transform.localPosition

				local var_183_0 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_0 then
					var_183_0:EnableDynamicBone(false)
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_180_1.time_ - 0) / var_183_1)
				arg_180_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10175ui_story"].transform.position).z)
				arg_180_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10175ui_story"].transform.localEulerAngles = arg_180_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_180_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10175ui_story"].transform.position).z)
				arg_180_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10175ui_story"].transform.localEulerAngles = arg_180_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_183_2 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(true)
				end
			end

			local var_183_3 = arg_180_1.actors_["6148ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos6148ui_story = var_183_3.localPosition

				local var_183_4 = GameObjectTools.GetOrAddComponent(var_183_3.gameObject, typeof(DynamicBoneHelper))

				if var_183_4 then
					var_183_4:EnableDynamicBone(false)
				end
			end

			local var_183_5 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_5 then
				var_183_3.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_180_1.time_ - 0) / var_183_5)
				var_183_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_3.position).x, (manager.ui.mainCamera.transform.position - var_183_3.position).y, (manager.ui.mainCamera.transform.position - var_183_3.position).z)
				var_183_3.localEulerAngles.z = 0
				var_183_3.localEulerAngles.x = 0
				var_183_3.localEulerAngles = var_183_3.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_5 and arg_180_1.time_ < 0 + var_183_5 + arg_183_0 then
				var_183_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_183_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_3.position).x, (manager.ui.mainCamera.transform.position - var_183_3.position).y, (manager.ui.mainCamera.transform.position - var_183_3.position).z)
				var_183_3.localEulerAngles.z = 0
				var_183_3.localEulerAngles.x = 0
				var_183_3.localEulerAngles = var_183_3.localEulerAngles

				local var_183_6 = GameObjectTools.GetOrAddComponent(var_183_3.gameObject, typeof(DynamicBoneHelper))

				if var_183_6 then
					var_183_6:EnableDynamicBone(true)
				end
			end

			local var_183_7 = arg_180_1.actors_["6148ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_7) and arg_180_1.var_.characterEffect6148ui_story == nil then
				arg_180_1.var_.characterEffect6148ui_story = var_183_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_8 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_8 and not isNil(var_183_7) then
				if arg_180_1.var_.characterEffect6148ui_story and not isNil(var_183_7) then
					arg_180_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_8 and arg_180_1.time_ < 0 + var_183_8 + arg_183_0 and not isNil(var_183_7) and arg_180_1.var_.characterEffect6148ui_story then
				arg_180_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_183_10 = arg_180_1.actors_["10175ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_10) and arg_180_1.var_.characterEffect10175ui_story == nil then
				arg_180_1.var_.characterEffect10175ui_story = var_183_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_11 and not isNil(var_183_10) then
				if arg_180_1.var_.characterEffect10175ui_story and not isNil(var_183_10) then
					arg_180_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_11)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_11 and arg_180_1.time_ < 0 + var_183_11 + arg_183_0 and not isNil(var_183_10) and arg_180_1.var_.characterEffect10175ui_story then
				arg_180_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_183_12 = 0
			local var_183_13 = 0.625

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_14 = arg_180_1:GetWordFromCfg(325611044)
				local var_183_15 = arg_180_1:FormatText(var_183_14.content)

				arg_180_1.text_.text = var_183_15

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_17 = 25 <= 0 and var_183_13 or var_183_13 * (utf8.len(var_183_15) / 25)

				if (25 <= 0 and var_183_13 or var_183_13 * (utf8.len(var_183_15) / 25)) > 0 and var_183_13 < var_183_17 then
					arg_180_1.talkMaxDuration = var_183_17

					if var_183_17 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_17 + var_183_12
					end
				end

				arg_180_1.text_.text = var_183_15
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611044", "story_v_out_325611.awb") ~= 0 then
					local var_183_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611044", "story_v_out_325611.awb") / 1000

					if var_183_18 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_18 + var_183_12
					end

					if var_183_14.prefab_name ~= "" and arg_180_1.actors_[var_183_14.prefab_name] ~= nil then
						local var_183_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_14.prefab_name].transform, "story_v_out_325611", "325611044", "story_v_out_325611.awb")

						arg_180_1:RecordAudio("325611044", var_183_19)
						arg_180_1:RecordAudio("325611044", var_183_19)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325611", "325611044", "story_v_out_325611.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325611", "325611044", "story_v_out_325611.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_20 = math.max(var_183_13, arg_180_1.talkMaxDuration)

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_20 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_12) / var_183_20

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_12 + var_183_20 and arg_180_1.time_ < var_183_12 + var_183_20 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play325611045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325611045
		arg_184_1.duration_ = 3.1

		local var_184_0 = {
			zh = 2.733,
			ja = 3.1
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325611046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10175ui_story"]) and arg_184_1.var_.characterEffect10175ui_story == nil then
				arg_184_1.var_.characterEffect10175ui_story = arg_184_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10175ui_story"]) then
				if arg_184_1.var_.characterEffect10175ui_story and not isNil(arg_184_1.actors_["10175ui_story"]) then
					arg_184_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10175ui_story"]) and arg_184_1.var_.characterEffect10175ui_story then
				arg_184_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_187_2 = arg_184_1.actors_["6148ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect6148ui_story == nil then
				arg_184_1.var_.characterEffect6148ui_story = var_187_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_3 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.characterEffect6148ui_story and not isNil(var_187_2) then
					arg_184_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_184_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_3)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect6148ui_story then
				arg_184_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_184_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_187_4 = 0
			local var_187_5 = 0.3

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(325611045)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 12 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 12)

				if (12 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 12)) > 0 and var_187_5 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611045", "story_v_out_325611.awb") ~= 0 then
					local var_187_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611045", "story_v_out_325611.awb") / 1000

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end

					if var_187_6.prefab_name ~= "" and arg_184_1.actors_[var_187_6.prefab_name] ~= nil then
						local var_187_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_6.prefab_name].transform, "story_v_out_325611", "325611045", "story_v_out_325611.awb")

						arg_184_1:RecordAudio("325611045", var_187_11)
						arg_184_1:RecordAudio("325611045", var_187_11)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325611", "325611045", "story_v_out_325611.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325611", "325611045", "story_v_out_325611.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_12 and arg_184_1.time_ < var_187_4 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play325611046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325611046
		arg_188_1.duration_ = 5.63

		local var_188_0 = {
			zh = 5.633,
			ja = 5.533
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325611047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos6148ui_story = arg_188_1.actors_["6148ui_story"].transform.localPosition

				local var_191_0 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_0 then
					var_191_0:EnableDynamicBone(false)
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 0) / var_191_1)
				arg_188_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["6148ui_story"].transform.position).z)
				arg_188_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["6148ui_story"].transform.localEulerAngles = arg_188_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["6148ui_story"].transform.position).z)
				arg_188_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["6148ui_story"].transform.localEulerAngles = arg_188_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_191_2 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(true)
				end
			end

			local var_191_3 = arg_188_1.actors_["1054ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1054ui_story = var_191_3.localPosition

				local var_191_4 = GameObjectTools.GetOrAddComponent(var_191_3.gameObject, typeof(DynamicBoneHelper))

				if var_191_4 then
					var_191_4:EnableDynamicBone(false)
				end
			end

			local var_191_5 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_5 then
				var_191_3.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_188_1.time_ - 0) / var_191_5)
				var_191_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_3.position).x, (manager.ui.mainCamera.transform.position - var_191_3.position).y, (manager.ui.mainCamera.transform.position - var_191_3.position).z)
				var_191_3.localEulerAngles.z = 0
				var_191_3.localEulerAngles.x = 0
				var_191_3.localEulerAngles = var_191_3.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_5 and arg_188_1.time_ < 0 + var_191_5 + arg_191_0 then
				var_191_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_191_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_3.position).x, (manager.ui.mainCamera.transform.position - var_191_3.position).y, (manager.ui.mainCamera.transform.position - var_191_3.position).z)
				var_191_3.localEulerAngles.z = 0
				var_191_3.localEulerAngles.x = 0
				var_191_3.localEulerAngles = var_191_3.localEulerAngles

				local var_191_6 = GameObjectTools.GetOrAddComponent(var_191_3.gameObject, typeof(DynamicBoneHelper))

				if var_191_6 then
					var_191_6:EnableDynamicBone(true)
				end
			end

			local var_191_7 = arg_188_1.actors_["1054ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_7) and arg_188_1.var_.characterEffect1054ui_story == nil then
				arg_188_1.var_.characterEffect1054ui_story = var_191_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_8 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_8 and not isNil(var_191_7) then
				if arg_188_1.var_.characterEffect1054ui_story and not isNil(var_191_7) then
					arg_188_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_8 and arg_188_1.time_ < 0 + var_191_8 + arg_191_0 and not isNil(var_191_7) and arg_188_1.var_.characterEffect1054ui_story then
				arg_188_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_191_10 = arg_188_1.actors_["10175ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_10) and arg_188_1.var_.characterEffect10175ui_story == nil then
				arg_188_1.var_.characterEffect10175ui_story = var_191_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_11 and not isNil(var_191_10) then
				if arg_188_1.var_.characterEffect10175ui_story and not isNil(var_191_10) then
					arg_188_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_11)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_11 and arg_188_1.time_ < 0 + var_191_11 + arg_191_0 and not isNil(var_191_10) and arg_188_1.var_.characterEffect10175ui_story then
				arg_188_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_191_12 = 0
			local var_191_13 = 0.425

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_14 = arg_188_1:GetWordFromCfg(325611046)
				local var_191_15 = arg_188_1:FormatText(var_191_14.content)

				arg_188_1.text_.text = var_191_15

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_17 = 17 <= 0 and var_191_13 or var_191_13 * (utf8.len(var_191_15) / 17)

				if (17 <= 0 and var_191_13 or var_191_13 * (utf8.len(var_191_15) / 17)) > 0 and var_191_13 < var_191_17 then
					arg_188_1.talkMaxDuration = var_191_17

					if var_191_17 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_12
					end
				end

				arg_188_1.text_.text = var_191_15
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611046", "story_v_out_325611.awb") ~= 0 then
					local var_191_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611046", "story_v_out_325611.awb") / 1000

					if var_191_18 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_12
					end

					if var_191_14.prefab_name ~= "" and arg_188_1.actors_[var_191_14.prefab_name] ~= nil then
						local var_191_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_14.prefab_name].transform, "story_v_out_325611", "325611046", "story_v_out_325611.awb")

						arg_188_1:RecordAudio("325611046", var_191_19)
						arg_188_1:RecordAudio("325611046", var_191_19)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325611", "325611046", "story_v_out_325611.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325611", "325611046", "story_v_out_325611.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_20 = math.max(var_191_13, arg_188_1.talkMaxDuration)

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_20 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_12) / var_191_20

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_12 + var_191_20 and arg_188_1.time_ < var_191_12 + var_191_20 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play325611047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325611047
		arg_192_1.duration_ = 5.53

		local var_192_0 = {
			zh = 4.4,
			ja = 5.533
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325611048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["10175ui_story"]) and arg_192_1.var_.characterEffect10175ui_story == nil then
				arg_192_1.var_.characterEffect10175ui_story = arg_192_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["10175ui_story"]) then
				if arg_192_1.var_.characterEffect10175ui_story and not isNil(arg_192_1.actors_["10175ui_story"]) then
					arg_192_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["10175ui_story"]) and arg_192_1.var_.characterEffect10175ui_story then
				arg_192_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["1054ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1054ui_story == nil then
				arg_192_1.var_.characterEffect1054ui_story = var_195_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_3 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.characterEffect1054ui_story and not isNil(var_195_2) then
					arg_192_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_3)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1054ui_story then
				arg_192_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_195_4 = 0
			local var_195_5 = 0.325

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(325611047)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 13 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 13)

				if (13 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 13)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611047", "story_v_out_325611.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611047", "story_v_out_325611.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_325611", "325611047", "story_v_out_325611.awb")

						arg_192_1:RecordAudio("325611047", var_195_11)
						arg_192_1:RecordAudio("325611047", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325611", "325611047", "story_v_out_325611.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325611", "325611047", "story_v_out_325611.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_12 and arg_192_1.time_ < var_195_4 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325611048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325611048
		arg_196_1.duration_ = 7.87

		local var_196_0 = {
			zh = 5.7,
			ja = 7.866
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325611049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_199_0 = 0
			local var_199_1 = 0.725

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_2 = arg_196_1:GetWordFromCfg(325611048)
				local var_199_3 = arg_196_1:FormatText(var_199_2.content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 29 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_3) / 29)

				if (29 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_3) / 29)) > 0 and var_199_1 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611048", "story_v_out_325611.awb") ~= 0 then
					local var_199_6 = manager.audio:GetVoiceLength("story_v_out_325611", "325611048", "story_v_out_325611.awb") / 1000

					if var_199_6 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_0
					end

					if var_199_2.prefab_name ~= "" and arg_196_1.actors_[var_199_2.prefab_name] ~= nil then
						local var_199_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_2.prefab_name].transform, "story_v_out_325611", "325611048", "story_v_out_325611.awb")

						arg_196_1:RecordAudio("325611048", var_199_7)
						arg_196_1:RecordAudio("325611048", var_199_7)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325611", "325611048", "story_v_out_325611.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325611", "325611048", "story_v_out_325611.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_8 and arg_196_1.time_ < var_199_0 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play325611049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325611049
		arg_200_1.duration_ = 4.37

		local var_200_0 = {
			zh = 3.333,
			ja = 4.366
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325611050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = arg_200_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) then
				if arg_200_1.var_.characterEffect1054ui_story and not isNil(arg_200_1.actors_["1054ui_story"]) then
					arg_200_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) and arg_200_1.var_.characterEffect1054ui_story then
				arg_200_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_203_2 = arg_200_1.actors_["10175ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect10175ui_story == nil then
				arg_200_1.var_.characterEffect10175ui_story = var_203_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_3 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.characterEffect10175ui_story and not isNil(var_203_2) then
					arg_200_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_3)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect10175ui_story then
				arg_200_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_203_4 = 0
			local var_203_5 = 0.225

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(325611049)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 9 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 9)

				if (9 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 9)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611049", "story_v_out_325611.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_325611", "325611049", "story_v_out_325611.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_out_325611", "325611049", "story_v_out_325611.awb")

						arg_200_1:RecordAudio("325611049", var_203_11)
						arg_200_1:RecordAudio("325611049", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325611", "325611049", "story_v_out_325611.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325611", "325611049", "story_v_out_325611.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325611050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325611050
		arg_204_1.duration_ = 4.83

		local var_204_0 = {
			zh = 4.833,
			ja = 3
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325611051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1054ui_story = arg_204_1.actors_["1054ui_story"].transform.localPosition

				local var_207_0 = GameObjectTools.GetOrAddComponent(arg_204_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_207_0 then
					var_207_0:EnableDynamicBone(false)
				end
			end

			local var_207_1 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_1 then
				arg_204_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_1)
				arg_204_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1054ui_story"].transform.position).z)
				arg_204_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1054ui_story"].transform.localEulerAngles = arg_204_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_1 and arg_204_1.time_ < 0 + var_207_1 + arg_207_0 then
				arg_204_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1054ui_story"].transform.position).z)
				arg_204_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1054ui_story"].transform.localEulerAngles = arg_204_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_207_2 = GameObjectTools.GetOrAddComponent(arg_204_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(true)
				end
			end

			local var_207_3 = arg_204_1.actors_["6148ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos6148ui_story = var_207_3.localPosition

				local var_207_4 = GameObjectTools.GetOrAddComponent(var_207_3.gameObject, typeof(DynamicBoneHelper))

				if var_207_4 then
					var_207_4:EnableDynamicBone(false)
				end
			end

			local var_207_5 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_5 then
				var_207_3.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_204_1.time_ - 0) / var_207_5)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_5 and arg_204_1.time_ < 0 + var_207_5 + arg_207_0 then
				var_207_3.localPosition = Vector3.New(0, -0.985, -6)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles

				local var_207_6 = GameObjectTools.GetOrAddComponent(var_207_3.gameObject, typeof(DynamicBoneHelper))

				if var_207_6 then
					var_207_6:EnableDynamicBone(true)
				end
			end

			local var_207_7 = arg_204_1.actors_["10175ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10175ui_story = var_207_7.localPosition

				local var_207_8 = GameObjectTools.GetOrAddComponent(var_207_7.gameObject, typeof(DynamicBoneHelper))

				if var_207_8 then
					var_207_8:EnableDynamicBone(false)
				end
			end

			local var_207_9 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_9 then
				var_207_7.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_9)
				var_207_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_7.position).x, (manager.ui.mainCamera.transform.position - var_207_7.position).y, (manager.ui.mainCamera.transform.position - var_207_7.position).z)
				var_207_7.localEulerAngles.z = 0
				var_207_7.localEulerAngles.x = 0
				var_207_7.localEulerAngles = var_207_7.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_9 and arg_204_1.time_ < 0 + var_207_9 + arg_207_0 then
				var_207_7.localPosition = Vector3.New(0, 100, 0)
				var_207_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_7.position).x, (manager.ui.mainCamera.transform.position - var_207_7.position).y, (manager.ui.mainCamera.transform.position - var_207_7.position).z)
				var_207_7.localEulerAngles.z = 0
				var_207_7.localEulerAngles.x = 0
				var_207_7.localEulerAngles = var_207_7.localEulerAngles

				local var_207_10 = GameObjectTools.GetOrAddComponent(var_207_7.gameObject, typeof(DynamicBoneHelper))

				if var_207_10 then
					var_207_10:EnableDynamicBone(true)
				end
			end

			local var_207_11 = arg_204_1.actors_["6148ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_11) and arg_204_1.var_.characterEffect6148ui_story == nil then
				arg_204_1.var_.characterEffect6148ui_story = var_207_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_12 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_12 and not isNil(var_207_11) then
				if arg_204_1.var_.characterEffect6148ui_story and not isNil(var_207_11) then
					arg_204_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_12 and arg_204_1.time_ < 0 + var_207_12 + arg_207_0 and not isNil(var_207_11) and arg_204_1.var_.characterEffect6148ui_story then
				arg_204_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_207_14 = arg_204_1.actors_["1054ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.characterEffect1054ui_story == nil then
				arg_204_1.var_.characterEffect1054ui_story = var_207_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_15 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_15 and not isNil(var_207_14) then
				if arg_204_1.var_.characterEffect1054ui_story and not isNil(var_207_14) then
					arg_204_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_15)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_15 and arg_204_1.time_ < 0 + var_207_15 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.characterEffect1054ui_story then
				arg_204_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_207_16 = 0
			local var_207_17 = 0.55

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_18 = arg_204_1:GetWordFromCfg(325611050)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_21 = 22 <= 0 and var_207_17 or var_207_17 * (utf8.len(var_207_19) / 22)

				if (22 <= 0 and var_207_17 or var_207_17 * (utf8.len(var_207_19) / 22)) > 0 and var_207_17 < var_207_21 then
					arg_204_1.talkMaxDuration = var_207_21

					if var_207_21 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_21 + var_207_16
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611050", "story_v_out_325611.awb") ~= 0 then
					local var_207_22 = manager.audio:GetVoiceLength("story_v_out_325611", "325611050", "story_v_out_325611.awb") / 1000

					if var_207_22 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_16
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_out_325611", "325611050", "story_v_out_325611.awb")

						arg_204_1:RecordAudio("325611050", var_207_23)
						arg_204_1:RecordAudio("325611050", var_207_23)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325611", "325611050", "story_v_out_325611.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325611", "325611050", "story_v_out_325611.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_24 = math.max(var_207_17, arg_204_1.talkMaxDuration)

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_24 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_16) / var_207_24

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_16 + var_207_24 and arg_204_1.time_ < var_207_16 + var_207_24 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play325611051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325611051
		arg_208_1.duration_ = 10.37

		local var_208_0 = {
			zh = 7.3,
			ja = 10.366
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325611052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos6148ui_story = arg_208_1.actors_["6148ui_story"].transform.localPosition

				local var_211_0 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_211_0 then
					var_211_0:EnableDynamicBone(false)
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_208_1.time_ - 0) / var_211_1)
				arg_208_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["6148ui_story"].transform.position).z)
				arg_208_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["6148ui_story"].transform.localEulerAngles = arg_208_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_208_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["6148ui_story"].transform.position).z)
				arg_208_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["6148ui_story"].transform.localEulerAngles = arg_208_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_211_2 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(true)
				end
			end

			local var_211_3 = arg_208_1.actors_["1170ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1170ui_story = var_211_3.localPosition

				local var_211_4 = GameObjectTools.GetOrAddComponent(var_211_3.gameObject, typeof(DynamicBoneHelper))

				if var_211_4 then
					var_211_4:EnableDynamicBone(false)
				end
			end

			local var_211_5 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_5 then
				var_211_3.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1170ui_story, Vector3.New(0.74, -0.95, -6.08), (arg_208_1.time_ - 0) / var_211_5)
				var_211_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_3.position).x, (manager.ui.mainCamera.transform.position - var_211_3.position).y, (manager.ui.mainCamera.transform.position - var_211_3.position).z)
				var_211_3.localEulerAngles.z = 0
				var_211_3.localEulerAngles.x = 0
				var_211_3.localEulerAngles = var_211_3.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_5 and arg_208_1.time_ < 0 + var_211_5 + arg_211_0 then
				var_211_3.localPosition = Vector3.New(0.74, -0.95, -6.08)
				var_211_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_3.position).x, (manager.ui.mainCamera.transform.position - var_211_3.position).y, (manager.ui.mainCamera.transform.position - var_211_3.position).z)
				var_211_3.localEulerAngles.z = 0
				var_211_3.localEulerAngles.x = 0
				var_211_3.localEulerAngles = var_211_3.localEulerAngles

				local var_211_6 = GameObjectTools.GetOrAddComponent(var_211_3.gameObject, typeof(DynamicBoneHelper))

				if var_211_6 then
					var_211_6:EnableDynamicBone(true)
				end
			end

			local var_211_7 = arg_208_1.actors_["1170ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_7) and arg_208_1.var_.characterEffect1170ui_story == nil then
				arg_208_1.var_.characterEffect1170ui_story = var_211_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_8 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_8 and not isNil(var_211_7) then
				if arg_208_1.var_.characterEffect1170ui_story and not isNil(var_211_7) then
					arg_208_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_8 and arg_208_1.time_ < 0 + var_211_8 + arg_211_0 and not isNil(var_211_7) and arg_208_1.var_.characterEffect1170ui_story then
				arg_208_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_211_10 = arg_208_1.actors_["6148ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_10) and arg_208_1.var_.characterEffect6148ui_story == nil then
				arg_208_1.var_.characterEffect6148ui_story = var_211_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_11 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_11 and not isNil(var_211_10) then
				if arg_208_1.var_.characterEffect6148ui_story and not isNil(var_211_10) then
					arg_208_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_208_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_11)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_11 and arg_208_1.time_ < 0 + var_211_11 + arg_211_0 and not isNil(var_211_10) and arg_208_1.var_.characterEffect6148ui_story then
				arg_208_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_208_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_211_12 = 0
			local var_211_13 = 0.825

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_14 = arg_208_1:GetWordFromCfg(325611051)
				local var_211_15 = arg_208_1:FormatText(var_211_14.content)

				arg_208_1.text_.text = var_211_15

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_17 = 33 <= 0 and var_211_13 or var_211_13 * (utf8.len(var_211_15) / 33)

				if (33 <= 0 and var_211_13 or var_211_13 * (utf8.len(var_211_15) / 33)) > 0 and var_211_13 < var_211_17 then
					arg_208_1.talkMaxDuration = var_211_17

					if var_211_17 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_12
					end
				end

				arg_208_1.text_.text = var_211_15
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611051", "story_v_out_325611.awb") ~= 0 then
					local var_211_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611051", "story_v_out_325611.awb") / 1000

					if var_211_18 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_18 + var_211_12
					end

					if var_211_14.prefab_name ~= "" and arg_208_1.actors_[var_211_14.prefab_name] ~= nil then
						local var_211_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_14.prefab_name].transform, "story_v_out_325611", "325611051", "story_v_out_325611.awb")

						arg_208_1:RecordAudio("325611051", var_211_19)
						arg_208_1:RecordAudio("325611051", var_211_19)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325611", "325611051", "story_v_out_325611.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325611", "325611051", "story_v_out_325611.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_20 = math.max(var_211_13, arg_208_1.talkMaxDuration)

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_20 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_12) / var_211_20

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_12 + var_211_20 and arg_208_1.time_ < var_211_12 + var_211_20 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play325611052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325611052
		arg_212_1.duration_ = 1

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325611053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos6148ui_story = arg_212_1.actors_["6148ui_story"].transform.localPosition

				local var_215_0 = GameObjectTools.GetOrAddComponent(arg_212_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_215_0 then
					var_215_0:EnableDynamicBone(false)
				end
			end

			local var_215_1 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_1)
				arg_212_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["6148ui_story"].transform.position).z)
				arg_212_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["6148ui_story"].transform.localEulerAngles = arg_212_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["6148ui_story"].transform.position).z)
				arg_212_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["6148ui_story"].transform.localEulerAngles = arg_212_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_215_2 = GameObjectTools.GetOrAddComponent(arg_212_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(true)
				end
			end

			local var_215_3 = arg_212_1.actors_["1071ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1071ui_story = var_215_3.localPosition
			end

			local var_215_4 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				var_215_3.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_212_1.time_ - 0) / var_215_4)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				var_215_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			local var_215_5 = arg_212_1.actors_["1170ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1170ui_story = var_215_5.localPosition

				local var_215_6 = GameObjectTools.GetOrAddComponent(var_215_5.gameObject, typeof(DynamicBoneHelper))

				if var_215_6 then
					var_215_6:EnableDynamicBone(false)
				end
			end

			local var_215_7 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				var_215_5.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_7)
				var_215_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_5.position).x, (manager.ui.mainCamera.transform.position - var_215_5.position).y, (manager.ui.mainCamera.transform.position - var_215_5.position).z)
				var_215_5.localEulerAngles.z = 0
				var_215_5.localEulerAngles.x = 0
				var_215_5.localEulerAngles = var_215_5.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				var_215_5.localPosition = Vector3.New(0, 100, 0)
				var_215_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_5.position).x, (manager.ui.mainCamera.transform.position - var_215_5.position).y, (manager.ui.mainCamera.transform.position - var_215_5.position).z)
				var_215_5.localEulerAngles.z = 0
				var_215_5.localEulerAngles.x = 0
				var_215_5.localEulerAngles = var_215_5.localEulerAngles

				local var_215_8 = GameObjectTools.GetOrAddComponent(var_215_5.gameObject, typeof(DynamicBoneHelper))

				if var_215_8 then
					var_215_8:EnableDynamicBone(true)
				end
			end

			local var_215_9 = arg_212_1.actors_["1071ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1071ui_story == nil then
				arg_212_1.var_.characterEffect1071ui_story = var_215_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_10 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_10 and not isNil(var_215_9) then
				if arg_212_1.var_.characterEffect1071ui_story and not isNil(var_215_9) then
					arg_212_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_10 and arg_212_1.time_ < 0 + var_215_10 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1071ui_story then
				arg_212_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_215_12 = arg_212_1.actors_["1170ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_12) and arg_212_1.var_.characterEffect1170ui_story == nil then
				arg_212_1.var_.characterEffect1170ui_story = var_215_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_13 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_13 and not isNil(var_215_12) then
				if arg_212_1.var_.characterEffect1170ui_story and not isNil(var_215_12) then
					arg_212_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_13)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_13 and arg_212_1.time_ < 0 + var_215_13 + arg_215_0 and not isNil(var_215_12) and arg_212_1.var_.characterEffect1170ui_story then
				arg_212_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_215_14 = 0
			local var_215_15 = 0.05

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_14 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_16 = arg_212_1:GetWordFromCfg(325611052)
				local var_215_17 = arg_212_1:FormatText(var_215_16.content)

				arg_212_1.text_.text = var_215_17

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_19 = 2 <= 0 and var_215_15 or var_215_15 * (utf8.len(var_215_17) / 2)

				if (2 <= 0 and var_215_15 or var_215_15 * (utf8.len(var_215_17) / 2)) > 0 and var_215_15 < var_215_19 then
					arg_212_1.talkMaxDuration = var_215_19

					if var_215_19 + var_215_14 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_19 + var_215_14
					end
				end

				arg_212_1.text_.text = var_215_17
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611052", "story_v_out_325611.awb") ~= 0 then
					local var_215_20 = manager.audio:GetVoiceLength("story_v_out_325611", "325611052", "story_v_out_325611.awb") / 1000

					if var_215_20 + var_215_14 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_20 + var_215_14
					end

					if var_215_16.prefab_name ~= "" and arg_212_1.actors_[var_215_16.prefab_name] ~= nil then
						local var_215_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_16.prefab_name].transform, "story_v_out_325611", "325611052", "story_v_out_325611.awb")

						arg_212_1:RecordAudio("325611052", var_215_21)
						arg_212_1:RecordAudio("325611052", var_215_21)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325611", "325611052", "story_v_out_325611.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325611", "325611052", "story_v_out_325611.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_22 = math.max(var_215_15, arg_212_1.talkMaxDuration)

			if var_215_14 <= arg_212_1.time_ and arg_212_1.time_ < var_215_14 + var_215_22 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_14) / var_215_22

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_14 + var_215_22 and arg_212_1.time_ < var_215_14 + var_215_22 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play325611053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325611053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325611054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1071ui_story"]) and arg_216_1.var_.characterEffect1071ui_story == nil then
				arg_216_1.var_.characterEffect1071ui_story = arg_216_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1071ui_story"]) then
				if arg_216_1.var_.characterEffect1071ui_story and not isNil(arg_216_1.actors_["1071ui_story"]) then
					arg_216_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1071ui_story"]) and arg_216_1.var_.characterEffect1071ui_story then
				arg_216_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 1.025

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(325611053).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 41 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 41)

				if (41 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 41)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play325611054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325611054
		arg_220_1.duration_ = 8.8

		local var_220_0 = {
			zh = 4.966,
			ja = 8.8
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325611055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1071ui_story"]) and arg_220_1.var_.characterEffect1071ui_story == nil then
				arg_220_1.var_.characterEffect1071ui_story = arg_220_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1071ui_story"]) then
				if arg_220_1.var_.characterEffect1071ui_story and not isNil(arg_220_1.actors_["1071ui_story"]) then
					arg_220_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1071ui_story"]) and arg_220_1.var_.characterEffect1071ui_story then
				arg_220_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_223_2 = 0
			local var_223_3 = 0.575

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_4 = arg_220_1:GetWordFromCfg(325611054)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_7 = 23 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 23)

				if (23 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 23)) > 0 and var_223_3 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611054", "story_v_out_325611.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611054", "story_v_out_325611.awb") / 1000

					if var_223_8 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_2
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_325611", "325611054", "story_v_out_325611.awb")

						arg_220_1:RecordAudio("325611054", var_223_9)
						arg_220_1:RecordAudio("325611054", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325611", "325611054", "story_v_out_325611.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325611", "325611054", "story_v_out_325611.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_10 and arg_220_1.time_ < var_223_2 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play325611055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325611055
		arg_224_1.duration_ = 10.1

		local var_224_0 = {
			zh = 10.1,
			ja = 7.866
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325611056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 1.125

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:GetWordFromCfg(325611055)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 45 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 45)

				if (45 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 45)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611055", "story_v_out_325611.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_325611", "325611055", "story_v_out_325611.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_325611", "325611055", "story_v_out_325611.awb")

						arg_224_1:RecordAudio("325611055", var_227_6)
						arg_224_1:RecordAudio("325611055", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_325611", "325611055", "story_v_out_325611.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_325611", "325611055", "story_v_out_325611.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play325611056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325611056
		arg_228_1.duration_ = 8.53

		local var_228_0 = {
			zh = 7.533,
			ja = 8.533
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325611057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_231_0 = 0
			local var_231_1 = 0.9

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_2 = arg_228_1:GetWordFromCfg(325611056)
				local var_231_3 = arg_228_1:FormatText(var_231_2.content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 36 <= 0 and var_231_1 or var_231_1 * (utf8.len(var_231_3) / 36)

				if (36 <= 0 and var_231_1 or var_231_1 * (utf8.len(var_231_3) / 36)) > 0 and var_231_1 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611056", "story_v_out_325611.awb") ~= 0 then
					local var_231_6 = manager.audio:GetVoiceLength("story_v_out_325611", "325611056", "story_v_out_325611.awb") / 1000

					if var_231_6 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_6 + var_231_0
					end

					if var_231_2.prefab_name ~= "" and arg_228_1.actors_[var_231_2.prefab_name] ~= nil then
						local var_231_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_2.prefab_name].transform, "story_v_out_325611", "325611056", "story_v_out_325611.awb")

						arg_228_1:RecordAudio("325611056", var_231_7)
						arg_228_1:RecordAudio("325611056", var_231_7)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325611", "325611056", "story_v_out_325611.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325611", "325611056", "story_v_out_325611.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_8 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_8 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_8

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_8 and arg_228_1.time_ < var_231_0 + var_231_8 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325611057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325611057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325611058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1071ui_story = arg_232_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1071ui_story"].transform.position).z)
				arg_232_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1071ui_story"].transform.localEulerAngles = arg_232_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1071ui_story"].transform.position).z)
				arg_232_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1071ui_story"].transform.localEulerAngles = arg_232_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1071ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1071ui_story == nil then
				arg_232_1.var_.characterEffect1071ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect1071ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_2)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1071ui_story then
				arg_232_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_235_3 = manager.ui.mainCamera.transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.shakeOldPos = var_235_3.localPosition
			end

			local var_235_4 = 0.4

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				local var_235_5, var_235_6 = math.modf((arg_232_1.time_ - 0) / 0.066)

				var_235_3.localPosition = Vector3.New(var_235_6 * 0.13, var_235_6 * 0.13, var_235_6 * 0.13) + arg_232_1.var_.shakeOldPos
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_3.localPosition = arg_232_1.var_.shakeOldPos
			end

			local var_235_7 = 0

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_7 + arg_235_0 then
				arg_232_1.allBtn_.enabled = false
			end

			if arg_232_1.time_ >= var_235_7 + 0.4 and arg_232_1.time_ < var_235_7 + 0.4 + arg_235_0 then
				arg_232_1.allBtn_.enabled = true
			end

			local var_235_8 = 0
			local var_235_9 = 0.075

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_8 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0

				arg_232_1.dialog_:SetActive(true)

				arg_232_1.dialogCg_.alpha = 0

				local var_235_10 = LeanTween.value(arg_232_1.dialog_, 0, 1, 0.3)

				var_235_10:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_232_1.dialogCg_.alpha = arg_236_0
				end))
				var_235_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_232_1.dialog_)
					var_235_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_232_1.duration_ = arg_232_1.duration_ + 0.3

				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_11 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(325611057).content)

				arg_232_1.text_.text = var_235_11

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_13 = 3 <= 0 and var_235_9 or var_235_9 * (utf8.len(var_235_11) / 3)

				if (3 <= 0 and var_235_9 or var_235_9 * (utf8.len(var_235_11) / 3)) > 0 and var_235_9 < var_235_13 then
					arg_232_1.talkMaxDuration = var_235_13
					var_235_8 = var_235_8 + 0.3

					if var_235_13 + var_235_8 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_8
					end
				end

				arg_232_1.text_.text = var_235_11
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_14 = var_235_8 + 0.3
			local var_235_15 = math.max(var_235_9, arg_232_1.talkMaxDuration)

			if var_235_8 + 0.3 <= arg_232_1.time_ and arg_232_1.time_ < var_235_14 + var_235_15 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_14) / var_235_15

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_14 + var_235_15 and arg_232_1.time_ < var_235_14 + var_235_15 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play325611058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325611058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325611059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 1.525

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(325611058).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 61 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 61)

				if (61 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 61)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325611059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325611059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325611060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.475

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(325611059).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 19 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 19)

				if (19 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 19)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play325611060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325611060
		arg_246_1.duration_ = 4.9

		local var_246_0 = {
			zh = 3.466,
			ja = 4.9
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325611061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos10175ui_story = arg_246_1.actors_["10175ui_story"].transform.localPosition

				local var_249_0 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_0 then
					var_249_0:EnableDynamicBone(false)
				end
			end

			local var_249_1 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_246_1.time_ - 0) / var_249_1)
				arg_246_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10175ui_story"].transform.position).z)
				arg_246_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["10175ui_story"].transform.localEulerAngles = arg_246_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_246_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10175ui_story"].transform.position).z)
				arg_246_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["10175ui_story"].transform.localEulerAngles = arg_246_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_249_2 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_2 then
					var_249_2:EnableDynamicBone(true)
				end
			end

			local var_249_3 = arg_246_1.actors_["10175ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect10175ui_story == nil then
				arg_246_1.var_.characterEffect10175ui_story = var_249_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_4 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 and not isNil(var_249_3) then
				if arg_246_1.var_.characterEffect10175ui_story and not isNil(var_249_3) then
					arg_246_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect10175ui_story then
				arg_246_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_249_6 = 0
			local var_249_7 = 0.35

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_8 = arg_246_1:GetWordFromCfg(325611060)
				local var_249_9 = arg_246_1:FormatText(var_249_8.content)

				arg_246_1.text_.text = var_249_9

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 14 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 14)

				if (14 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 14)) > 0 and var_249_7 < var_249_11 then
					arg_246_1.talkMaxDuration = var_249_11

					if var_249_11 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_11 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_9
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611060", "story_v_out_325611.awb") ~= 0 then
					local var_249_12 = manager.audio:GetVoiceLength("story_v_out_325611", "325611060", "story_v_out_325611.awb") / 1000

					if var_249_12 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_12 + var_249_6
					end

					if var_249_8.prefab_name ~= "" and arg_246_1.actors_[var_249_8.prefab_name] ~= nil then
						local var_249_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_8.prefab_name].transform, "story_v_out_325611", "325611060", "story_v_out_325611.awb")

						arg_246_1:RecordAudio("325611060", var_249_13)
						arg_246_1:RecordAudio("325611060", var_249_13)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325611", "325611060", "story_v_out_325611.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325611", "325611060", "story_v_out_325611.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play325611061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325611061
		arg_250_1.duration_ = 8.97

		local var_250_0 = {
			zh = 6.033,
			ja = 8.966
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325611062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10175ui_story = arg_250_1.actors_["10175ui_story"].transform.localPosition

				local var_253_0 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_0 then
					var_253_0:EnableDynamicBone(false)
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_250_1.time_ - 0) / var_253_1)
				arg_250_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10175ui_story"].transform.position).z)
				arg_250_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["10175ui_story"].transform.localEulerAngles = arg_250_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_250_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10175ui_story"].transform.position).z)
				arg_250_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["10175ui_story"].transform.localEulerAngles = arg_250_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_253_2 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(true)
				end
			end

			local var_253_3 = arg_250_1.actors_["1071ui_story"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1071ui_story = var_253_3.localPosition
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_3.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_250_1.time_ - 0) / var_253_4)
				var_253_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_3.position).x, (manager.ui.mainCamera.transform.position - var_253_3.position).y, (manager.ui.mainCamera.transform.position - var_253_3.position).z)
				var_253_3.localEulerAngles.z = 0
				var_253_3.localEulerAngles.x = 0
				var_253_3.localEulerAngles = var_253_3.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_253_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_3.position).x, (manager.ui.mainCamera.transform.position - var_253_3.position).y, (manager.ui.mainCamera.transform.position - var_253_3.position).z)
				var_253_3.localEulerAngles.z = 0
				var_253_3.localEulerAngles.x = 0
				var_253_3.localEulerAngles = var_253_3.localEulerAngles
			end

			local var_253_5 = arg_250_1.actors_["1071ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_5) and arg_250_1.var_.characterEffect1071ui_story == nil then
				arg_250_1.var_.characterEffect1071ui_story = var_253_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_6 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_6 and not isNil(var_253_5) then
				if arg_250_1.var_.characterEffect1071ui_story and not isNil(var_253_5) then
					arg_250_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_6 and arg_250_1.time_ < 0 + var_253_6 + arg_253_0 and not isNil(var_253_5) and arg_250_1.var_.characterEffect1071ui_story then
				arg_250_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_253_8 = arg_250_1.actors_["10175ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_8) and arg_250_1.var_.characterEffect10175ui_story == nil then
				arg_250_1.var_.characterEffect10175ui_story = var_253_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_9 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_9 and not isNil(var_253_8) then
				if arg_250_1.var_.characterEffect10175ui_story and not isNil(var_253_8) then
					arg_250_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_9)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_9 and arg_250_1.time_ < 0 + var_253_9 + arg_253_0 and not isNil(var_253_8) and arg_250_1.var_.characterEffect10175ui_story then
				arg_250_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_253_10 = 0
			local var_253_11 = 0.75

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_12 = arg_250_1:GetWordFromCfg(325611061)
				local var_253_13 = arg_250_1:FormatText(var_253_12.content)

				arg_250_1.text_.text = var_253_13

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_15 = 30 <= 0 and var_253_11 or var_253_11 * (utf8.len(var_253_13) / 30)

				if (30 <= 0 and var_253_11 or var_253_11 * (utf8.len(var_253_13) / 30)) > 0 and var_253_11 < var_253_15 then
					arg_250_1.talkMaxDuration = var_253_15

					if var_253_15 + var_253_10 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_15 + var_253_10
					end
				end

				arg_250_1.text_.text = var_253_13
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611061", "story_v_out_325611.awb") ~= 0 then
					local var_253_16 = manager.audio:GetVoiceLength("story_v_out_325611", "325611061", "story_v_out_325611.awb") / 1000

					if var_253_16 + var_253_10 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_16 + var_253_10
					end

					if var_253_12.prefab_name ~= "" and arg_250_1.actors_[var_253_12.prefab_name] ~= nil then
						local var_253_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_12.prefab_name].transform, "story_v_out_325611", "325611061", "story_v_out_325611.awb")

						arg_250_1:RecordAudio("325611061", var_253_17)
						arg_250_1:RecordAudio("325611061", var_253_17)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_325611", "325611061", "story_v_out_325611.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_325611", "325611061", "story_v_out_325611.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_18 = math.max(var_253_11, arg_250_1.talkMaxDuration)

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_18 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_10) / var_253_18

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_10 + var_253_18 and arg_250_1.time_ < var_253_10 + var_253_18 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play325611062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325611062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325611063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1071ui_story"]) and arg_254_1.var_.characterEffect1071ui_story == nil then
				arg_254_1.var_.characterEffect1071ui_story = arg_254_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1071ui_story"]) then
				if arg_254_1.var_.characterEffect1071ui_story and not isNil(arg_254_1.actors_["1071ui_story"]) then
					arg_254_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1071ui_story"]) and arg_254_1.var_.characterEffect1071ui_story then
				arg_254_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_257_1 = 0
			local var_257_2 = 0.6

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(325611062).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 24 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 24)

				if (24 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 24)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play325611063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325611063
		arg_258_1.duration_ = 10.67

		local var_258_0 = {
			zh = 7.5,
			ja = 10.666
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325611064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1071ui_story"]) and arg_258_1.var_.characterEffect1071ui_story == nil then
				arg_258_1.var_.characterEffect1071ui_story = arg_258_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1071ui_story"]) then
				if arg_258_1.var_.characterEffect1071ui_story and not isNil(arg_258_1.actors_["1071ui_story"]) then
					arg_258_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1071ui_story"]) and arg_258_1.var_.characterEffect1071ui_story then
				arg_258_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_261_2 = 0
			local var_261_3 = 0.775

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_4 = arg_258_1:GetWordFromCfg(325611063)
				local var_261_5 = arg_258_1:FormatText(var_261_4.content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 31 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 31)

				if (31 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 31)) > 0 and var_261_3 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611063", "story_v_out_325611.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611063", "story_v_out_325611.awb") / 1000

					if var_261_8 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_2
					end

					if var_261_4.prefab_name ~= "" and arg_258_1.actors_[var_261_4.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_4.prefab_name].transform, "story_v_out_325611", "325611063", "story_v_out_325611.awb")

						arg_258_1:RecordAudio("325611063", var_261_9)
						arg_258_1:RecordAudio("325611063", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_325611", "325611063", "story_v_out_325611.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_325611", "325611063", "story_v_out_325611.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_10 and arg_258_1.time_ < var_261_2 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play325611064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325611064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325611065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1071ui_story = arg_262_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1071ui_story"].transform.position).z)
				arg_262_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1071ui_story"].transform.localEulerAngles = arg_262_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1071ui_story"].transform.position).z)
				arg_262_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1071ui_story"].transform.localEulerAngles = arg_262_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["10175ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos10175ui_story = var_265_1.localPosition

				local var_265_2 = GameObjectTools.GetOrAddComponent(var_265_1.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(false)
				end
			end

			local var_265_3 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 then
				var_265_1.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_3)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 then
				var_265_1.localPosition = Vector3.New(0, 100, 0)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles

				local var_265_4 = GameObjectTools.GetOrAddComponent(var_265_1.gameObject, typeof(DynamicBoneHelper))

				if var_265_4 then
					var_265_4:EnableDynamicBone(true)
				end
			end

			local var_265_5 = arg_262_1.actors_["1071ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.characterEffect1071ui_story == nil then
				arg_262_1.var_.characterEffect1071ui_story = var_265_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_6 and not isNil(var_265_5) then
				if arg_262_1.var_.characterEffect1071ui_story and not isNil(var_265_5) then
					arg_262_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_6)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_6 and arg_262_1.time_ < 0 + var_265_6 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.characterEffect1071ui_story then
				arg_262_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_265_7 = 0
			local var_265_8 = 0.775

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_9 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(325611064).content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 31 <= 0 and var_265_8 or var_265_8 * (utf8.len(var_265_9) / 31)

				if (31 <= 0 and var_265_8 or var_265_8 * (utf8.len(var_265_9) / 31)) > 0 and var_265_8 < var_265_11 then
					arg_262_1.talkMaxDuration = var_265_11

					if var_265_11 + var_265_7 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_7
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_8, arg_262_1.talkMaxDuration)

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_7) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_7 + var_265_12 and arg_262_1.time_ < var_265_7 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play325611065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325611065
		arg_266_1.duration_ = 6.6

		local var_266_0 = {
			zh = 6.5,
			ja = 6.6
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325611066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos10167ui_story = arg_266_1.actors_["10167ui_story"].transform.localPosition

				local var_269_0 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_0 then
					var_269_0:EnableDynamicBone(false)
				end
			end

			local var_269_1 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10167ui_story, Vector3.New(0, -1.28, -5.73), (arg_266_1.time_ - 0) / var_269_1)
				arg_266_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10167ui_story"].transform.position).z)
				arg_266_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["10167ui_story"].transform.localEulerAngles = arg_266_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_266_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10167ui_story"].transform.position).z)
				arg_266_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["10167ui_story"].transform.localEulerAngles = arg_266_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_269_2 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(true)
				end
			end

			local var_269_3 = arg_266_1.actors_["10167ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect10167ui_story == nil then
				arg_266_1.var_.characterEffect10167ui_story = var_269_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_4 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 and not isNil(var_269_3) then
				if arg_266_1.var_.characterEffect10167ui_story and not isNil(var_269_3) then
					arg_266_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect10167ui_story then
				arg_266_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_269_6 = 0
			local var_269_7 = 0.675

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:GetWordFromCfg(325611065)
				local var_269_9 = arg_266_1:FormatText(var_269_8.content)

				arg_266_1.text_.text = var_269_9

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 27 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_9) / 27)

				if (27 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_9) / 27)) > 0 and var_269_7 < var_269_11 then
					arg_266_1.talkMaxDuration = var_269_11

					if var_269_11 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_9
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611065", "story_v_out_325611.awb") ~= 0 then
					local var_269_12 = manager.audio:GetVoiceLength("story_v_out_325611", "325611065", "story_v_out_325611.awb") / 1000

					if var_269_12 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_6
					end

					if var_269_8.prefab_name ~= "" and arg_266_1.actors_[var_269_8.prefab_name] ~= nil then
						local var_269_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_8.prefab_name].transform, "story_v_out_325611", "325611065", "story_v_out_325611.awb")

						arg_266_1:RecordAudio("325611065", var_269_13)
						arg_266_1:RecordAudio("325611065", var_269_13)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_325611", "325611065", "story_v_out_325611.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_325611", "325611065", "story_v_out_325611.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_14 and arg_266_1.time_ < var_269_6 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play325611066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325611066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325611067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["10167ui_story"]) and arg_270_1.var_.characterEffect10167ui_story == nil then
				arg_270_1.var_.characterEffect10167ui_story = arg_270_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["10167ui_story"]) then
				if arg_270_1.var_.characterEffect10167ui_story and not isNil(arg_270_1.actors_["10167ui_story"]) then
					arg_270_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["10167ui_story"]) and arg_270_1.var_.characterEffect10167ui_story then
				arg_270_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 0.55

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(325611066).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 22 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 22)

				if (22 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 22)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play325611067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325611067
		arg_274_1.duration_ = 7.67

		local var_274_0 = {
			zh = 7.433,
			ja = 7.666
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325611068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["10167ui_story"]) and arg_274_1.var_.characterEffect10167ui_story == nil then
				arg_274_1.var_.characterEffect10167ui_story = arg_274_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["10167ui_story"]) then
				if arg_274_1.var_.characterEffect10167ui_story and not isNil(arg_274_1.actors_["10167ui_story"]) then
					arg_274_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["10167ui_story"]) and arg_274_1.var_.characterEffect10167ui_story then
				arg_274_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_277_2 = 0
			local var_277_3 = 0.725

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(325611067)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 29 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 29)

				if (29 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 29)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611067", "story_v_out_325611.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_325611", "325611067", "story_v_out_325611.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_out_325611", "325611067", "story_v_out_325611.awb")

						arg_274_1:RecordAudio("325611067", var_277_9)
						arg_274_1:RecordAudio("325611067", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_325611", "325611067", "story_v_out_325611.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_325611", "325611067", "story_v_out_325611.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play325611068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325611068
		arg_278_1.duration_ = 13.6

		local var_278_0 = {
			zh = 10.233,
			ja = 13.6
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play325611069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 1.125

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:GetWordFromCfg(325611068)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 45 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 45)

				if (45 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 45)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611068", "story_v_out_325611.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_325611", "325611068", "story_v_out_325611.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_325611", "325611068", "story_v_out_325611.awb")

						arg_278_1:RecordAudio("325611068", var_281_6)
						arg_278_1:RecordAudio("325611068", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_325611", "325611068", "story_v_out_325611.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_325611", "325611068", "story_v_out_325611.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play325611069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 325611069
		arg_282_1.duration_ = 8.13

		local var_282_0 = {
			zh = 4.333,
			ja = 8.133
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play325611070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10167ui_story = arg_282_1.actors_["10167ui_story"].transform.localPosition

				local var_285_0 = GameObjectTools.GetOrAddComponent(arg_282_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_285_0 then
					var_285_0:EnableDynamicBone(false)
				end
			end

			local var_285_1 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				arg_282_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10167ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_282_1.time_ - 0) / var_285_1)
				arg_282_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10167ui_story"].transform.position).z)
				arg_282_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["10167ui_story"].transform.localEulerAngles = arg_282_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				arg_282_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_282_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10167ui_story"].transform.position).z)
				arg_282_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["10167ui_story"].transform.localEulerAngles = arg_282_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_285_2 = GameObjectTools.GetOrAddComponent(arg_282_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_285_2 then
					var_285_2:EnableDynamicBone(true)
				end
			end

			local var_285_3 = arg_282_1.actors_["10175ui_story"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10175ui_story = var_285_3.localPosition

				local var_285_4 = GameObjectTools.GetOrAddComponent(var_285_3.gameObject, typeof(DynamicBoneHelper))

				if var_285_4 then
					var_285_4:EnableDynamicBone(false)
				end
			end

			local var_285_5 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_5 then
				var_285_3.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_282_1.time_ - 0) / var_285_5)
				var_285_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_3.position).x, (manager.ui.mainCamera.transform.position - var_285_3.position).y, (manager.ui.mainCamera.transform.position - var_285_3.position).z)
				var_285_3.localEulerAngles.z = 0
				var_285_3.localEulerAngles.x = 0
				var_285_3.localEulerAngles = var_285_3.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_5 and arg_282_1.time_ < 0 + var_285_5 + arg_285_0 then
				var_285_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_285_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_3.position).x, (manager.ui.mainCamera.transform.position - var_285_3.position).y, (manager.ui.mainCamera.transform.position - var_285_3.position).z)
				var_285_3.localEulerAngles.z = 0
				var_285_3.localEulerAngles.x = 0
				var_285_3.localEulerAngles = var_285_3.localEulerAngles

				local var_285_6 = GameObjectTools.GetOrAddComponent(var_285_3.gameObject, typeof(DynamicBoneHelper))

				if var_285_6 then
					var_285_6:EnableDynamicBone(true)
				end
			end

			local var_285_7 = arg_282_1.actors_["10175ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.characterEffect10175ui_story == nil then
				arg_282_1.var_.characterEffect10175ui_story = var_285_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_8 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_8 and not isNil(var_285_7) then
				if arg_282_1.var_.characterEffect10175ui_story and not isNil(var_285_7) then
					arg_282_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_8 and arg_282_1.time_ < 0 + var_285_8 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.characterEffect10175ui_story then
				arg_282_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_285_10 = arg_282_1.actors_["10167ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_10) and arg_282_1.var_.characterEffect10167ui_story == nil then
				arg_282_1.var_.characterEffect10167ui_story = var_285_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_11 and not isNil(var_285_10) then
				if arg_282_1.var_.characterEffect10167ui_story and not isNil(var_285_10) then
					arg_282_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_282_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_11)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_11 and arg_282_1.time_ < 0 + var_285_11 + arg_285_0 and not isNil(var_285_10) and arg_282_1.var_.characterEffect10167ui_story then
				arg_282_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_282_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_285_12 = 0
			local var_285_13 = 0.45

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_12 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_14 = arg_282_1:GetWordFromCfg(325611069)
				local var_285_15 = arg_282_1:FormatText(var_285_14.content)

				arg_282_1.text_.text = var_285_15

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_17 = 18 <= 0 and var_285_13 or var_285_13 * (utf8.len(var_285_15) / 18)

				if (18 <= 0 and var_285_13 or var_285_13 * (utf8.len(var_285_15) / 18)) > 0 and var_285_13 < var_285_17 then
					arg_282_1.talkMaxDuration = var_285_17

					if var_285_17 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_17 + var_285_12
					end
				end

				arg_282_1.text_.text = var_285_15
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611069", "story_v_out_325611.awb") ~= 0 then
					local var_285_18 = manager.audio:GetVoiceLength("story_v_out_325611", "325611069", "story_v_out_325611.awb") / 1000

					if var_285_18 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_18 + var_285_12
					end

					if var_285_14.prefab_name ~= "" and arg_282_1.actors_[var_285_14.prefab_name] ~= nil then
						local var_285_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_14.prefab_name].transform, "story_v_out_325611", "325611069", "story_v_out_325611.awb")

						arg_282_1:RecordAudio("325611069", var_285_19)
						arg_282_1:RecordAudio("325611069", var_285_19)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_325611", "325611069", "story_v_out_325611.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_325611", "325611069", "story_v_out_325611.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_20 = math.max(var_285_13, arg_282_1.talkMaxDuration)

			if var_285_12 <= arg_282_1.time_ and arg_282_1.time_ < var_285_12 + var_285_20 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_12) / var_285_20

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_12 + var_285_20 and arg_282_1.time_ < var_285_12 + var_285_20 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play325611070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 325611070
		arg_286_1.duration_ = 4.23

		local var_286_0 = {
			zh = 4.1,
			ja = 4.233
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play325611071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10175ui_story = arg_286_1.actors_["10175ui_story"].transform.localPosition

				local var_289_0 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_0 then
					var_289_0:EnableDynamicBone(false)
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_286_1.time_ - 0) / var_289_1)
				arg_286_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10175ui_story"].transform.position).z)
				arg_286_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["10175ui_story"].transform.localEulerAngles = arg_286_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10175ui_story"].transform.position).z)
				arg_286_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["10175ui_story"].transform.localEulerAngles = arg_286_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_289_2 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(true)
				end
			end

			local var_289_3 = arg_286_1.actors_["6148ui_story"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos6148ui_story = var_289_3.localPosition

				local var_289_4 = GameObjectTools.GetOrAddComponent(var_289_3.gameObject, typeof(DynamicBoneHelper))

				if var_289_4 then
					var_289_4:EnableDynamicBone(false)
				end
			end

			local var_289_5 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_5 then
				var_289_3.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_286_1.time_ - 0) / var_289_5)
				var_289_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_3.position).x, (manager.ui.mainCamera.transform.position - var_289_3.position).y, (manager.ui.mainCamera.transform.position - var_289_3.position).z)
				var_289_3.localEulerAngles.z = 0
				var_289_3.localEulerAngles.x = 0
				var_289_3.localEulerAngles = var_289_3.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_5 and arg_286_1.time_ < 0 + var_289_5 + arg_289_0 then
				var_289_3.localPosition = Vector3.New(0, -0.985, -6)
				var_289_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_3.position).x, (manager.ui.mainCamera.transform.position - var_289_3.position).y, (manager.ui.mainCamera.transform.position - var_289_3.position).z)
				var_289_3.localEulerAngles.z = 0
				var_289_3.localEulerAngles.x = 0
				var_289_3.localEulerAngles = var_289_3.localEulerAngles

				local var_289_6 = GameObjectTools.GetOrAddComponent(var_289_3.gameObject, typeof(DynamicBoneHelper))

				if var_289_6 then
					var_289_6:EnableDynamicBone(true)
				end
			end

			local var_289_7 = arg_286_1.actors_["10167ui_story"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10167ui_story = var_289_7.localPosition

				local var_289_8 = GameObjectTools.GetOrAddComponent(var_289_7.gameObject, typeof(DynamicBoneHelper))

				if var_289_8 then
					var_289_8:EnableDynamicBone(false)
				end
			end

			local var_289_9 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_9 then
				var_289_7.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_286_1.time_ - 0) / var_289_9)
				var_289_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_7.position).x, (manager.ui.mainCamera.transform.position - var_289_7.position).y, (manager.ui.mainCamera.transform.position - var_289_7.position).z)
				var_289_7.localEulerAngles.z = 0
				var_289_7.localEulerAngles.x = 0
				var_289_7.localEulerAngles = var_289_7.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_9 and arg_286_1.time_ < 0 + var_289_9 + arg_289_0 then
				var_289_7.localPosition = Vector3.New(0, 100, 0)
				var_289_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_7.position).x, (manager.ui.mainCamera.transform.position - var_289_7.position).y, (manager.ui.mainCamera.transform.position - var_289_7.position).z)
				var_289_7.localEulerAngles.z = 0
				var_289_7.localEulerAngles.x = 0
				var_289_7.localEulerAngles = var_289_7.localEulerAngles

				local var_289_10 = GameObjectTools.GetOrAddComponent(var_289_7.gameObject, typeof(DynamicBoneHelper))

				if var_289_10 then
					var_289_10:EnableDynamicBone(true)
				end
			end

			local var_289_11 = arg_286_1.actors_["6148ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_11) and arg_286_1.var_.characterEffect6148ui_story == nil then
				arg_286_1.var_.characterEffect6148ui_story = var_289_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_12 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_12 and not isNil(var_289_11) then
				if arg_286_1.var_.characterEffect6148ui_story and not isNil(var_289_11) then
					arg_286_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_12 and arg_286_1.time_ < 0 + var_289_12 + arg_289_0 and not isNil(var_289_11) and arg_286_1.var_.characterEffect6148ui_story then
				arg_286_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_289_14 = arg_286_1.actors_["10175ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.characterEffect10175ui_story == nil then
				arg_286_1.var_.characterEffect10175ui_story = var_289_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_15 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_15 and not isNil(var_289_14) then
				if arg_286_1.var_.characterEffect10175ui_story and not isNil(var_289_14) then
					arg_286_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_15)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_15 and arg_286_1.time_ < 0 + var_289_15 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.characterEffect10175ui_story then
				arg_286_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_289_16 = 0
			local var_289_17 = 0.475

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_16 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(325611070)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_21 = 19 <= 0 and var_289_17 or var_289_17 * (utf8.len(var_289_19) / 19)

				if (19 <= 0 and var_289_17 or var_289_17 * (utf8.len(var_289_19) / 19)) > 0 and var_289_17 < var_289_21 then
					arg_286_1.talkMaxDuration = var_289_21

					if var_289_21 + var_289_16 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_21 + var_289_16
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611070", "story_v_out_325611.awb") ~= 0 then
					local var_289_22 = manager.audio:GetVoiceLength("story_v_out_325611", "325611070", "story_v_out_325611.awb") / 1000

					if var_289_22 + var_289_16 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_16
					end

					if var_289_18.prefab_name ~= "" and arg_286_1.actors_[var_289_18.prefab_name] ~= nil then
						local var_289_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_18.prefab_name].transform, "story_v_out_325611", "325611070", "story_v_out_325611.awb")

						arg_286_1:RecordAudio("325611070", var_289_23)
						arg_286_1:RecordAudio("325611070", var_289_23)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_325611", "325611070", "story_v_out_325611.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_325611", "325611070", "story_v_out_325611.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_24 = math.max(var_289_17, arg_286_1.talkMaxDuration)

			if var_289_16 <= arg_286_1.time_ and arg_286_1.time_ < var_289_16 + var_289_24 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_16) / var_289_24

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_16 + var_289_24 and arg_286_1.time_ < var_289_16 + var_289_24 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play325611071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 325611071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play325611072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["6148ui_story"]) and arg_290_1.var_.characterEffect6148ui_story == nil then
				arg_290_1.var_.characterEffect6148ui_story = arg_290_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["6148ui_story"]) then
				if arg_290_1.var_.characterEffect6148ui_story and not isNil(arg_290_1.actors_["6148ui_story"]) then
					arg_290_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_290_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["6148ui_story"]) and arg_290_1.var_.characterEffect6148ui_story then
				arg_290_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_290_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.575

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(325611071).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 23 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 23)

				if (23 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 23)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play325611072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 325611072
		arg_294_1.duration_ = 5.63

		local var_294_0 = {
			zh = 3.433,
			ja = 5.633
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play325611073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1071ui_story = arg_294_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1071ui_story"].transform.position).z)
				arg_294_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1071ui_story"].transform.localEulerAngles = arg_294_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_294_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1071ui_story"].transform.position).z)
				arg_294_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1071ui_story"].transform.localEulerAngles = arg_294_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_297_1 = arg_294_1.actors_["6148ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos6148ui_story = var_297_1.localPosition

				local var_297_2 = GameObjectTools.GetOrAddComponent(var_297_1.gameObject, typeof(DynamicBoneHelper))

				if var_297_2 then
					var_297_2:EnableDynamicBone(false)
				end
			end

			local var_297_3 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 then
				var_297_1.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_294_1.time_ - 0) / var_297_3)
				var_297_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_1.position).x, (manager.ui.mainCamera.transform.position - var_297_1.position).y, (manager.ui.mainCamera.transform.position - var_297_1.position).z)
				var_297_1.localEulerAngles.z = 0
				var_297_1.localEulerAngles.x = 0
				var_297_1.localEulerAngles = var_297_1.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 then
				var_297_1.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_297_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_1.position).x, (manager.ui.mainCamera.transform.position - var_297_1.position).y, (manager.ui.mainCamera.transform.position - var_297_1.position).z)
				var_297_1.localEulerAngles.z = 0
				var_297_1.localEulerAngles.x = 0
				var_297_1.localEulerAngles = var_297_1.localEulerAngles

				local var_297_4 = GameObjectTools.GetOrAddComponent(var_297_1.gameObject, typeof(DynamicBoneHelper))

				if var_297_4 then
					var_297_4:EnableDynamicBone(true)
				end
			end

			local var_297_5 = arg_294_1.actors_["1071ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_5) and arg_294_1.var_.characterEffect1071ui_story == nil then
				arg_294_1.var_.characterEffect1071ui_story = var_297_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_6 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_6 and not isNil(var_297_5) then
				if arg_294_1.var_.characterEffect1071ui_story and not isNil(var_297_5) then
					arg_294_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_6 and arg_294_1.time_ < 0 + var_297_6 + arg_297_0 and not isNil(var_297_5) and arg_294_1.var_.characterEffect1071ui_story then
				arg_294_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_297_8 = 0
			local var_297_9 = 0.275

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_10 = arg_294_1:GetWordFromCfg(325611072)
				local var_297_11 = arg_294_1:FormatText(var_297_10.content)

				arg_294_1.text_.text = var_297_11

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_13 = 11 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_11) / 11)

				if (11 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_11) / 11)) > 0 and var_297_9 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_11
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325611", "325611072", "story_v_out_325611.awb") ~= 0 then
					local var_297_14 = manager.audio:GetVoiceLength("story_v_out_325611", "325611072", "story_v_out_325611.awb") / 1000

					if var_297_14 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_8
					end

					if var_297_10.prefab_name ~= "" and arg_294_1.actors_[var_297_10.prefab_name] ~= nil then
						local var_297_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_10.prefab_name].transform, "story_v_out_325611", "325611072", "story_v_out_325611.awb")

						arg_294_1:RecordAudio("325611072", var_297_15)
						arg_294_1:RecordAudio("325611072", var_297_15)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_325611", "325611072", "story_v_out_325611.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_325611", "325611072", "story_v_out_325611.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_16 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_16 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_8) / var_297_16

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_8 + var_297_16 and arg_294_1.time_ < var_297_8 + var_297_16 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play325611073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 325611073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play325611074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1071ui_story"]) and arg_298_1.var_.characterEffect1071ui_story == nil then
				arg_298_1.var_.characterEffect1071ui_story = arg_298_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1071ui_story"]) then
				if arg_298_1.var_.characterEffect1071ui_story and not isNil(arg_298_1.actors_["1071ui_story"]) then
					arg_298_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_0)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1071ui_story"]) and arg_298_1.var_.characterEffect1071ui_story then
				arg_298_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_301_1 = 0
			local var_301_2 = 0.6

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(325611073).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 24 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 24)

				if (24 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 24)) > 0 and var_301_2 < var_301_5 then
					arg_298_1.talkMaxDuration = var_301_5

					if var_301_5 + var_301_1 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + var_301_1
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_6 = math.max(var_301_2, arg_298_1.talkMaxDuration)

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_6 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_1) / var_301_6

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_1 + var_301_6 and arg_298_1.time_ < var_301_1 + var_301_6 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play325611074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 325611074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
			arg_302_1.auto_ = false
		end

		function arg_302_1.playNext_(arg_304_0)
			arg_302_1.onStoryFinished_()
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_305_1 = 0
			local var_305_2 = 0.425

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_3 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(325611074).content)

				arg_302_1.text_.text = var_305_3

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 17 <= 0 and var_305_2 or var_305_2 * (utf8.len(var_305_3) / 17)

				if (17 <= 0 and var_305_2 or var_305_2 * (utf8.len(var_305_3) / 17)) > 0 and var_305_2 < var_305_5 then
					arg_302_1.talkMaxDuration = var_305_5

					if var_305_5 + var_305_1 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + var_305_1
					end
				end

				arg_302_1.text_.text = var_305_3
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_6 = math.max(var_305_2, arg_302_1.talkMaxDuration)

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_6 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_1) / var_305_6

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_1 + var_305_6 and arg_302_1.time_ < var_305_1 + var_305_6 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J26h",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_325611.awb"
	}
}
