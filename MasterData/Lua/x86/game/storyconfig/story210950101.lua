return {
	Play1109501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109501001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
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

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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
			local var_4_15 = 0.825

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109501001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 33 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 33)

				if (33 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 33)) > 0 and var_4_15 < var_4_19 then
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
	Play1109501002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109501002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109501003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.025

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109501002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 41)

				if (41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 41)) > 0 and var_12_0 < var_12_3 then
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
	Play1109501003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109501003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109501004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.1

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1109501003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 44 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 44)

				if (44 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 44)) > 0 and var_16_0 < var_16_3 then
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
	Play1109501004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109501004
		arg_17_1.duration_ = 5.97

		local var_17_0 = {
			zh = 4.3,
			ja = 5.966
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109501005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1095ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1095ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1095ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1095ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1095ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1095ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1109501004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 20 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 20)

				if (20 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 20)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501004", "story_v_side_new_1109501.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501004", "story_v_side_new_1109501.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1109501", "1109501004", "story_v_side_new_1109501.awb")

						arg_17_1:RecordAudio("1109501004", var_20_15)
						arg_17_1:RecordAudio("1109501004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501004", "story_v_side_new_1109501.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501004", "story_v_side_new_1109501.awb")
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
				actorName = "1095ui_story",
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
	Play1109501005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109501005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109501006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = arg_21_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(arg_21_1.actors_["1095ui_story"]) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.325

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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109501005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 53 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 53)

				if (53 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 53)) > 0 and var_24_2 < var_24_5 then
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
	Play1109501006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109501006
		arg_25_1.duration_ = 8.97

		local var_25_0 = {
			zh = 3.433,
			ja = 8.966
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109501007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1095ui_story = arg_25_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1095ui_story"].transform.position).z)
				arg_25_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1095ui_story"].transform.localEulerAngles = arg_25_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_25_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1095ui_story"].transform.position).z)
				arg_25_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1095ui_story"].transform.localEulerAngles = arg_25_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1095ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.45

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(1109501006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 18 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 18)

				if (18 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 18)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501006", "story_v_side_new_1109501.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501006", "story_v_side_new_1109501.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_new_1109501", "1109501006", "story_v_side_new_1109501.awb")

						arg_25_1:RecordAudio("1109501006", var_28_11)
						arg_25_1:RecordAudio("1109501006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501006", "story_v_side_new_1109501.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501006", "story_v_side_new_1109501.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109501007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109501007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109501008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1095ui_story"]) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = arg_29_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1095ui_story"]) then
				if arg_29_1.var_.characterEffect1095ui_story and not isNil(arg_29_1.actors_["1095ui_story"]) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1095ui_story"]) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.475

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
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

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1109501007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 19 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 19)

				if (19 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 19)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109501008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109501008
		arg_33_1.duration_ = 3.3

		local var_33_0 = {
			zh = 2.8,
			ja = 3.3
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109501009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = arg_33_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(arg_33_1.actors_["1095ui_story"]) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_36_2 = 0
			local var_36_3 = 0.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(1109501008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 5 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 5)

				if (5 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 5)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501008", "story_v_side_new_1109501.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501008", "story_v_side_new_1109501.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_new_1109501", "1109501008", "story_v_side_new_1109501.awb")

						arg_33_1:RecordAudio("1109501008", var_36_9)
						arg_33_1:RecordAudio("1109501008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501008", "story_v_side_new_1109501.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501008", "story_v_side_new_1109501.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109501009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109501009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109501010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = arg_37_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(arg_37_1.actors_["1095ui_story"]) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1109501009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 26)

				if (26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 26)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109501010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109501010
		arg_41_1.duration_ = 5.37

		local var_41_0 = {
			zh = 3.666,
			ja = 5.366
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109501011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = arg_41_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1095ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1109501010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 15 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 15)

				if (15 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 15)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501010", "story_v_side_new_1109501.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501010", "story_v_side_new_1109501.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1109501", "1109501010", "story_v_side_new_1109501.awb")

						arg_41_1:RecordAudio("1109501010", var_44_11)
						arg_41_1:RecordAudio("1109501010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501010", "story_v_side_new_1109501.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501010", "story_v_side_new_1109501.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play1109501011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109501011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109501012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = arg_45_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) then
				if arg_45_1.var_.characterEffect1095ui_story and not isNil(arg_45_1.actors_["1095ui_story"]) then
					arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) and arg_45_1.var_.characterEffect1095ui_story then
				arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.5

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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1109501011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 20 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 20)

				if (20 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 20)) > 0 and var_48_2 < var_48_5 then
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
	Play1109501012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109501012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			zh = 4.933,
			ja = 5.9
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109501013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = arg_49_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(arg_49_1.actors_["1095ui_story"]) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(1109501012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 20 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 20)

				if (20 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 20)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501012", "story_v_side_new_1109501.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501012", "story_v_side_new_1109501.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_new_1109501", "1109501012", "story_v_side_new_1109501.awb")

						arg_49_1:RecordAudio("1109501012", var_52_9)
						arg_49_1:RecordAudio("1109501012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501012", "story_v_side_new_1109501.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501012", "story_v_side_new_1109501.awb")
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
	Play1109501013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109501013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1109501014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = arg_53_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) then
				if arg_53_1.var_.characterEffect1095ui_story and not isNil(arg_53_1.actors_["1095ui_story"]) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.975

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1109501013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 39 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 39)

				if (39 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 39)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109501014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109501014
		arg_57_1.duration_ = 1.9

		local var_57_0 = {
			zh = 1.666,
			ja = 1.9
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1109501015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = arg_57_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) then
				if arg_57_1.var_.characterEffect1095ui_story and not isNil(arg_57_1.actors_["1095ui_story"]) then
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_60_2 = 0
			local var_60_3 = 0.15

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[662].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(1109501014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 6 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 6)

				if (6 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 6)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501014", "story_v_side_new_1109501.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501014", "story_v_side_new_1109501.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1109501", "1109501014", "story_v_side_new_1109501.awb")

						arg_57_1:RecordAudio("1109501014", var_60_9)
						arg_57_1:RecordAudio("1109501014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501014", "story_v_side_new_1109501.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501014", "story_v_side_new_1109501.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1109501015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109501015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1109501016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = arg_61_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(arg_61_1.actors_["1095ui_story"]) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.2

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1109501015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 8 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 8)

				if (8 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 8)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1109501016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109501016
		arg_65_1.duration_ = 5.57

		local var_65_0 = {
			zh = 3.966,
			ja = 5.566
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109501017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1095ui_story = arg_65_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).z)
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles = arg_65_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_65_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).z)
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles = arg_65_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1095ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(1109501016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 11 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 11)

				if (11 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 11)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501016", "story_v_side_new_1109501.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501016", "story_v_side_new_1109501.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_new_1109501", "1109501016", "story_v_side_new_1109501.awb")

						arg_65_1:RecordAudio("1109501016", var_68_11)
						arg_65_1:RecordAudio("1109501016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501016", "story_v_side_new_1109501.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501016", "story_v_side_new_1109501.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play1109501017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109501017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1109501018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = arg_69_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) then
				if arg_69_1.var_.characterEffect1095ui_story and not isNil(arg_69_1.actors_["1095ui_story"]) then
					arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) and arg_69_1.var_.characterEffect1095ui_story then
				arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
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

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1109501017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 15 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 15)

				if (15 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 15)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1109501018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109501018
		arg_73_1.duration_ = 7.83

		local var_73_0 = {
			zh = 6.533,
			ja = 7.833
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1109501019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) and arg_73_1.var_.characterEffect1095ui_story == nil then
				arg_73_1.var_.characterEffect1095ui_story = arg_73_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) then
				if arg_73_1.var_.characterEffect1095ui_story and not isNil(arg_73_1.actors_["1095ui_story"]) then
					arg_73_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) and arg_73_1.var_.characterEffect1095ui_story then
				arg_73_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_76_2 = 0
			local var_76_3 = 0.7

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(1109501018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 28 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 28)

				if (28 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 28)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501018", "story_v_side_new_1109501.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501018", "story_v_side_new_1109501.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1109501", "1109501018", "story_v_side_new_1109501.awb")

						arg_73_1:RecordAudio("1109501018", var_76_9)
						arg_73_1:RecordAudio("1109501018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501018", "story_v_side_new_1109501.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501018", "story_v_side_new_1109501.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1109501019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109501019
		arg_77_1.duration_ = 1

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"

			SetActive(arg_77_1.choicesGo_, true)

			for iter_78_0, iter_78_1 in ipairs(arg_77_1.choices_) do
				SetActive(iter_78_1.go, iter_78_0 <= 2)
			end

			arg_77_1.choices_[1].txt.text = arg_77_1:FormatText(StoryChoiceCfg[709].name)
			arg_77_1.choices_[2].txt.text = arg_77_1:FormatText(StoryChoiceCfg[710].name)
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1109501020(arg_77_1)
			end

			if arg_79_0 == 2 then
				arg_77_0:Play1109501022(arg_77_1)
			end

			arg_77_1:RecordChoiceLog(1109501019, 709, 710)
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= 0 + 0.5 and arg_77_1.time_ < 0 + 0.5 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_0 = arg_77_1.actors_["1095ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_1 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 and not isNil(var_80_0) then
				if arg_77_1.var_.characterEffect1095ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_1)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1109501020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109501020
		arg_81_1.duration_ = 7.67

		local var_81_0 = {
			zh = 5.8,
			ja = 7.666
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109501021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1095ui_story"]) and arg_81_1.var_.characterEffect1095ui_story == nil then
				arg_81_1.var_.characterEffect1095ui_story = arg_81_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1095ui_story"]) then
				if arg_81_1.var_.characterEffect1095ui_story and not isNil(arg_81_1.actors_["1095ui_story"]) then
					arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1095ui_story"]) and arg_81_1.var_.characterEffect1095ui_story then
				arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_84_2 = 0
			local var_84_3 = 0.65

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(1109501020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 26 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 26)

				if (26 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 26)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501020", "story_v_side_new_1109501.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501020", "story_v_side_new_1109501.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_side_new_1109501", "1109501020", "story_v_side_new_1109501.awb")

						arg_81_1:RecordAudio("1109501020", var_84_9)
						arg_81_1:RecordAudio("1109501020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501020", "story_v_side_new_1109501.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501020", "story_v_side_new_1109501.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109501021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109501021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109501023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = arg_85_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) then
				if arg_85_1.var_.characterEffect1095ui_story and not isNil(arg_85_1.actors_["1095ui_story"]) then
					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story then
				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.575

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1109501021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 23 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 23)

				if (23 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 23)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109501023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109501023
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109501024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1095ui_story"]) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = arg_89_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1095ui_story"]) then
				if arg_89_1.var_.characterEffect1095ui_story and not isNil(arg_89_1.actors_["1095ui_story"]) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1095ui_story"]) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1095ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1095ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0, 100, 0)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = 0
			local var_92_4 = 0.825

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1109501023).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 33 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 33)

				if (33 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 33)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109501024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109501024
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109501025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1095ui_story"]) and arg_93_1.var_.characterEffect1095ui_story == nil then
				arg_93_1.var_.characterEffect1095ui_story = arg_93_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1095ui_story"]) then
				if arg_93_1.var_.characterEffect1095ui_story and not isNil(arg_93_1.actors_["1095ui_story"]) then
					arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1095ui_story"]) and arg_93_1.var_.characterEffect1095ui_story then
				arg_93_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1109501024).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 14 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 14)

				if (14 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 14)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109501025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109501025
		arg_97_1.duration_ = 2.2

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109501026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1095ui_story = arg_97_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).z)
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles = arg_97_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_97_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).z)
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles = arg_97_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1095ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1095ui_story == nil then
				arg_97_1.var_.characterEffect1095ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1095ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1095ui_story then
				arg_97_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(1109501025)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 6 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 6)

				if (6 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 6)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501025", "story_v_side_new_1109501.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501025", "story_v_side_new_1109501.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_new_1109501", "1109501025", "story_v_side_new_1109501.awb")

						arg_97_1:RecordAudio("1109501025", var_100_11)
						arg_97_1:RecordAudio("1109501025", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501025", "story_v_side_new_1109501.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501025", "story_v_side_new_1109501.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109501026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109501026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1109501027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1095ui_story"]) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = arg_101_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1095ui_story"]) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(arg_101_1.actors_["1095ui_story"]) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1095ui_story"]) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.4

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1109501026).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 16 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 16)

				if (16 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 16)) > 0 and var_104_2 < var_104_5 then
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
	Play1109501027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109501027
		arg_105_1.duration_ = 12.87

		local var_105_0 = {
			zh = 12.866,
			ja = 11.766
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109501028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1095ui_story"]) and arg_105_1.var_.characterEffect1095ui_story == nil then
				arg_105_1.var_.characterEffect1095ui_story = arg_105_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1095ui_story"]) then
				if arg_105_1.var_.characterEffect1095ui_story and not isNil(arg_105_1.actors_["1095ui_story"]) then
					arg_105_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1095ui_story"]) and arg_105_1.var_.characterEffect1095ui_story then
				arg_105_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_108_2 = 0
			local var_108_3 = 1.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(1109501027)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 57 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 57)

				if (57 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 57)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501027", "story_v_side_new_1109501.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501027", "story_v_side_new_1109501.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_new_1109501", "1109501027", "story_v_side_new_1109501.awb")

						arg_105_1:RecordAudio("1109501027", var_108_9)
						arg_105_1:RecordAudio("1109501027", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501027", "story_v_side_new_1109501.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501027", "story_v_side_new_1109501.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109501028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109501028
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109501029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1095ui_story"]) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = arg_109_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1095ui_story"]) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(arg_109_1.actors_["1095ui_story"]) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1095ui_story"]) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.2

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

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1109501028).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 8 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 8)

				if (8 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 8)) > 0 and var_112_2 < var_112_5 then
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
	Play1109501029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109501029
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1109501030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.075

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1109501029).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 43 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 43)

				if (43 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 43)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109501030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109501030
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109501031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.675

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1109501030).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 27 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 27)

				if (27 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 27)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109501031 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109501031
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109501032(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1109501031).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 10 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 10)

				if (10 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 10)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109501032 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109501032
		arg_125_1.duration_ = 4.4

		local var_125_0 = {
			zh = 3.7,
			ja = 4.4
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109501033(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1095ui_story = arg_125_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1095ui_story"].transform.position).z)
				arg_125_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1095ui_story"].transform.localEulerAngles = arg_125_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_125_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1095ui_story"].transform.position).z)
				arg_125_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1095ui_story"].transform.localEulerAngles = arg_125_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1095ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1095ui_story == nil then
				arg_125_1.var_.characterEffect1095ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1095ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1095ui_story then
				arg_125_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.275

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1109501032)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 11 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 11)

				if (11 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 11)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501032", "story_v_side_new_1109501.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501032", "story_v_side_new_1109501.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1109501", "1109501032", "story_v_side_new_1109501.awb")

						arg_125_1:RecordAudio("1109501032", var_128_11)
						arg_125_1:RecordAudio("1109501032", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501032", "story_v_side_new_1109501.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501032", "story_v_side_new_1109501.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109501033 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109501033
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109501034(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1095ui_story"]) and arg_129_1.var_.characterEffect1095ui_story == nil then
				arg_129_1.var_.characterEffect1095ui_story = arg_129_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1095ui_story"]) then
				if arg_129_1.var_.characterEffect1095ui_story and not isNil(arg_129_1.actors_["1095ui_story"]) then
					arg_129_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1095ui_story"]) and arg_129_1.var_.characterEffect1095ui_story then
				arg_129_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 1.075

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
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

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1109501033).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 43 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 43)

				if (43 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 43)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109501034 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109501034
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109501035(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.725

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1109501034).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 29 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 29)

				if (29 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 29)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109501035 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109501035
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109501036(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.85

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1109501035).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 30 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 30)

				if (30 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 30)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109501036 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109501036
		arg_141_1.duration_ = 6.07

		local var_141_0 = {
			zh = 1.999999999999,
			ja = 6.066
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1109501037(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1095ui_story = arg_141_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).z)
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles = arg_141_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_141_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1095ui_story"].transform.position).z)
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1095ui_story"].transform.localEulerAngles = arg_141_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1095ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1095ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1095ui_story then
				arg_141_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(1109501036)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 8 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 8)

				if (8 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 8)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501036", "story_v_side_new_1109501.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501036", "story_v_side_new_1109501.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_side_new_1109501", "1109501036", "story_v_side_new_1109501.awb")

						arg_141_1:RecordAudio("1109501036", var_144_11)
						arg_141_1:RecordAudio("1109501036", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501036", "story_v_side_new_1109501.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501036", "story_v_side_new_1109501.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109501037 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109501037
		arg_145_1.duration_ = 1

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"

			SetActive(arg_145_1.choicesGo_, true)

			for iter_146_0, iter_146_1 in ipairs(arg_145_1.choices_) do
				SetActive(iter_146_1.go, iter_146_0 <= 2)
			end

			arg_145_1.choices_[1].txt.text = arg_145_1:FormatText(StoryChoiceCfg[711].name)
			arg_145_1.choices_[2].txt.text = arg_145_1:FormatText(StoryChoiceCfg[712].name)
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1109501038(arg_145_1)
			end

			if arg_147_0 == 2 then
				arg_145_0:Play1109501038(arg_145_1)
			end

			arg_145_1:RecordChoiceLog(1109501037, 711, 712)
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = arg_145_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(arg_145_1.actors_["1095ui_story"]) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_1 + 0.5 and arg_145_1.time_ < var_148_1 + 0.5 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1109501038 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1109501038
		arg_149_1.duration_ = 12.77

		local var_149_0 = {
			zh = 7.033,
			ja = 12.766
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1109501039(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = arg_149_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) then
				if arg_149_1.var_.characterEffect1095ui_story and not isNil(arg_149_1.actors_["1095ui_story"]) then
					arg_149_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) and arg_149_1.var_.characterEffect1095ui_story then
				arg_149_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_152_2 = "1095ui_story"

			if arg_149_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_152_3 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_149_1.stage_.transform)

				var_152_3.name = var_152_2
				var_152_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_[var_152_2] = var_152_3

				local var_152_4 = var_152_3:GetComponentInChildren(typeof(CharacterEffect))

				var_152_4.enabled = true

				local var_152_5 = GameObjectTools.GetOrAddComponent(var_152_3, typeof(DynamicBoneHelper))

				if var_152_5 then
					var_152_5:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_4.transform, false)

				arg_149_1.var_[var_152_2 .. "Animator"] = var_152_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_[var_152_2 .. "Animator"].applyRootMotion = true
				arg_149_1.var_[var_152_2 .. "LipSync"] = var_152_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_152_6 = "1095ui_story"

			if arg_149_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_152_7 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_149_1.stage_.transform)

				var_152_7.name = var_152_6
				var_152_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_[var_152_6] = var_152_7

				local var_152_8 = var_152_7:GetComponentInChildren(typeof(CharacterEffect))

				var_152_8.enabled = true

				local var_152_9 = GameObjectTools.GetOrAddComponent(var_152_7, typeof(DynamicBoneHelper))

				if var_152_9 then
					var_152_9:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_8.transform, false)

				arg_149_1.var_[var_152_6 .. "Animator"] = var_152_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_[var_152_6 .. "Animator"].applyRootMotion = true
				arg_149_1.var_[var_152_6 .. "LipSync"] = var_152_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_152_10 = 0
			local var_152_11 = 0.675

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_12 = arg_149_1:GetWordFromCfg(1109501038)
				local var_152_13 = arg_149_1:FormatText(var_152_12.content)

				arg_149_1.text_.text = var_152_13

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 27 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 27)

				if (27 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 27)) > 0 and var_152_11 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_13
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501038", "story_v_side_new_1109501.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501038", "story_v_side_new_1109501.awb") / 1000

					if var_152_16 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_10
					end

					if var_152_12.prefab_name ~= "" and arg_149_1.actors_[var_152_12.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_12.prefab_name].transform, "story_v_side_new_1109501", "1109501038", "story_v_side_new_1109501.awb")

						arg_149_1:RecordAudio("1109501038", var_152_17)
						arg_149_1:RecordAudio("1109501038", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501038", "story_v_side_new_1109501.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501038", "story_v_side_new_1109501.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_18 and arg_149_1.time_ < var_152_10 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1109501039 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1109501039
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1109501040(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1095ui_story"]) and arg_153_1.var_.characterEffect1095ui_story == nil then
				arg_153_1.var_.characterEffect1095ui_story = arg_153_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1095ui_story"]) then
				if arg_153_1.var_.characterEffect1095ui_story and not isNil(arg_153_1.actors_["1095ui_story"]) then
					arg_153_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1095ui_story"]) and arg_153_1.var_.characterEffect1095ui_story then
				arg_153_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.15

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1109501039).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 6 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 6)

				if (6 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 6)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1109501040 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1109501040
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1109501041(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1109501040).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 27)

				if (27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 27)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1109501041 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1109501041
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1109501042(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.625

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1109501041).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 25 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 25)

				if (25 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 25)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1109501042 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109501042
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1109501043(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.35

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1109501042).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 14 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 14)

				if (14 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 14)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1109501043 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109501043
		arg_169_1.duration_ = 4.27

		local var_169_0 = {
			zh = 2.366,
			ja = 4.266
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1109501044(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1095ui_story = arg_169_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1095ui_story"].transform.position).z)
				arg_169_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1095ui_story"].transform.localEulerAngles = arg_169_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_169_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1095ui_story"].transform.position).z)
				arg_169_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1095ui_story"].transform.localEulerAngles = arg_169_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1095ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1095ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.125

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(1109501043)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 5 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 5)

				if (5 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 5)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501043", "story_v_side_new_1109501.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501043", "story_v_side_new_1109501.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_side_new_1109501", "1109501043", "story_v_side_new_1109501.awb")

						arg_169_1:RecordAudio("1109501043", var_172_11)
						arg_169_1:RecordAudio("1109501043", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501043", "story_v_side_new_1109501.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501043", "story_v_side_new_1109501.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109501044 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109501044
		arg_173_1.duration_ = 5.2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1109501045(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_176_0 = 0
			local var_176_1 = 0.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(1109501044)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 25 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 25)

				if (25 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 25)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501044", "story_v_side_new_1109501.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501044", "story_v_side_new_1109501.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_side_new_1109501", "1109501044", "story_v_side_new_1109501.awb")

						arg_173_1:RecordAudio("1109501044", var_176_7)
						arg_173_1:RecordAudio("1109501044", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501044", "story_v_side_new_1109501.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501044", "story_v_side_new_1109501.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109501045 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109501045
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1109501046(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = arg_177_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(arg_177_1.actors_["1095ui_story"]) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.4

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1109501045).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 16 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 16)

				if (16 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 16)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109501046 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109501046
		arg_181_1.duration_ = 2.93

		local var_181_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109501047(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1095ui_story"]) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = arg_181_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1095ui_story"]) then
				if arg_181_1.var_.characterEffect1095ui_story and not isNil(arg_181_1.actors_["1095ui_story"]) then
					arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1095ui_story"]) and arg_181_1.var_.characterEffect1095ui_story then
				arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_184_2 = 0
			local var_184_3 = 0.15

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(1109501046)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 6 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 6)

				if (6 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 6)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501046", "story_v_side_new_1109501.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501046", "story_v_side_new_1109501.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_side_new_1109501", "1109501046", "story_v_side_new_1109501.awb")

						arg_181_1:RecordAudio("1109501046", var_184_9)
						arg_181_1:RecordAudio("1109501046", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501046", "story_v_side_new_1109501.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501046", "story_v_side_new_1109501.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109501047 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1109501047
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1109501048(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) and arg_185_1.var_.characterEffect1095ui_story == nil then
				arg_185_1.var_.characterEffect1095ui_story = arg_185_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) then
				if arg_185_1.var_.characterEffect1095ui_story and not isNil(arg_185_1.actors_["1095ui_story"]) then
					arg_185_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) and arg_185_1.var_.characterEffect1095ui_story then
				arg_185_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 0.7

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
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

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1109501047).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 28 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 28)

				if (28 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 28)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1109501048 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1109501048
		arg_189_1.duration_ = 9

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1109501049(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.bgs_.STblack == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_192_0.name = "STblack"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.STblack = var_192_0
			end

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.STblack

				arg_189_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "STblack" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_4 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_5 = 2

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_5 then
				local var_192_6 = Color.New(0, 0, 0)

				var_192_6.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(0, 0, 0)

				var_192_7.a = 1
				arg_189_1.mask_.color = var_192_7
			end

			local var_192_8 = 2

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 then
				local var_192_10 = Color.New(0, 0, 0)

				var_192_10.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_8) / var_192_9)
				arg_189_1.mask_.color = var_192_10
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 then
				local var_192_11 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_11.a = 0
				arg_189_1.mask_.color = var_192_11
			end

			local var_192_12 = arg_189_1.actors_["1095ui_story"].transform

			if 1.96599999815226 < arg_189_1.time_ and arg_189_1.time_ <= 1.96599999815226 + arg_192_0 then
				arg_189_1.var_.moveOldPos1095ui_story = var_192_12.localPosition
			end

			local var_192_13 = 0.001

			if 1.96599999815226 <= arg_189_1.time_ and arg_189_1.time_ < 1.96599999815226 + var_192_13 then
				var_192_12.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 1.96599999815226) / var_192_13)
				var_192_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_12.position).x, (manager.ui.mainCamera.transform.position - var_192_12.position).y, (manager.ui.mainCamera.transform.position - var_192_12.position).z)
				var_192_12.localEulerAngles.z = 0
				var_192_12.localEulerAngles.x = 0
				var_192_12.localEulerAngles = var_192_12.localEulerAngles
			end

			if arg_189_1.time_ >= 1.96599999815226 + var_192_13 and arg_189_1.time_ < 1.96599999815226 + var_192_13 + arg_192_0 then
				var_192_12.localPosition = Vector3.New(0, 100, 0)
				var_192_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_12.position).x, (manager.ui.mainCamera.transform.position - var_192_12.position).y, (manager.ui.mainCamera.transform.position - var_192_12.position).z)
				var_192_12.localEulerAngles.z = 0
				var_192_12.localEulerAngles.x = 0
				var_192_12.localEulerAngles = var_192_12.localEulerAngles
			end

			local var_192_14 = arg_189_1.actors_["1095ui_story"]

			if 1.96599999815226 < arg_189_1.time_ and arg_189_1.time_ <= 1.96599999815226 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = var_192_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_15 = 0.034000001847744

			if 1.96599999815226 <= arg_189_1.time_ and arg_189_1.time_ < 1.96599999815226 + var_192_15 and not isNil(var_192_14) then
				if arg_189_1.var_.characterEffect1095ui_story and not isNil(var_192_14) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 1.96599999815226) / var_192_15)
				end
			end

			if arg_189_1.time_ >= 1.96599999815226 + var_192_15 and arg_189_1.time_ < 1.96599999815226 + var_192_15 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_16 = 4
			local var_192_17 = 0.1

			if 4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_18 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_18:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_19 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1109501048).content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_21 = 4 <= 0 and var_192_17 or var_192_17 * (utf8.len(var_192_19) / 4)

				if (4 <= 0 and var_192_17 or var_192_17 * (utf8.len(var_192_19) / 4)) > 0 and var_192_17 < var_192_21 then
					arg_189_1.talkMaxDuration = var_192_21
					var_192_16 = var_192_16 + 0.3

					if var_192_21 + var_192_16 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_21 + var_192_16
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = var_192_16 + 0.3
			local var_192_23 = math.max(var_192_17, arg_189_1.talkMaxDuration)

			if var_192_16 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_23 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_22) / var_192_23

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_22 + var_192_23 and arg_189_1.time_ < var_192_22 + var_192_23 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play1109501049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109501049
		arg_195_1.duration_ = 7.07

		local var_195_0 = {
			zh = 5.4,
			ja = 7.066
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109501050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				local var_198_0 = arg_195_1.bgs_.ST12

				arg_195_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_198_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_1 = var_198_0:GetComponent("SpriteRenderer")

				if var_198_1 and var_198_1.sprite then
					local var_198_2 = 2 * (var_198_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_198_0.transform.localScale = Vector3.New(var_198_2 / var_198_1.sprite.bounds.size.y < var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x and var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x or var_198_2 / var_198_1.sprite.bounds.size.y, var_198_2 / var_198_1.sprite.bounds.size.y < var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x and var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x or var_198_2 / var_198_1.sprite.bounds.size.y, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "ST12" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_3 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_4 = 2

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_4 then
				local var_198_5 = Color.New(0, 0, 0)

				var_198_5.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_3) / var_198_4)
				arg_195_1.mask_.color = var_198_5
			end

			if arg_195_1.time_ >= var_198_3 + var_198_4 and arg_195_1.time_ < var_198_3 + var_198_4 + arg_198_0 then
				local var_198_6 = Color.New(0, 0, 0)

				arg_195_1.mask_.enabled = false
				var_198_6.a = 0
				arg_195_1.mask_.color = var_198_6
			end

			local var_198_7 = arg_195_1.actors_["1095ui_story"].transform

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				arg_195_1.var_.moveOldPos1095ui_story = var_198_7.localPosition
			end

			local var_198_8 = 0.001

			if 2 <= arg_195_1.time_ and arg_195_1.time_ < 2 + var_198_8 then
				var_198_7.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_195_1.time_ - 2) / var_198_8)
				var_198_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_7.position).x, (manager.ui.mainCamera.transform.position - var_198_7.position).y, (manager.ui.mainCamera.transform.position - var_198_7.position).z)
				var_198_7.localEulerAngles.z = 0
				var_198_7.localEulerAngles.x = 0
				var_198_7.localEulerAngles = var_198_7.localEulerAngles
			end

			if arg_195_1.time_ >= 2 + var_198_8 and arg_195_1.time_ < 2 + var_198_8 + arg_198_0 then
				var_198_7.localPosition = Vector3.New(0, -0.98, -6.1)
				var_198_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_7.position).x, (manager.ui.mainCamera.transform.position - var_198_7.position).y, (manager.ui.mainCamera.transform.position - var_198_7.position).z)
				var_198_7.localEulerAngles.z = 0
				var_198_7.localEulerAngles.x = 0
				var_198_7.localEulerAngles = var_198_7.localEulerAngles
			end

			local var_198_9 = arg_195_1.actors_["1095ui_story"]

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1095ui_story == nil then
				arg_195_1.var_.characterEffect1095ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_10 = 0.200000002980232

			if 2 <= arg_195_1.time_ and arg_195_1.time_ < 2 + var_198_10 and not isNil(var_198_9) then
				if arg_195_1.var_.characterEffect1095ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 2 + var_198_10 and arg_195_1.time_ < 2 + var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1095ui_story then
				arg_195_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				arg_195_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				arg_195_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_12 = 2
			local var_198_13 = 0.425

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_14 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_14:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_15 = arg_195_1:GetWordFromCfg(1109501049)
				local var_198_16 = arg_195_1:FormatText(var_198_15.content)

				arg_195_1.text_.text = var_198_16

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_18 = 17 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_16) / 17)

				if (17 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_16) / 17)) > 0 and var_198_13 < var_198_18 then
					arg_195_1.talkMaxDuration = var_198_18
					var_198_12 = var_198_12 + 0.3

					if var_198_18 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_18 + var_198_12
					end
				end

				arg_195_1.text_.text = var_198_16
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501049", "story_v_side_new_1109501.awb") ~= 0 then
					local var_198_19 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501049", "story_v_side_new_1109501.awb") / 1000

					if var_198_19 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_19 + var_198_12
					end

					if var_198_15.prefab_name ~= "" and arg_195_1.actors_[var_198_15.prefab_name] ~= nil then
						local var_198_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_15.prefab_name].transform, "story_v_side_new_1109501", "1109501049", "story_v_side_new_1109501.awb")

						arg_195_1:RecordAudio("1109501049", var_198_20)
						arg_195_1:RecordAudio("1109501049", var_198_20)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501049", "story_v_side_new_1109501.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501049", "story_v_side_new_1109501.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_21 = var_198_12 + 0.3
			local var_198_22 = math.max(var_198_13, arg_195_1.talkMaxDuration)

			if var_198_12 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_22 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_21) / var_198_22

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_21 + var_198_22 and arg_195_1.time_ < var_198_21 + var_198_22 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play1109501050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109501050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109501051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1095ui_story"]) and arg_201_1.var_.characterEffect1095ui_story == nil then
				arg_201_1.var_.characterEffect1095ui_story = arg_201_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1095ui_story"]) then
				if arg_201_1.var_.characterEffect1095ui_story and not isNil(arg_201_1.actors_["1095ui_story"]) then
					arg_201_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1095ui_story"]) and arg_201_1.var_.characterEffect1095ui_story then
				arg_201_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.075

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

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1109501050).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 3 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 3)

				if (3 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 3)) > 0 and var_204_2 < var_204_5 then
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
	Play1109501051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109501051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109501052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.6

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1109501051).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 64 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 64)

				if (64 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 64)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109501052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109501052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109501053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.65

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
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

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1109501052).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 26 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 26)

				if (26 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 26)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109501053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109501053
		arg_213_1.duration_ = 5.77

		local var_213_0 = {
			zh = 3.366,
			ja = 5.766
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1109501054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1095ui_story = arg_213_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1095ui_story"].transform.position).z)
				arg_213_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1095ui_story"].transform.localEulerAngles = arg_213_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_213_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1095ui_story"].transform.position).z)
				arg_213_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1095ui_story"].transform.localEulerAngles = arg_213_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1095ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1095ui_story == nil then
				arg_213_1.var_.characterEffect1095ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1095ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1095ui_story then
				arg_213_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.375

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(1109501053)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 15 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 15)

				if (15 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 15)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501053", "story_v_side_new_1109501.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501053", "story_v_side_new_1109501.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1109501", "1109501053", "story_v_side_new_1109501.awb")

						arg_213_1:RecordAudio("1109501053", var_216_11)
						arg_213_1:RecordAudio("1109501053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501053", "story_v_side_new_1109501.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501053", "story_v_side_new_1109501.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109501054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109501054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109501055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1095ui_story"]) and arg_217_1.var_.characterEffect1095ui_story == nil then
				arg_217_1.var_.characterEffect1095ui_story = arg_217_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1095ui_story"]) then
				if arg_217_1.var_.characterEffect1095ui_story and not isNil(arg_217_1.actors_["1095ui_story"]) then
					arg_217_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1095ui_story"]) and arg_217_1.var_.characterEffect1095ui_story then
				arg_217_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.2

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1109501054).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 8 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 8)

				if (8 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 8)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109501055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109501055
		arg_221_1.duration_ = 5.63

		local var_221_0 = {
			zh = 2,
			ja = 5.633
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109501056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) and arg_221_1.var_.characterEffect1095ui_story == nil then
				arg_221_1.var_.characterEffect1095ui_story = arg_221_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) then
				if arg_221_1.var_.characterEffect1095ui_story and not isNil(arg_221_1.actors_["1095ui_story"]) then
					arg_221_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) and arg_221_1.var_.characterEffect1095ui_story then
				arg_221_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_224_2 = 0
			local var_224_3 = 0.25

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1109501055)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 10 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 10)

				if (10 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 10)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501055", "story_v_side_new_1109501.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501055", "story_v_side_new_1109501.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1109501", "1109501055", "story_v_side_new_1109501.awb")

						arg_221_1:RecordAudio("1109501055", var_224_9)
						arg_221_1:RecordAudio("1109501055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501055", "story_v_side_new_1109501.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501055", "story_v_side_new_1109501.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109501056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109501056
		arg_225_1.duration_ = 4.37

		local var_225_0 = {
			zh = 2.033,
			ja = 4.366
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109501057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.2

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(1109501056)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 8 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 8)

				if (8 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 8)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501056", "story_v_side_new_1109501.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501056", "story_v_side_new_1109501.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_side_new_1109501", "1109501056", "story_v_side_new_1109501.awb")

						arg_225_1:RecordAudio("1109501056", var_228_6)
						arg_225_1:RecordAudio("1109501056", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501056", "story_v_side_new_1109501.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501056", "story_v_side_new_1109501.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109501057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109501057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109501058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1095ui_story"]) and arg_229_1.var_.characterEffect1095ui_story == nil then
				arg_229_1.var_.characterEffect1095ui_story = arg_229_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1095ui_story"]) then
				if arg_229_1.var_.characterEffect1095ui_story and not isNil(arg_229_1.actors_["1095ui_story"]) then
					arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1095ui_story"]) and arg_229_1.var_.characterEffect1095ui_story then
				arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.2

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1109501057).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 8 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 8)

				if (8 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 8)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109501058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109501058
		arg_233_1.duration_ = 5

		local var_233_0 = {
			zh = 1.566,
			ja = 5
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109501059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1095ui_story"]) and arg_233_1.var_.characterEffect1095ui_story == nil then
				arg_233_1.var_.characterEffect1095ui_story = arg_233_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1095ui_story"]) then
				if arg_233_1.var_.characterEffect1095ui_story and not isNil(arg_233_1.actors_["1095ui_story"]) then
					arg_233_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1095ui_story"]) and arg_233_1.var_.characterEffect1095ui_story then
				arg_233_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_236_2 = 0
			local var_236_3 = 0.175

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(1109501058)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 7 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 7)

				if (7 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 7)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501058", "story_v_side_new_1109501.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501058", "story_v_side_new_1109501.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_side_new_1109501", "1109501058", "story_v_side_new_1109501.awb")

						arg_233_1:RecordAudio("1109501058", var_236_9)
						arg_233_1:RecordAudio("1109501058", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501058", "story_v_side_new_1109501.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501058", "story_v_side_new_1109501.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109501059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109501059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109501060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1095ui_story"]) and arg_237_1.var_.characterEffect1095ui_story == nil then
				arg_237_1.var_.characterEffect1095ui_story = arg_237_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1095ui_story"]) then
				if arg_237_1.var_.characterEffect1095ui_story and not isNil(arg_237_1.actors_["1095ui_story"]) then
					arg_237_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1095ui_story"]) and arg_237_1.var_.characterEffect1095ui_story then
				arg_237_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 1.225

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1109501059).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 49 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 49)

				if (49 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 49)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109501060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109501060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1109501061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.475

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1109501060).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 19 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 19)

				if (19 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 19)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109501061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1109501061
		arg_245_1.duration_ = 2.8

		local var_245_0 = {
			zh = 2.8,
			ja = 2.633
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1109501062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1095ui_story = arg_245_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).z)
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles = arg_245_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_245_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).z)
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles = arg_245_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1095ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1095ui_story == nil then
				arg_245_1.var_.characterEffect1095ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1095ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1095ui_story then
				arg_245_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_248_4 = 0
			local var_248_5 = 0.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(1109501061)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 5 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 5)

				if (5 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 5)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501061", "story_v_side_new_1109501.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501061", "story_v_side_new_1109501.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_side_new_1109501", "1109501061", "story_v_side_new_1109501.awb")

						arg_245_1:RecordAudio("1109501061", var_248_11)
						arg_245_1:RecordAudio("1109501061", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501061", "story_v_side_new_1109501.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501061", "story_v_side_new_1109501.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1109501062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109501062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109501063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1095ui_story"]) and arg_249_1.var_.characterEffect1095ui_story == nil then
				arg_249_1.var_.characterEffect1095ui_story = arg_249_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1095ui_story"]) then
				if arg_249_1.var_.characterEffect1095ui_story and not isNil(arg_249_1.actors_["1095ui_story"]) then
					arg_249_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1095ui_story"]) and arg_249_1.var_.characterEffect1095ui_story then
				arg_249_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 1.275

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1109501062).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 51 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 51)

				if (51 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 51)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109501063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109501063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109501064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_256_0 = arg_253_1.actors_["1095ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1095ui_story = var_256_0.localPosition
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_1)
				var_256_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_0.position).x, (manager.ui.mainCamera.transform.position - var_256_0.position).y, (manager.ui.mainCamera.transform.position - var_256_0.position).z)
				var_256_0.localEulerAngles.z = 0
				var_256_0.localEulerAngles.x = 0
				var_256_0.localEulerAngles = var_256_0.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, 100, 0)
				var_256_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_0.position).x, (manager.ui.mainCamera.transform.position - var_256_0.position).y, (manager.ui.mainCamera.transform.position - var_256_0.position).z)
				var_256_0.localEulerAngles.z = 0
				var_256_0.localEulerAngles.x = 0
				var_256_0.localEulerAngles = var_256_0.localEulerAngles
			end

			local var_256_2 = 0
			local var_256_3 = 0.15

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_4 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1109501063).content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 6 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_4) / 6)

				if (6 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_4) / 6)) > 0 and var_256_3 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_7 and arg_253_1.time_ < var_256_2 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1109501064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109501064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109501065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_260_0 = 0.6

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				local var_260_1, var_260_2 = math.modf((arg_257_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_260_2 * 0.13, var_260_2 * 0.13, var_260_2 * 0.13) + arg_257_1.var_.shakeOldPos
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				manager.ui.mainCamera.transform.localPosition = arg_257_1.var_.shakeOldPos
			end

			local var_260_3 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.allBtn_.enabled = false
			end

			if arg_257_1.time_ >= var_260_3 + 0.6 and arg_257_1.time_ < var_260_3 + 0.6 + arg_260_0 then
				arg_257_1.allBtn_.enabled = true
			end

			local var_260_4 = 0
			local var_260_5 = 0.85

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1109501064).content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_8 = 34 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 34)

				if (34 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 34)) > 0 and var_260_5 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8

					if var_260_8 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_9 and arg_257_1.time_ < var_260_4 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109501065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109501065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109501066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.575

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1109501065).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 23 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 23)

				if (23 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 23)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1109501066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109501066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1109501067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.4

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1109501066).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 16 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 16)

				if (16 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 16)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1109501067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1109501067
		arg_269_1.duration_ = 4.53

		local var_269_0 = {
			zh = 4.5,
			ja = 4.533
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1109501068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1095ui_story = arg_269_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1095ui_story"].transform.position).z)
				arg_269_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1095ui_story"].transform.localEulerAngles = arg_269_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_269_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1095ui_story"].transform.position).z)
				arg_269_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1095ui_story"].transform.localEulerAngles = arg_269_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1095ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1095ui_story == nil then
				arg_269_1.var_.characterEffect1095ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1095ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1095ui_story then
				arg_269_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_272_4 = 0
			local var_272_5 = 0.475

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(1109501067)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 19 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 19)

				if (19 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 19)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501067", "story_v_side_new_1109501.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501067", "story_v_side_new_1109501.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_side_new_1109501", "1109501067", "story_v_side_new_1109501.awb")

						arg_269_1:RecordAudio("1109501067", var_272_11)
						arg_269_1:RecordAudio("1109501067", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501067", "story_v_side_new_1109501.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501067", "story_v_side_new_1109501.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1109501068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1109501068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1109501069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1095ui_story"]) and arg_273_1.var_.characterEffect1095ui_story == nil then
				arg_273_1.var_.characterEffect1095ui_story = arg_273_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1095ui_story"]) then
				if arg_273_1.var_.characterEffect1095ui_story and not isNil(arg_273_1.actors_["1095ui_story"]) then
					arg_273_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1095ui_story"]) and arg_273_1.var_.characterEffect1095ui_story then
				arg_273_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.675

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

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1109501068).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 27 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 27)

				if (27 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 27)) > 0 and var_276_2 < var_276_5 then
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

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1109501069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1109501069
		arg_277_1.duration_ = 10.4

		local var_277_0 = {
			zh = 6,
			ja = 10.4
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1109501070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1095ui_story"]) and arg_277_1.var_.characterEffect1095ui_story == nil then
				arg_277_1.var_.characterEffect1095ui_story = arg_277_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1095ui_story"]) then
				if arg_277_1.var_.characterEffect1095ui_story and not isNil(arg_277_1.actors_["1095ui_story"]) then
					arg_277_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1095ui_story"]) and arg_277_1.var_.characterEffect1095ui_story then
				arg_277_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_280_2 = 0
			local var_280_3 = 0.7

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_4 = arg_277_1:GetWordFromCfg(1109501069)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 28 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 28)

				if (28 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 28)) > 0 and var_280_3 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501069", "story_v_side_new_1109501.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501069", "story_v_side_new_1109501.awb") / 1000

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_side_new_1109501", "1109501069", "story_v_side_new_1109501.awb")

						arg_277_1:RecordAudio("1109501069", var_280_9)
						arg_277_1:RecordAudio("1109501069", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501069", "story_v_side_new_1109501.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501069", "story_v_side_new_1109501.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_10 and arg_277_1.time_ < var_280_2 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1109501070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1109501070
		arg_281_1.duration_ = 6.2

		local var_281_0 = {
			zh = 6.20000000298023,
			ja = 6.199999999999
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1109501071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if arg_281_1.bgs_.ST17 == nil then
				local var_284_0 = Object.Instantiate(arg_281_1.paintGo_)

				var_284_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_284_0.name = "ST17"
				var_284_0.transform.parent = arg_281_1.stage_.transform
				var_284_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.bgs_.ST17 = var_284_0
			end

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				local var_284_1 = arg_281_1.bgs_.ST17

				arg_281_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_284_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_2 = var_284_1:GetComponent("SpriteRenderer")

				if var_284_2 and var_284_2.sprite then
					local var_284_3 = 2 * (var_284_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_284_1.transform.localScale = Vector3.New(var_284_3 / var_284_2.sprite.bounds.size.y < var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x and var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x or var_284_3 / var_284_2.sprite.bounds.size.y, var_284_3 / var_284_2.sprite.bounds.size.y < var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x and var_284_3 * manager.ui.mainCameraCom_.aspect / var_284_2.sprite.bounds.size.x or var_284_3 / var_284_2.sprite.bounds.size.y, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "ST17" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_4 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_5 = 2

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_5 then
				local var_284_6 = Color.New(0, 0, 0)

				var_284_6.a = Mathf.Lerp(0, 1, (arg_281_1.time_ - var_284_4) / var_284_5)
				arg_281_1.mask_.color = var_284_6
			end

			if arg_281_1.time_ >= var_284_4 + var_284_5 and arg_281_1.time_ < var_284_4 + var_284_5 + arg_284_0 then
				local var_284_7 = Color.New(0, 0, 0)

				var_284_7.a = 1
				arg_281_1.mask_.color = var_284_7
			end

			local var_284_8 = 2

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_9 = 2

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 then
				local var_284_10 = Color.New(0, 0, 0)

				var_284_10.a = Mathf.Lerp(1, 0, (arg_281_1.time_ - var_284_8) / var_284_9)
				arg_281_1.mask_.color = var_284_10
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 then
				local var_284_11 = Color.New(0, 0, 0)

				arg_281_1.mask_.enabled = false
				var_284_11.a = 0
				arg_281_1.mask_.color = var_284_11
			end

			local var_284_12 = arg_281_1.actors_["1095ui_story"].transform

			if 1.96599999815226 < arg_281_1.time_ and arg_281_1.time_ <= 1.96599999815226 + arg_284_0 then
				arg_281_1.var_.moveOldPos1095ui_story = var_284_12.localPosition
			end

			local var_284_13 = 0.001

			if 1.96599999815226 <= arg_281_1.time_ and arg_281_1.time_ < 1.96599999815226 + var_284_13 then
				var_284_12.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 1.96599999815226) / var_284_13)
				var_284_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_12.position).x, (manager.ui.mainCamera.transform.position - var_284_12.position).y, (manager.ui.mainCamera.transform.position - var_284_12.position).z)
				var_284_12.localEulerAngles.z = 0
				var_284_12.localEulerAngles.x = 0
				var_284_12.localEulerAngles = var_284_12.localEulerAngles
			end

			if arg_281_1.time_ >= 1.96599999815226 + var_284_13 and arg_281_1.time_ < 1.96599999815226 + var_284_13 + arg_284_0 then
				var_284_12.localPosition = Vector3.New(0, 100, 0)
				var_284_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_12.position).x, (manager.ui.mainCamera.transform.position - var_284_12.position).y, (manager.ui.mainCamera.transform.position - var_284_12.position).z)
				var_284_12.localEulerAngles.z = 0
				var_284_12.localEulerAngles.x = 0
				var_284_12.localEulerAngles = var_284_12.localEulerAngles
			end

			local var_284_14 = arg_281_1.actors_["1095ui_story"].transform

			if 3.8 < arg_281_1.time_ and arg_281_1.time_ <= 3.8 + arg_284_0 then
				arg_281_1.var_.moveOldPos1095ui_story = var_284_14.localPosition
			end

			local var_284_15 = 0.001

			if 3.8 <= arg_281_1.time_ and arg_281_1.time_ < 3.8 + var_284_15 then
				var_284_14.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_281_1.time_ - 3.8) / var_284_15)
				var_284_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_14.position).x, (manager.ui.mainCamera.transform.position - var_284_14.position).y, (manager.ui.mainCamera.transform.position - var_284_14.position).z)
				var_284_14.localEulerAngles.z = 0
				var_284_14.localEulerAngles.x = 0
				var_284_14.localEulerAngles = var_284_14.localEulerAngles
			end

			if arg_281_1.time_ >= 3.8 + var_284_15 and arg_281_1.time_ < 3.8 + var_284_15 + arg_284_0 then
				var_284_14.localPosition = Vector3.New(0, -0.98, -6.1)
				var_284_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_14.position).x, (manager.ui.mainCamera.transform.position - var_284_14.position).y, (manager.ui.mainCamera.transform.position - var_284_14.position).z)
				var_284_14.localEulerAngles.z = 0
				var_284_14.localEulerAngles.x = 0
				var_284_14.localEulerAngles = var_284_14.localEulerAngles
			end

			local var_284_16 = arg_281_1.actors_["1095ui_story"]

			if 3.8 < arg_281_1.time_ and arg_281_1.time_ <= 3.8 + arg_284_0 and not isNil(var_284_16) and arg_281_1.var_.characterEffect1095ui_story == nil then
				arg_281_1.var_.characterEffect1095ui_story = var_284_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_17 = 0.200000002980232

			if 3.8 <= arg_281_1.time_ and arg_281_1.time_ < 3.8 + var_284_17 and not isNil(var_284_16) then
				if arg_281_1.var_.characterEffect1095ui_story and not isNil(var_284_16) then
					arg_281_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 3.8 + var_284_17 and arg_281_1.time_ < 3.8 + var_284_17 + arg_284_0 and not isNil(var_284_16) and arg_281_1.var_.characterEffect1095ui_story then
				arg_281_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 3.8 < arg_281_1.time_ and arg_281_1.time_ <= 3.8 + arg_284_0 then
				arg_281_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 3.8 < arg_281_1.time_ and arg_281_1.time_ <= 3.8 + arg_284_0 then
				arg_281_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1.63333333333333 < arg_281_1.time_ and arg_281_1.time_ <= 1.63333333333333 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_shop_loop", "")
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_20 = 4.00000000298023
			local var_284_21 = 0.2

			if 4.00000000298023 < arg_281_1.time_ and arg_281_1.time_ <= var_284_20 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_22 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_22:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_23 = arg_281_1:GetWordFromCfg(1109501070)
				local var_284_24 = arg_281_1:FormatText(var_284_23.content)

				arg_281_1.text_.text = var_284_24

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_26 = 8 <= 0 and var_284_21 or var_284_21 * (utf8.len(var_284_24) / 8)

				if (8 <= 0 and var_284_21 or var_284_21 * (utf8.len(var_284_24) / 8)) > 0 and var_284_21 < var_284_26 then
					arg_281_1.talkMaxDuration = var_284_26
					var_284_20 = var_284_20 + 0.3

					if var_284_26 + var_284_20 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_26 + var_284_20
					end
				end

				arg_281_1.text_.text = var_284_24
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501070", "story_v_side_new_1109501.awb") ~= 0 then
					local var_284_27 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501070", "story_v_side_new_1109501.awb") / 1000

					if var_284_27 + var_284_20 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_27 + var_284_20
					end

					if var_284_23.prefab_name ~= "" and arg_281_1.actors_[var_284_23.prefab_name] ~= nil then
						local var_284_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_23.prefab_name].transform, "story_v_side_new_1109501", "1109501070", "story_v_side_new_1109501.awb")

						arg_281_1:RecordAudio("1109501070", var_284_28)
						arg_281_1:RecordAudio("1109501070", var_284_28)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501070", "story_v_side_new_1109501.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501070", "story_v_side_new_1109501.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_29 = var_284_20 + 0.3
			local var_284_30 = math.max(var_284_21, arg_281_1.talkMaxDuration)

			if var_284_20 + 0.3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_29 + var_284_30 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_29) / var_284_30

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_29 + var_284_30 and arg_281_1.time_ < var_284_29 + var_284_30 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1109501071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1109501071
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1109501072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1095ui_story"]) and arg_287_1.var_.characterEffect1095ui_story == nil then
				arg_287_1.var_.characterEffect1095ui_story = arg_287_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1095ui_story"]) then
				if arg_287_1.var_.characterEffect1095ui_story and not isNil(arg_287_1.actors_["1095ui_story"]) then
					arg_287_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1095ui_story"]) and arg_287_1.var_.characterEffect1095ui_story then
				arg_287_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.375

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1109501071).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 15 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 15)

				if (15 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 15)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1109501072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1109501072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1109501073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.725

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1109501072).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 29 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 29)

				if (29 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 29)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1109501073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109501073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1109501074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.3

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1109501073).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 12 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 12)

				if (12 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 12)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1109501074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109501074
		arg_299_1.duration_ = 4.73

		local var_299_0 = {
			zh = 4.733,
			ja = 4.133
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1109501075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1095ui_story = arg_299_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).z)
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles = arg_299_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_299_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).z)
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles = arg_299_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1095ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1095ui_story == nil then
				arg_299_1.var_.characterEffect1095ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1095ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1095ui_story then
				arg_299_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.525

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(1109501074)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 21 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 21)

				if (21 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 21)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501074", "story_v_side_new_1109501.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501074", "story_v_side_new_1109501.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_side_new_1109501", "1109501074", "story_v_side_new_1109501.awb")

						arg_299_1:RecordAudio("1109501074", var_302_11)
						arg_299_1:RecordAudio("1109501074", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501074", "story_v_side_new_1109501.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501074", "story_v_side_new_1109501.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play1109501075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1109501075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1109501076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1095ui_story"]) and arg_303_1.var_.characterEffect1095ui_story == nil then
				arg_303_1.var_.characterEffect1095ui_story = arg_303_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1095ui_story"]) then
				if arg_303_1.var_.characterEffect1095ui_story and not isNil(arg_303_1.actors_["1095ui_story"]) then
					arg_303_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1095ui_story"]) and arg_303_1.var_.characterEffect1095ui_story then
				arg_303_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.325

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1109501075).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 13 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 13)

				if (13 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 13)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1109501076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1109501076
		arg_307_1.duration_ = 6.17

		local var_307_0 = {
			zh = 4.166,
			ja = 6.166
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1109501077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1095ui_story"]) and arg_307_1.var_.characterEffect1095ui_story == nil then
				arg_307_1.var_.characterEffect1095ui_story = arg_307_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1095ui_story"]) then
				if arg_307_1.var_.characterEffect1095ui_story and not isNil(arg_307_1.actors_["1095ui_story"]) then
					arg_307_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1095ui_story"]) and arg_307_1.var_.characterEffect1095ui_story then
				arg_307_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_310_2 = 0
			local var_310_3 = 0.35

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(1109501076)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 14 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 14)

				if (14 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 14)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501076", "story_v_side_new_1109501.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501076", "story_v_side_new_1109501.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1109501", "1109501076", "story_v_side_new_1109501.awb")

						arg_307_1:RecordAudio("1109501076", var_310_9)
						arg_307_1:RecordAudio("1109501076", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501076", "story_v_side_new_1109501.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501076", "story_v_side_new_1109501.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1109501077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1109501077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1109501078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1095ui_story"]) and arg_311_1.var_.characterEffect1095ui_story == nil then
				arg_311_1.var_.characterEffect1095ui_story = arg_311_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1095ui_story"]) then
				if arg_311_1.var_.characterEffect1095ui_story and not isNil(arg_311_1.actors_["1095ui_story"]) then
					arg_311_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1095ui_story"]) and arg_311_1.var_.characterEffect1095ui_story then
				arg_311_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.125

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1109501077).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 5 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 5)

				if (5 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 5)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1109501078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1109501078
		arg_315_1.duration_ = 13.83

		local var_315_0 = {
			zh = 8.733,
			ja = 13.833
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1109501079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1095ui_story = arg_315_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1095ui_story"].transform.position).z)
				arg_315_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1095ui_story"].transform.localEulerAngles = arg_315_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_315_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1095ui_story"].transform.position).z)
				arg_315_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1095ui_story"].transform.localEulerAngles = arg_315_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1095ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1095ui_story == nil then
				arg_315_1.var_.characterEffect1095ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1095ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1095ui_story then
				arg_315_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_318_4 = 0
			local var_318_5 = 1.075

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_6 = arg_315_1:GetWordFromCfg(1109501078)
				local var_318_7 = arg_315_1:FormatText(var_318_6.content)

				arg_315_1.text_.text = var_318_7

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_9 = 43 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 43)

				if (43 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 43)) > 0 and var_318_5 < var_318_9 then
					arg_315_1.talkMaxDuration = var_318_9

					if var_318_9 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_4
					end
				end

				arg_315_1.text_.text = var_318_7
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501078", "story_v_side_new_1109501.awb") ~= 0 then
					local var_318_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501078", "story_v_side_new_1109501.awb") / 1000

					if var_318_10 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_4
					end

					if var_318_6.prefab_name ~= "" and arg_315_1.actors_[var_318_6.prefab_name] ~= nil then
						local var_318_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_6.prefab_name].transform, "story_v_side_new_1109501", "1109501078", "story_v_side_new_1109501.awb")

						arg_315_1:RecordAudio("1109501078", var_318_11)
						arg_315_1:RecordAudio("1109501078", var_318_11)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501078", "story_v_side_new_1109501.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501078", "story_v_side_new_1109501.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_5, arg_315_1.talkMaxDuration)

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_4) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_4 + var_318_12 and arg_315_1.time_ < var_318_4 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play1109501079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1109501079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1109501080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1095ui_story"]) and arg_319_1.var_.characterEffect1095ui_story == nil then
				arg_319_1.var_.characterEffect1095ui_story = arg_319_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1095ui_story"]) then
				if arg_319_1.var_.characterEffect1095ui_story and not isNil(arg_319_1.actors_["1095ui_story"]) then
					arg_319_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1095ui_story"]) and arg_319_1.var_.characterEffect1095ui_story then
				arg_319_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.375

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1109501079).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 15 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 15)

				if (15 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 15)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1109501080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1109501080
		arg_323_1.duration_ = 4.5

		local var_323_0 = {
			zh = 3.766,
			ja = 4.5
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1109501081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1095ui_story"]) and arg_323_1.var_.characterEffect1095ui_story == nil then
				arg_323_1.var_.characterEffect1095ui_story = arg_323_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1095ui_story"]) then
				if arg_323_1.var_.characterEffect1095ui_story and not isNil(arg_323_1.actors_["1095ui_story"]) then
					arg_323_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1095ui_story"]) and arg_323_1.var_.characterEffect1095ui_story then
				arg_323_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_326_2 = 0
			local var_326_3 = 0.3

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(1109501080)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 11 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 11)

				if (11 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 11)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501080", "story_v_side_new_1109501.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501080", "story_v_side_new_1109501.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_side_new_1109501", "1109501080", "story_v_side_new_1109501.awb")

						arg_323_1:RecordAudio("1109501080", var_326_9)
						arg_323_1:RecordAudio("1109501080", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501080", "story_v_side_new_1109501.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501080", "story_v_side_new_1109501.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1109501081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1109501081
		arg_327_1.duration_ = 1

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"

			SetActive(arg_327_1.choicesGo_, true)

			for iter_328_0, iter_328_1 in ipairs(arg_327_1.choices_) do
				SetActive(iter_328_1.go, iter_328_0 <= 2)
			end

			arg_327_1.choices_[1].txt.text = arg_327_1:FormatText(StoryChoiceCfg[713].name)
			arg_327_1.choices_[2].txt.text = arg_327_1:FormatText(StoryChoiceCfg[714].name)
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1109501082(arg_327_1)
			end

			if arg_329_0 == 2 then
				arg_327_0:Play1109501084(arg_327_1)
			end

			arg_327_1:RecordChoiceLog(1109501081, 713, 714)
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.allBtn_.enabled = false
			end

			if arg_327_1.time_ >= 0 + 0.5 and arg_327_1.time_ < 0 + 0.5 + arg_330_0 then
				arg_327_1.allBtn_.enabled = true
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1109501082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1109501082
		arg_331_1.duration_ = 2.33

		local var_331_0 = {
			zh = 1.2,
			ja = 2.333
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1109501083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1095ui_story"]) and arg_331_1.var_.characterEffect1095ui_story == nil then
				arg_331_1.var_.characterEffect1095ui_story = arg_331_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1095ui_story"]) then
				if arg_331_1.var_.characterEffect1095ui_story and not isNil(arg_331_1.actors_["1095ui_story"]) then
					arg_331_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1095ui_story"]) and arg_331_1.var_.characterEffect1095ui_story then
				arg_331_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_334_2 = 0
			local var_334_3 = 0.1

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:GetWordFromCfg(1109501082)
				local var_334_5 = arg_331_1:FormatText(var_334_4.content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 4 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 4)

				if (4 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 4)) > 0 and var_334_3 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_2
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501082", "story_v_side_new_1109501.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501082", "story_v_side_new_1109501.awb") / 1000

					if var_334_8 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_2
					end

					if var_334_4.prefab_name ~= "" and arg_331_1.actors_[var_334_4.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_4.prefab_name].transform, "story_v_side_new_1109501", "1109501082", "story_v_side_new_1109501.awb")

						arg_331_1:RecordAudio("1109501082", var_334_9)
						arg_331_1:RecordAudio("1109501082", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501082", "story_v_side_new_1109501.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501082", "story_v_side_new_1109501.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_3, arg_331_1.talkMaxDuration)

			if var_334_2 <= arg_331_1.time_ and arg_331_1.time_ < var_334_2 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_2) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_2 + var_334_10 and arg_331_1.time_ < var_334_2 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1109501083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1109501083
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1109501084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1095ui_story"]) and arg_335_1.var_.characterEffect1095ui_story == nil then
				arg_335_1.var_.characterEffect1095ui_story = arg_335_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1095ui_story"]) then
				if arg_335_1.var_.characterEffect1095ui_story and not isNil(arg_335_1.actors_["1095ui_story"]) then
					arg_335_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1095ui_story"]) and arg_335_1.var_.characterEffect1095ui_story then
				arg_335_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.575

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1109501083).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 23 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 23)

				if (23 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 23)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1109501084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1109501084
		arg_339_1.duration_ = 3.37

		local var_339_0 = {
			zh = 3.366,
			ja = 2.933
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1109501085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1095ui_story"]) and arg_339_1.var_.characterEffect1095ui_story == nil then
				arg_339_1.var_.characterEffect1095ui_story = arg_339_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1095ui_story"]) then
				if arg_339_1.var_.characterEffect1095ui_story and not isNil(arg_339_1.actors_["1095ui_story"]) then
					arg_339_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1095ui_story"]) and arg_339_1.var_.characterEffect1095ui_story then
				arg_339_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_342_2 = "1095ui_story"

			if arg_339_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_342_3 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_339_1.stage_.transform)

				var_342_3.name = var_342_2
				var_342_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.actors_[var_342_2] = var_342_3

				local var_342_4 = var_342_3:GetComponentInChildren(typeof(CharacterEffect))

				var_342_4.enabled = true

				local var_342_5 = GameObjectTools.GetOrAddComponent(var_342_3, typeof(DynamicBoneHelper))

				if var_342_5 then
					var_342_5:EnableDynamicBone(false)
				end

				arg_339_1:ShowWeapon(var_342_4.transform, false)

				arg_339_1.var_[var_342_2 .. "Animator"] = var_342_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_339_1.var_[var_342_2 .. "Animator"].applyRootMotion = true
				arg_339_1.var_[var_342_2 .. "LipSync"] = var_342_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_342_6 = 0
			local var_342_7 = 0.2

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(1109501084)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 8 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 8)

				if (8 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 8)) > 0 and var_342_7 < var_342_11 then
					arg_339_1.talkMaxDuration = var_342_11

					if var_342_11 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501084", "story_v_side_new_1109501.awb") ~= 0 then
					local var_342_12 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501084", "story_v_side_new_1109501.awb") / 1000

					if var_342_12 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_6
					end

					if var_342_8.prefab_name ~= "" and arg_339_1.actors_[var_342_8.prefab_name] ~= nil then
						local var_342_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_8.prefab_name].transform, "story_v_side_new_1109501", "1109501084", "story_v_side_new_1109501.awb")

						arg_339_1:RecordAudio("1109501084", var_342_13)
						arg_339_1:RecordAudio("1109501084", var_342_13)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501084", "story_v_side_new_1109501.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501084", "story_v_side_new_1109501.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1109501085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1109501085
		arg_343_1.duration_ = 5.77

		local var_343_0 = {
			zh = 2.8,
			ja = 5.766
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1109501086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_346_0 = 0
			local var_346_1 = 0.25

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:GetWordFromCfg(1109501085)
				local var_346_3 = arg_343_1:FormatText(var_346_2.content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 10 <= 0 and var_346_1 or var_346_1 * (utf8.len(var_346_3) / 10)

				if (10 <= 0 and var_346_1 or var_346_1 * (utf8.len(var_346_3) / 10)) > 0 and var_346_1 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501085", "story_v_side_new_1109501.awb") ~= 0 then
					local var_346_6 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501085", "story_v_side_new_1109501.awb") / 1000

					if var_346_6 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_0
					end

					if var_346_2.prefab_name ~= "" and arg_343_1.actors_[var_346_2.prefab_name] ~= nil then
						local var_346_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_2.prefab_name].transform, "story_v_side_new_1109501", "1109501085", "story_v_side_new_1109501.awb")

						arg_343_1:RecordAudio("1109501085", var_346_7)
						arg_343_1:RecordAudio("1109501085", var_346_7)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501085", "story_v_side_new_1109501.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501085", "story_v_side_new_1109501.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_8 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_8 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_8

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_8 and arg_343_1.time_ < var_346_0 + var_346_8 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1109501086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1109501086
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1109501087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1095ui_story"]) and arg_347_1.var_.characterEffect1095ui_story == nil then
				arg_347_1.var_.characterEffect1095ui_story = arg_347_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1095ui_story"]) then
				if arg_347_1.var_.characterEffect1095ui_story and not isNil(arg_347_1.actors_["1095ui_story"]) then
					arg_347_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1095ui_story"]) and arg_347_1.var_.characterEffect1095ui_story then
				arg_347_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.85

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1109501086).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 34 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 34)

				if (34 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 34)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1109501087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1109501087
		arg_351_1.duration_ = 4.63

		local var_351_0 = {
			zh = 4.266,
			ja = 4.633
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1109501088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1095ui_story = arg_351_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1095ui_story"].transform.position).z)
				arg_351_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1095ui_story"].transform.localEulerAngles = arg_351_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_351_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1095ui_story"].transform.position).z)
				arg_351_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1095ui_story"].transform.localEulerAngles = arg_351_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["1095ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1095ui_story == nil then
				arg_351_1.var_.characterEffect1095ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1095ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1095ui_story then
				arg_351_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_354_4 = 0
			local var_354_5 = 0.5

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(1109501087)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 20 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 20)

				if (20 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 20)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501087", "story_v_side_new_1109501.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501087", "story_v_side_new_1109501.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_side_new_1109501", "1109501087", "story_v_side_new_1109501.awb")

						arg_351_1:RecordAudio("1109501087", var_354_11)
						arg_351_1:RecordAudio("1109501087", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501087", "story_v_side_new_1109501.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501087", "story_v_side_new_1109501.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play1109501088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1109501088
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1109501089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1095ui_story"]) and arg_355_1.var_.characterEffect1095ui_story == nil then
				arg_355_1.var_.characterEffect1095ui_story = arg_355_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1095ui_story"]) then
				if arg_355_1.var_.characterEffect1095ui_story and not isNil(arg_355_1.actors_["1095ui_story"]) then
					arg_355_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1095ui_story"]) and arg_355_1.var_.characterEffect1095ui_story then
				arg_355_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.65

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1109501088).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 26 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 26)

				if (26 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 26)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1109501089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1109501089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1109501090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1095ui_story"]) and arg_359_1.var_.characterEffect1095ui_story == nil then
				arg_359_1.var_.characterEffect1095ui_story = arg_359_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1095ui_story"]) then
				if arg_359_1.var_.characterEffect1095ui_story and not isNil(arg_359_1.actors_["1095ui_story"]) then
					arg_359_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1095ui_story"]) and arg_359_1.var_.characterEffect1095ui_story then
				arg_359_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_362_1 = 0
			local var_362_2 = 0.2

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1109501089).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 8 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 8)

				if (8 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 8)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_6 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_6 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_6

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_6 and arg_359_1.time_ < var_362_1 + var_362_6 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1109501090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109501090
		arg_363_1.duration_ = 6.5

		local var_363_0 = {
			zh = 4.033,
			ja = 6.5
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109501091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1095ui_story"]) and arg_363_1.var_.characterEffect1095ui_story == nil then
				arg_363_1.var_.characterEffect1095ui_story = arg_363_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1095ui_story"]) then
				if arg_363_1.var_.characterEffect1095ui_story and not isNil(arg_363_1.actors_["1095ui_story"]) then
					arg_363_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1095ui_story"]) and arg_363_1.var_.characterEffect1095ui_story then
				arg_363_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_366_2 = 0
			local var_366_3 = 0.425

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_4 = arg_363_1:GetWordFromCfg(1109501090)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 17 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 17)

				if (17 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 17)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501090", "story_v_side_new_1109501.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501090", "story_v_side_new_1109501.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_side_new_1109501", "1109501090", "story_v_side_new_1109501.awb")

						arg_363_1:RecordAudio("1109501090", var_366_9)
						arg_363_1:RecordAudio("1109501090", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501090", "story_v_side_new_1109501.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501090", "story_v_side_new_1109501.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1109501091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109501091
		arg_367_1.duration_ = 12.13

		local var_367_0 = {
			zh = 9.366,
			ja = 12.133
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1109501092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1095ui_story = arg_367_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1095ui_story"].transform.position).z)
				arg_367_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1095ui_story"].transform.localEulerAngles = arg_367_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_367_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1095ui_story"].transform.position).z)
				arg_367_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1095ui_story"].transform.localEulerAngles = arg_367_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1095ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1095ui_story == nil then
				arg_367_1.var_.characterEffect1095ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1095ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1095ui_story then
				arg_367_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action442")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_370_4 = 0
			local var_370_5 = 1.1

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(1109501091)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 44 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 44)

				if (44 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 44)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501091", "story_v_side_new_1109501.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501091", "story_v_side_new_1109501.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_new_1109501", "1109501091", "story_v_side_new_1109501.awb")

						arg_367_1:RecordAudio("1109501091", var_370_11)
						arg_367_1:RecordAudio("1109501091", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501091", "story_v_side_new_1109501.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501091", "story_v_side_new_1109501.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play1109501092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109501092
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1109501093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1095ui_story"]) and arg_371_1.var_.characterEffect1095ui_story == nil then
				arg_371_1.var_.characterEffect1095ui_story = arg_371_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1095ui_story"]) then
				if arg_371_1.var_.characterEffect1095ui_story and not isNil(arg_371_1.actors_["1095ui_story"]) then
					arg_371_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1095ui_story"]) and arg_371_1.var_.characterEffect1095ui_story then
				arg_371_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.35

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1109501092).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 14 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 14)

				if (14 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 14)) > 0 and var_374_2 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_6 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_6 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_6

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_6 and arg_371_1.time_ < var_374_1 + var_374_6 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109501093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109501093
		arg_375_1.duration_ = 7.67

		local var_375_0 = {
			zh = 4.833,
			ja = 7.666
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109501094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1095ui_story = arg_375_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1095ui_story"].transform.position).z)
				arg_375_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1095ui_story"].transform.localEulerAngles = arg_375_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_375_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1095ui_story"].transform.position).z)
				arg_375_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1095ui_story"].transform.localEulerAngles = arg_375_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1095ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1095ui_story == nil then
				arg_375_1.var_.characterEffect1095ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1095ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1095ui_story then
				arg_375_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_378_4 = 0
			local var_378_5 = 0.75

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(1109501093)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 30 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 30)

				if (30 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 30)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501093", "story_v_side_new_1109501.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501093", "story_v_side_new_1109501.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_side_new_1109501", "1109501093", "story_v_side_new_1109501.awb")

						arg_375_1:RecordAudio("1109501093", var_378_11)
						arg_375_1:RecordAudio("1109501093", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501093", "story_v_side_new_1109501.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501093", "story_v_side_new_1109501.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109501094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109501094
		arg_379_1.duration_ = 3.87

		local var_379_0 = {
			zh = 3.3,
			ja = 3.866
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1109501095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.4

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:GetWordFromCfg(1109501094)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 16 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 16)

				if (16 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 16)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501094", "story_v_side_new_1109501.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501094", "story_v_side_new_1109501.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_side_new_1109501", "1109501094", "story_v_side_new_1109501.awb")

						arg_379_1:RecordAudio("1109501094", var_382_6)
						arg_379_1:RecordAudio("1109501094", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501094", "story_v_side_new_1109501.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501094", "story_v_side_new_1109501.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1109501095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109501095
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109501096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1095ui_story"]) and arg_383_1.var_.characterEffect1095ui_story == nil then
				arg_383_1.var_.characterEffect1095ui_story = arg_383_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1095ui_story"]) then
				if arg_383_1.var_.characterEffect1095ui_story and not isNil(arg_383_1.actors_["1095ui_story"]) then
					arg_383_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1095ui_story"]) and arg_383_1.var_.characterEffect1095ui_story then
				arg_383_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.225

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1109501095).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 9 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 9)

				if (9 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 9)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109501096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109501096
		arg_387_1.duration_ = 5.03

		local var_387_0 = {
			zh = 3.6,
			ja = 5.033
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109501097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1095ui_story"]) and arg_387_1.var_.characterEffect1095ui_story == nil then
				arg_387_1.var_.characterEffect1095ui_story = arg_387_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1095ui_story"]) then
				if arg_387_1.var_.characterEffect1095ui_story and not isNil(arg_387_1.actors_["1095ui_story"]) then
					arg_387_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1095ui_story"]) and arg_387_1.var_.characterEffect1095ui_story then
				arg_387_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_390_2 = 0
			local var_390_3 = 0.35

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:GetWordFromCfg(1109501096)
				local var_390_5 = arg_387_1:FormatText(var_390_4.content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 14 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 14)

				if (14 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 14)) > 0 and var_390_3 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501096", "story_v_side_new_1109501.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501096", "story_v_side_new_1109501.awb") / 1000

					if var_390_8 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_2
					end

					if var_390_4.prefab_name ~= "" and arg_387_1.actors_[var_390_4.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_4.prefab_name].transform, "story_v_side_new_1109501", "1109501096", "story_v_side_new_1109501.awb")

						arg_387_1:RecordAudio("1109501096", var_390_9)
						arg_387_1:RecordAudio("1109501096", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501096", "story_v_side_new_1109501.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501096", "story_v_side_new_1109501.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_10 and arg_387_1.time_ < var_390_2 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109501097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109501097
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109501098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1095ui_story"]) and arg_391_1.var_.characterEffect1095ui_story == nil then
				arg_391_1.var_.characterEffect1095ui_story = arg_391_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1095ui_story"]) then
				if arg_391_1.var_.characterEffect1095ui_story and not isNil(arg_391_1.actors_["1095ui_story"]) then
					arg_391_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1095ui_story"]) and arg_391_1.var_.characterEffect1095ui_story then
				arg_391_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_394_1 = arg_391_1.actors_["1095ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1095ui_story = var_394_1.localPosition
			end

			local var_394_2 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 then
				var_394_1.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_2)
				var_394_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_1.position).x, (manager.ui.mainCamera.transform.position - var_394_1.position).y, (manager.ui.mainCamera.transform.position - var_394_1.position).z)
				var_394_1.localEulerAngles.z = 0
				var_394_1.localEulerAngles.x = 0
				var_394_1.localEulerAngles = var_394_1.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 then
				var_394_1.localPosition = Vector3.New(0, 100, 0)
				var_394_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_1.position).x, (manager.ui.mainCamera.transform.position - var_394_1.position).y, (manager.ui.mainCamera.transform.position - var_394_1.position).z)
				var_394_1.localEulerAngles.z = 0
				var_394_1.localEulerAngles.x = 0
				var_394_1.localEulerAngles = var_394_1.localEulerAngles
			end

			local var_394_3 = 0
			local var_394_4 = 0.875

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_5 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1109501097).content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 35 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_5) / 35)

				if (35 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_5) / 35)) > 0 and var_394_4 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_3 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_3
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_4, arg_391_1.talkMaxDuration)

			if var_394_3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_3 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_3) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_3 + var_394_8 and arg_391_1.time_ < var_394_3 + var_394_8 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109501098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109501098
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1109501099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.15

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1109501098).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 6 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 6)

				if (6 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 6)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1109501099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109501099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109501100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.6

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1109501099).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 24 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 24)

				if (24 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 24)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109501100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1109501100
		arg_403_1.duration_ = 2.13

		local var_403_0 = {
			zh = 2.133,
			ja = 1.999999999999
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1109501101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1095ui_story = arg_403_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).z)
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles = arg_403_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_403_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1095ui_story"].transform.position).z)
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1095ui_story"].transform.localEulerAngles = arg_403_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1095ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1095ui_story == nil then
				arg_403_1.var_.characterEffect1095ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1095ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1095ui_story then
				arg_403_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.225

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(1109501100)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 9 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 9)

				if (9 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 9)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501100", "story_v_side_new_1109501.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501100", "story_v_side_new_1109501.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_new_1109501", "1109501100", "story_v_side_new_1109501.awb")

						arg_403_1:RecordAudio("1109501100", var_406_11)
						arg_403_1:RecordAudio("1109501100", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501100", "story_v_side_new_1109501.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501100", "story_v_side_new_1109501.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1109501101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1109501101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1109501102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1095ui_story"]) and arg_407_1.var_.characterEffect1095ui_story == nil then
				arg_407_1.var_.characterEffect1095ui_story = arg_407_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1095ui_story"]) then
				if arg_407_1.var_.characterEffect1095ui_story and not isNil(arg_407_1.actors_["1095ui_story"]) then
					arg_407_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1095ui_story"]) and arg_407_1.var_.characterEffect1095ui_story then
				arg_407_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 0.075

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1109501101).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 3 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 3)

				if (3 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 3)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1109501102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1109501102
		arg_411_1.duration_ = 1.73

		local var_411_0 = {
			zh = 1.3,
			ja = 1.733
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1109501103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1095ui_story"]) and arg_411_1.var_.characterEffect1095ui_story == nil then
				arg_411_1.var_.characterEffect1095ui_story = arg_411_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1095ui_story"]) then
				if arg_411_1.var_.characterEffect1095ui_story and not isNil(arg_411_1.actors_["1095ui_story"]) then
					arg_411_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1095ui_story"]) and arg_411_1.var_.characterEffect1095ui_story then
				arg_411_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_414_2 = 0
			local var_414_3 = 0.1

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_2 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_4 = arg_411_1:GetWordFromCfg(1109501102)
				local var_414_5 = arg_411_1:FormatText(var_414_4.content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_7 = 4 <= 0 and var_414_3 or var_414_3 * (utf8.len(var_414_5) / 4)

				if (4 <= 0 and var_414_3 or var_414_3 * (utf8.len(var_414_5) / 4)) > 0 and var_414_3 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_2 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_2
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501102", "story_v_side_new_1109501.awb") ~= 0 then
					local var_414_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501102", "story_v_side_new_1109501.awb") / 1000

					if var_414_8 + var_414_2 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_2
					end

					if var_414_4.prefab_name ~= "" and arg_411_1.actors_[var_414_4.prefab_name] ~= nil then
						local var_414_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_4.prefab_name].transform, "story_v_side_new_1109501", "1109501102", "story_v_side_new_1109501.awb")

						arg_411_1:RecordAudio("1109501102", var_414_9)
						arg_411_1:RecordAudio("1109501102", var_414_9)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501102", "story_v_side_new_1109501.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501102", "story_v_side_new_1109501.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_10 = math.max(var_414_3, arg_411_1.talkMaxDuration)

			if var_414_2 <= arg_411_1.time_ and arg_411_1.time_ < var_414_2 + var_414_10 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_2) / var_414_10

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_2 + var_414_10 and arg_411_1.time_ < var_414_2 + var_414_10 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1109501103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1109501103
		arg_415_1.duration_ = 1

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"

			SetActive(arg_415_1.choicesGo_, true)

			for iter_416_0, iter_416_1 in ipairs(arg_415_1.choices_) do
				SetActive(iter_416_1.go, iter_416_0 <= 1)
			end

			arg_415_1.choices_[1].txt.text = arg_415_1:FormatText(StoryChoiceCfg[715].name)
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1109501104(arg_415_1)
			end

			arg_415_1:RecordChoiceLog(1109501103, 715)
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			if arg_415_1.time_ >= 0 + 0.5 and arg_415_1.time_ < 0 + 0.5 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_0 = arg_415_1.actors_["1095ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1095ui_story == nil then
				arg_415_1.var_.characterEffect1095ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_1 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_1 and not isNil(var_418_0) then
				if arg_415_1.var_.characterEffect1095ui_story and not isNil(var_418_0) then
					arg_415_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_1)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_1 and arg_415_1.time_ < 0 + var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1095ui_story then
				arg_415_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1109501104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1109501104
		arg_419_1.duration_ = 3.03

		local var_419_0 = {
			zh = 2.6,
			ja = 3.033
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1109501105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1095ui_story = arg_419_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1095ui_story"].transform.position).z)
				arg_419_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1095ui_story"].transform.localEulerAngles = arg_419_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_419_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1095ui_story"].transform.position).z)
				arg_419_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1095ui_story"].transform.localEulerAngles = arg_419_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1095ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1095ui_story == nil then
				arg_419_1.var_.characterEffect1095ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1095ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1095ui_story then
				arg_419_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_422_4 = 0
			local var_422_5 = 0.2

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(1109501104)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 8 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 8)

				if (8 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 8)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501104", "story_v_side_new_1109501.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501104", "story_v_side_new_1109501.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_side_new_1109501", "1109501104", "story_v_side_new_1109501.awb")

						arg_419_1:RecordAudio("1109501104", var_422_11)
						arg_419_1:RecordAudio("1109501104", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501104", "story_v_side_new_1109501.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501104", "story_v_side_new_1109501.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1109501105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1109501105
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1109501106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1095ui_story"]) and arg_423_1.var_.characterEffect1095ui_story == nil then
				arg_423_1.var_.characterEffect1095ui_story = arg_423_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1095ui_story"]) then
				if arg_423_1.var_.characterEffect1095ui_story and not isNil(arg_423_1.actors_["1095ui_story"]) then
					arg_423_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1095ui_story"]) and arg_423_1.var_.characterEffect1095ui_story then
				arg_423_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.6

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1109501105).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 24 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 24)

				if (24 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 24)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1109501106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109501106
		arg_427_1.duration_ = 4

		local var_427_0 = {
			zh = 3.566,
			ja = 4
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109501107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1095ui_story"]) and arg_427_1.var_.characterEffect1095ui_story == nil then
				arg_427_1.var_.characterEffect1095ui_story = arg_427_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1095ui_story"]) then
				if arg_427_1.var_.characterEffect1095ui_story and not isNil(arg_427_1.actors_["1095ui_story"]) then
					arg_427_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1095ui_story"]) and arg_427_1.var_.characterEffect1095ui_story then
				arg_427_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_430_2 = 0
			local var_430_3 = 0.275

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_4 = arg_427_1:GetWordFromCfg(1109501106)
				local var_430_5 = arg_427_1:FormatText(var_430_4.content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 11 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 11)

				if (11 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 11)) > 0 and var_430_3 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_2
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501106", "story_v_side_new_1109501.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501106", "story_v_side_new_1109501.awb") / 1000

					if var_430_8 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_2
					end

					if var_430_4.prefab_name ~= "" and arg_427_1.actors_[var_430_4.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_4.prefab_name].transform, "story_v_side_new_1109501", "1109501106", "story_v_side_new_1109501.awb")

						arg_427_1:RecordAudio("1109501106", var_430_9)
						arg_427_1:RecordAudio("1109501106", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501106", "story_v_side_new_1109501.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501106", "story_v_side_new_1109501.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_3, arg_427_1.talkMaxDuration)

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_2) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_2 + var_430_10 and arg_427_1.time_ < var_430_2 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1109501107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109501107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109501108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1095ui_story"]) and arg_431_1.var_.characterEffect1095ui_story == nil then
				arg_431_1.var_.characterEffect1095ui_story = arg_431_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1095ui_story"]) then
				if arg_431_1.var_.characterEffect1095ui_story and not isNil(arg_431_1.actors_["1095ui_story"]) then
					arg_431_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1095ui_story"]) and arg_431_1.var_.characterEffect1095ui_story then
				arg_431_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.125

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1109501107).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 5 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 5)

				if (5 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 5)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109501108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109501108
		arg_435_1.duration_ = 2.8

		local var_435_0 = {
			zh = 1.2,
			ja = 2.8
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109501109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1095ui_story"]) and arg_435_1.var_.characterEffect1095ui_story == nil then
				arg_435_1.var_.characterEffect1095ui_story = arg_435_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1095ui_story"]) then
				if arg_435_1.var_.characterEffect1095ui_story and not isNil(arg_435_1.actors_["1095ui_story"]) then
					arg_435_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1095ui_story"]) and arg_435_1.var_.characterEffect1095ui_story then
				arg_435_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_438_2 = 0
			local var_438_3 = 0.1

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:GetWordFromCfg(1109501108)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 4 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 4)

				if (4 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 4)) > 0 and var_438_3 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501108", "story_v_side_new_1109501.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501108", "story_v_side_new_1109501.awb") / 1000

					if var_438_8 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_2
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_side_new_1109501", "1109501108", "story_v_side_new_1109501.awb")

						arg_435_1:RecordAudio("1109501108", var_438_9)
						arg_435_1:RecordAudio("1109501108", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501108", "story_v_side_new_1109501.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501108", "story_v_side_new_1109501.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_10 and arg_435_1.time_ < var_438_2 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109501109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109501109
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109501110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1095ui_story"]) and arg_439_1.var_.characterEffect1095ui_story == nil then
				arg_439_1.var_.characterEffect1095ui_story = arg_439_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1095ui_story"]) then
				if arg_439_1.var_.characterEffect1095ui_story and not isNil(arg_439_1.actors_["1095ui_story"]) then
					arg_439_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1095ui_story"]) and arg_439_1.var_.characterEffect1095ui_story then
				arg_439_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 0.6

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1109501109).content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 24 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 24)

				if (24 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 24)) > 0 and var_442_2 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_6 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_6 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_6

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_6 and arg_439_1.time_ < var_442_1 + var_442_6 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109501110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109501110
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109501111(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.075

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1109501110).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 3 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 3)

				if (3 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 3)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1109501111 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109501111
		arg_447_1.duration_ = 4.2

		local var_447_0 = {
			zh = 2.4,
			ja = 4.2
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109501112(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1095ui_story = arg_447_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_450_0 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_447_1.time_ - 0) / var_450_0)
				arg_447_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1095ui_story"].transform.position).z)
				arg_447_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1095ui_story"].transform.localEulerAngles = arg_447_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_447_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1095ui_story"].transform.position).z)
				arg_447_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1095ui_story"].transform.localEulerAngles = arg_447_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_450_1 = arg_447_1.actors_["1095ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1095ui_story == nil then
				arg_447_1.var_.characterEffect1095ui_story = var_450_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_2 and not isNil(var_450_1) then
				if arg_447_1.var_.characterEffect1095ui_story and not isNil(var_450_1) then
					arg_447_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_2 and arg_447_1.time_ < 0 + var_450_2 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1095ui_story then
				arg_447_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_450_4 = 0
			local var_450_5 = 0.25

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_6 = arg_447_1:GetWordFromCfg(1109501111)
				local var_450_7 = arg_447_1:FormatText(var_450_6.content)

				arg_447_1.text_.text = var_450_7

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_9 = 10 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 10)

				if (10 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 10)) > 0 and var_450_5 < var_450_9 then
					arg_447_1.talkMaxDuration = var_450_9

					if var_450_9 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_4
					end
				end

				arg_447_1.text_.text = var_450_7
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501111", "story_v_side_new_1109501.awb") ~= 0 then
					local var_450_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501111", "story_v_side_new_1109501.awb") / 1000

					if var_450_10 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_4
					end

					if var_450_6.prefab_name ~= "" and arg_447_1.actors_[var_450_6.prefab_name] ~= nil then
						local var_450_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_6.prefab_name].transform, "story_v_side_new_1109501", "1109501111", "story_v_side_new_1109501.awb")

						arg_447_1:RecordAudio("1109501111", var_450_11)
						arg_447_1:RecordAudio("1109501111", var_450_11)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501111", "story_v_side_new_1109501.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501111", "story_v_side_new_1109501.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_12 = math.max(var_450_5, arg_447_1.talkMaxDuration)

			if var_450_4 <= arg_447_1.time_ and arg_447_1.time_ < var_450_4 + var_450_12 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_4) / var_450_12

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_4 + var_450_12 and arg_447_1.time_ < var_450_4 + var_450_12 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109501112 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109501112
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109501113(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1095ui_story"]) and arg_451_1.var_.characterEffect1095ui_story == nil then
				arg_451_1.var_.characterEffect1095ui_story = arg_451_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1095ui_story"]) then
				if arg_451_1.var_.characterEffect1095ui_story and not isNil(arg_451_1.actors_["1095ui_story"]) then
					arg_451_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_0)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1095ui_story"]) and arg_451_1.var_.characterEffect1095ui_story then
				arg_451_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_454_1 = 0
			local var_454_2 = 0.175

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(1109501112).content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 7 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 7)

				if (7 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 7)) > 0 and var_454_2 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_6 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_6 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_6

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_6 and arg_451_1.time_ < var_454_1 + var_454_6 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109501113 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109501113
		arg_455_1.duration_ = 5.4

		local var_455_0 = {
			zh = 1.999999999999,
			ja = 5.4
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109501114(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["1095ui_story"]) and arg_455_1.var_.characterEffect1095ui_story == nil then
				arg_455_1.var_.characterEffect1095ui_story = arg_455_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["1095ui_story"]) then
				if arg_455_1.var_.characterEffect1095ui_story and not isNil(arg_455_1.actors_["1095ui_story"]) then
					arg_455_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["1095ui_story"]) and arg_455_1.var_.characterEffect1095ui_story then
				arg_455_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_458_2 = 0
			local var_458_3 = 0.175

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_2 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_4 = arg_455_1:GetWordFromCfg(1109501113)
				local var_458_5 = arg_455_1:FormatText(var_458_4.content)

				arg_455_1.text_.text = var_458_5

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 7 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_5) / 7)

				if (7 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_5) / 7)) > 0 and var_458_3 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_2
					end
				end

				arg_455_1.text_.text = var_458_5
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501113", "story_v_side_new_1109501.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501113", "story_v_side_new_1109501.awb") / 1000

					if var_458_8 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_2
					end

					if var_458_4.prefab_name ~= "" and arg_455_1.actors_[var_458_4.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_4.prefab_name].transform, "story_v_side_new_1109501", "1109501113", "story_v_side_new_1109501.awb")

						arg_455_1:RecordAudio("1109501113", var_458_9)
						arg_455_1:RecordAudio("1109501113", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501113", "story_v_side_new_1109501.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501113", "story_v_side_new_1109501.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_3, arg_455_1.talkMaxDuration)

			if var_458_2 <= arg_455_1.time_ and arg_455_1.time_ < var_458_2 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_2) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_2 + var_458_10 and arg_455_1.time_ < var_458_2 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1109501114 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109501114
		arg_459_1.duration_ = 9

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109501115(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if arg_459_1.bgs_.ST02 == nil then
				local var_462_0 = Object.Instantiate(arg_459_1.paintGo_)

				var_462_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_462_0.name = "ST02"
				var_462_0.transform.parent = arg_459_1.stage_.transform
				var_462_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_459_1.bgs_.ST02 = var_462_0
			end

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= 2 + arg_462_0 then
				local var_462_1 = arg_459_1.bgs_.ST02

				arg_459_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_462_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_462_2 = var_462_1:GetComponent("SpriteRenderer")

				if var_462_2 and var_462_2.sprite then
					local var_462_3 = 2 * (var_462_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_462_1.transform.localScale = Vector3.New(var_462_3 / var_462_2.sprite.bounds.size.y < var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x and var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x or var_462_3 / var_462_2.sprite.bounds.size.y, var_462_3 / var_462_2.sprite.bounds.size.y < var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x and var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x or var_462_3 / var_462_2.sprite.bounds.size.y, 0)
				end

				for iter_462_0, iter_462_1 in pairs(arg_459_1.bgs_) do
					if iter_462_0 ~= "ST02" then
						iter_462_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_462_4 = 0

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_5 = 2

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_5 then
				local var_462_6 = Color.New(0, 0, 0)

				var_462_6.a = Mathf.Lerp(0, 1, (arg_459_1.time_ - var_462_4) / var_462_5)
				arg_459_1.mask_.color = var_462_6
			end

			if arg_459_1.time_ >= var_462_4 + var_462_5 and arg_459_1.time_ < var_462_4 + var_462_5 + arg_462_0 then
				local var_462_7 = Color.New(0, 0, 0)

				var_462_7.a = 1
				arg_459_1.mask_.color = var_462_7
			end

			local var_462_8 = 2

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= var_462_8 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_9 = 2

			if var_462_8 <= arg_459_1.time_ and arg_459_1.time_ < var_462_8 + var_462_9 then
				local var_462_10 = Color.New(0, 0, 0)

				var_462_10.a = Mathf.Lerp(1, 0, (arg_459_1.time_ - var_462_8) / var_462_9)
				arg_459_1.mask_.color = var_462_10
			end

			if arg_459_1.time_ >= var_462_8 + var_462_9 and arg_459_1.time_ < var_462_8 + var_462_9 + arg_462_0 then
				local var_462_11 = Color.New(0, 0, 0)

				arg_459_1.mask_.enabled = false
				var_462_11.a = 0
				arg_459_1.mask_.color = var_462_11
			end

			local var_462_12 = arg_459_1.actors_["1095ui_story"].transform

			if 1.966 < arg_459_1.time_ and arg_459_1.time_ <= 1.966 + arg_462_0 then
				arg_459_1.var_.moveOldPos1095ui_story = var_462_12.localPosition
			end

			local var_462_13 = 0.001

			if 1.966 <= arg_459_1.time_ and arg_459_1.time_ < 1.966 + var_462_13 then
				var_462_12.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_459_1.time_ - 1.966) / var_462_13)
				var_462_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_462_12.position).x, (manager.ui.mainCamera.transform.position - var_462_12.position).y, (manager.ui.mainCamera.transform.position - var_462_12.position).z)
				var_462_12.localEulerAngles.z = 0
				var_462_12.localEulerAngles.x = 0
				var_462_12.localEulerAngles = var_462_12.localEulerAngles
			end

			if arg_459_1.time_ >= 1.966 + var_462_13 and arg_459_1.time_ < 1.966 + var_462_13 + arg_462_0 then
				var_462_12.localPosition = Vector3.New(0, 100, 0)
				var_462_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_462_12.position).x, (manager.ui.mainCamera.transform.position - var_462_12.position).y, (manager.ui.mainCamera.transform.position - var_462_12.position).z)
				var_462_12.localEulerAngles.z = 0
				var_462_12.localEulerAngles.x = 0
				var_462_12.localEulerAngles = var_462_12.localEulerAngles
			end

			local var_462_14 = arg_459_1.actors_["1095ui_story"].transform

			if 3.8 < arg_459_1.time_ and arg_459_1.time_ <= 3.8 + arg_462_0 then
				arg_459_1.var_.moveOldPos1095ui_story = var_462_14.localPosition
			end

			local var_462_15 = 0.001

			if 3.8 <= arg_459_1.time_ and arg_459_1.time_ < 3.8 + var_462_15 then
				var_462_14.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_459_1.time_ - 3.8) / var_462_15)
				var_462_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_462_14.position).x, (manager.ui.mainCamera.transform.position - var_462_14.position).y, (manager.ui.mainCamera.transform.position - var_462_14.position).z)
				var_462_14.localEulerAngles.z = 0
				var_462_14.localEulerAngles.x = 0
				var_462_14.localEulerAngles = var_462_14.localEulerAngles
			end

			if arg_459_1.time_ >= 3.8 + var_462_15 and arg_459_1.time_ < 3.8 + var_462_15 + arg_462_0 then
				var_462_14.localPosition = Vector3.New(0, -0.98, -6.1)
				var_462_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_462_14.position).x, (manager.ui.mainCamera.transform.position - var_462_14.position).y, (manager.ui.mainCamera.transform.position - var_462_14.position).z)
				var_462_14.localEulerAngles.z = 0
				var_462_14.localEulerAngles.x = 0
				var_462_14.localEulerAngles = var_462_14.localEulerAngles
			end

			if 3.8 < arg_459_1.time_ and arg_459_1.time_ <= 3.8 + arg_462_0 then
				arg_459_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_462_16 = arg_459_1.actors_["1095ui_story"]

			if 3.8 < arg_459_1.time_ and arg_459_1.time_ <= 3.8 + arg_462_0 and not isNil(var_462_16) and arg_459_1.var_.characterEffect1095ui_story == nil then
				arg_459_1.var_.characterEffect1095ui_story = var_462_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_17 = 0.2

			if 3.8 <= arg_459_1.time_ and arg_459_1.time_ < 3.8 + var_462_17 and not isNil(var_462_16) then
				if arg_459_1.var_.characterEffect1095ui_story and not isNil(var_462_16) then
					arg_459_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 3.8 + var_462_17 and arg_459_1.time_ < 3.8 + var_462_17 + arg_462_0 and not isNil(var_462_16) and arg_459_1.var_.characterEffect1095ui_story then
				arg_459_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:AudioAction("stop", "effect", "se_story_side_1027", "se_story_side_1027_shop_loop", "")
			end

			if 1.66666666666667 < arg_459_1.time_ and arg_459_1.time_ <= 1.66666666666667 + arg_462_0 then
				arg_459_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_459_1.frameCnt_ <= 1 then
				arg_459_1.dialog_:SetActive(false)
			end

			local var_462_21 = 4
			local var_462_22 = 0.125

			if 4 < arg_459_1.time_ and arg_459_1.time_ <= var_462_21 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				arg_459_1.dialog_:SetActive(true)

				arg_459_1.dialogCg_.alpha = 0

				local var_462_23 = LeanTween.value(arg_459_1.dialog_, 0, 1, 0.3)

				var_462_23:setOnUpdate(LuaHelper.FloatAction(function(arg_463_0)
					arg_459_1.dialogCg_.alpha = arg_463_0
				end))
				var_462_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_459_1.dialog_)
					var_462_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_459_1.duration_ = arg_459_1.duration_ + 0.3

				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_24 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1109501114).content)

				arg_459_1.text_.text = var_462_24

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_26 = 5 <= 0 and var_462_22 or var_462_22 * (utf8.len(var_462_24) / 5)

				if (5 <= 0 and var_462_22 or var_462_22 * (utf8.len(var_462_24) / 5)) > 0 and var_462_22 < var_462_26 then
					arg_459_1.talkMaxDuration = var_462_26
					var_462_21 = var_462_21 + 0.3

					if var_462_26 + var_462_21 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_26 + var_462_21
					end
				end

				arg_459_1.text_.text = var_462_24
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_27 = var_462_21 + 0.3
			local var_462_28 = math.max(var_462_22, arg_459_1.talkMaxDuration)

			if var_462_21 + 0.3 <= arg_459_1.time_ and arg_459_1.time_ < var_462_27 + var_462_28 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_27) / var_462_28

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_27 + var_462_28 and arg_459_1.time_ < var_462_27 + var_462_28 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play1109501115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1109501115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1109501116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1095ui_story"]) and arg_465_1.var_.characterEffect1095ui_story == nil then
				arg_465_1.var_.characterEffect1095ui_story = arg_465_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1095ui_story"]) then
				if arg_465_1.var_.characterEffect1095ui_story and not isNil(arg_465_1.actors_["1095ui_story"]) then
					arg_465_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1095ui_story"]) and arg_465_1.var_.characterEffect1095ui_story then
				arg_465_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_468_1 = 0
			local var_468_2 = 1.025

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1109501115).content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 41 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 41)

				if (41 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 41)) > 0 and var_468_2 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_6 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_6 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_6

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_6 and arg_465_1.time_ < var_468_1 + var_468_6 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1109501116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1109501116
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1109501117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.275

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
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

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1109501116).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 11 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 11)

				if (11 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 11)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1109501117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1109501117
		arg_473_1.duration_ = 4.37

		local var_473_0 = {
			zh = 2.566,
			ja = 4.366
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1109501118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1095ui_story = arg_473_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1095ui_story"].transform.position).z)
				arg_473_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1095ui_story"].transform.localEulerAngles = arg_473_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_473_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1095ui_story"].transform.position).z)
				arg_473_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1095ui_story"].transform.localEulerAngles = arg_473_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1095ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1095ui_story == nil then
				arg_473_1.var_.characterEffect1095ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1095ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1095ui_story then
				arg_473_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_476_4 = 0
			local var_476_5 = 0.3

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(1109501117)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 12 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 12)

				if (12 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 12)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501117", "story_v_side_new_1109501.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501117", "story_v_side_new_1109501.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_side_new_1109501", "1109501117", "story_v_side_new_1109501.awb")

						arg_473_1:RecordAudio("1109501117", var_476_11)
						arg_473_1:RecordAudio("1109501117", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501117", "story_v_side_new_1109501.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501117", "story_v_side_new_1109501.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1109501118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1109501118
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1109501119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1095ui_story"]) and arg_477_1.var_.characterEffect1095ui_story == nil then
				arg_477_1.var_.characterEffect1095ui_story = arg_477_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1095ui_story"]) then
				if arg_477_1.var_.characterEffect1095ui_story and not isNil(arg_477_1.actors_["1095ui_story"]) then
					arg_477_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1095ui_story"]) and arg_477_1.var_.characterEffect1095ui_story then
				arg_477_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.275

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

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1109501118).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 11 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 11)

				if (11 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 11)) > 0 and var_480_2 < var_480_5 then
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
	Play1109501119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1109501119
		arg_481_1.duration_ = 2.23

		local var_481_0 = {
			zh = 2.233,
			ja = 1.533
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1109501120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1095ui_story"]) and arg_481_1.var_.characterEffect1095ui_story == nil then
				arg_481_1.var_.characterEffect1095ui_story = arg_481_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1095ui_story"]) then
				if arg_481_1.var_.characterEffect1095ui_story and not isNil(arg_481_1.actors_["1095ui_story"]) then
					arg_481_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1095ui_story"]) and arg_481_1.var_.characterEffect1095ui_story then
				arg_481_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_484_2 = 0
			local var_484_3 = 0.1

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:GetWordFromCfg(1109501119)
				local var_484_5 = arg_481_1:FormatText(var_484_4.content)

				arg_481_1.text_.text = var_484_5

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 4 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 4)

				if (4 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 4)) > 0 and var_484_3 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_5
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501119", "story_v_side_new_1109501.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501119", "story_v_side_new_1109501.awb") / 1000

					if var_484_8 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_2
					end

					if var_484_4.prefab_name ~= "" and arg_481_1.actors_[var_484_4.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_4.prefab_name].transform, "story_v_side_new_1109501", "1109501119", "story_v_side_new_1109501.awb")

						arg_481_1:RecordAudio("1109501119", var_484_9)
						arg_481_1:RecordAudio("1109501119", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501119", "story_v_side_new_1109501.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501119", "story_v_side_new_1109501.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_10 and arg_481_1.time_ < var_484_2 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1109501120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1109501120
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1109501121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1095ui_story"]) and arg_485_1.var_.characterEffect1095ui_story == nil then
				arg_485_1.var_.characterEffect1095ui_story = arg_485_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1095ui_story"]) then
				if arg_485_1.var_.characterEffect1095ui_story and not isNil(arg_485_1.actors_["1095ui_story"]) then
					arg_485_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_0)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1095ui_story"]) and arg_485_1.var_.characterEffect1095ui_story then
				arg_485_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_488_1 = arg_485_1.actors_["1095ui_story"].transform

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1095ui_story = var_488_1.localPosition
			end

			local var_488_2 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 then
				var_488_1.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_2)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 then
				var_488_1.localPosition = Vector3.New(0, 100, 0)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			local var_488_3 = 0
			local var_488_4 = 0.875

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_3 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_5 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1109501120).content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 35 <= 0 and var_488_4 or var_488_4 * (utf8.len(var_488_5) / 35)

				if (35 <= 0 and var_488_4 or var_488_4 * (utf8.len(var_488_5) / 35)) > 0 and var_488_4 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_3 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_3
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_4, arg_485_1.talkMaxDuration)

			if var_488_3 <= arg_485_1.time_ and arg_485_1.time_ < var_488_3 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_3) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_3 + var_488_8 and arg_485_1.time_ < var_488_3 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play1109501121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1109501121
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1109501122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.225

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
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

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1109501121).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 9 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 9)

				if (9 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 9)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1109501122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109501122
		arg_493_1.duration_ = 6.8

		local var_493_0 = {
			zh = 3.733,
			ja = 6.8
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109501123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["1095ui_story"]) and arg_493_1.var_.characterEffect1095ui_story == nil then
				arg_493_1.var_.characterEffect1095ui_story = arg_493_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_0 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["1095ui_story"]) then
				if arg_493_1.var_.characterEffect1095ui_story and not isNil(arg_493_1.actors_["1095ui_story"]) then
					arg_493_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["1095ui_story"]) and arg_493_1.var_.characterEffect1095ui_story then
				arg_493_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_496_2 = arg_493_1.actors_["1095ui_story"].transform

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1095ui_story = var_496_2.localPosition
			end

			local var_496_3 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_3 then
				var_496_2.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_493_1.time_ - 0) / var_496_3)
				var_496_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_496_2.position).x, (manager.ui.mainCamera.transform.position - var_496_2.position).y, (manager.ui.mainCamera.transform.position - var_496_2.position).z)
				var_496_2.localEulerAngles.z = 0
				var_496_2.localEulerAngles.x = 0
				var_496_2.localEulerAngles = var_496_2.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_3 and arg_493_1.time_ < 0 + var_496_3 + arg_496_0 then
				var_496_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_496_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_496_2.position).x, (manager.ui.mainCamera.transform.position - var_496_2.position).y, (manager.ui.mainCamera.transform.position - var_496_2.position).z)
				var_496_2.localEulerAngles.z = 0
				var_496_2.localEulerAngles.x = 0
				var_496_2.localEulerAngles = var_496_2.localEulerAngles
			end

			local var_496_4 = 0
			local var_496_5 = 0.4

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(1109501122)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 16 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 16)

				if (16 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 16)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501122", "story_v_side_new_1109501.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501122", "story_v_side_new_1109501.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_side_new_1109501", "1109501122", "story_v_side_new_1109501.awb")

						arg_493_1:RecordAudio("1109501122", var_496_11)
						arg_493_1:RecordAudio("1109501122", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501122", "story_v_side_new_1109501.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501122", "story_v_side_new_1109501.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1109501123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1109501123
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1109501124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1095ui_story"]) and arg_497_1.var_.characterEffect1095ui_story == nil then
				arg_497_1.var_.characterEffect1095ui_story = arg_497_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1095ui_story"]) then
				if arg_497_1.var_.characterEffect1095ui_story and not isNil(arg_497_1.actors_["1095ui_story"]) then
					arg_497_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_0)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1095ui_story"]) and arg_497_1.var_.characterEffect1095ui_story then
				arg_497_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_500_1 = 0
			local var_500_2 = 0.5

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1109501123).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 20 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 20)

				if (20 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 20)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1109501124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1109501124
		arg_501_1.duration_ = 6.17

		local var_501_0 = {
			zh = 3.466,
			ja = 6.166
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1109501125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1095ui_story"]) and arg_501_1.var_.characterEffect1095ui_story == nil then
				arg_501_1.var_.characterEffect1095ui_story = arg_501_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1095ui_story"]) then
				if arg_501_1.var_.characterEffect1095ui_story and not isNil(arg_501_1.actors_["1095ui_story"]) then
					arg_501_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1095ui_story"]) and arg_501_1.var_.characterEffect1095ui_story then
				arg_501_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_504_2 = 0
			local var_504_3 = 0.4

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_2 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_4 = arg_501_1:GetWordFromCfg(1109501124)
				local var_504_5 = arg_501_1:FormatText(var_504_4.content)

				arg_501_1.text_.text = var_504_5

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_7 = 16 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_5) / 16)

				if (16 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_5) / 16)) > 0 and var_504_3 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_2
					end
				end

				arg_501_1.text_.text = var_504_5
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501124", "story_v_side_new_1109501.awb") ~= 0 then
					local var_504_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501124", "story_v_side_new_1109501.awb") / 1000

					if var_504_8 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_2
					end

					if var_504_4.prefab_name ~= "" and arg_501_1.actors_[var_504_4.prefab_name] ~= nil then
						local var_504_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_4.prefab_name].transform, "story_v_side_new_1109501", "1109501124", "story_v_side_new_1109501.awb")

						arg_501_1:RecordAudio("1109501124", var_504_9)
						arg_501_1:RecordAudio("1109501124", var_504_9)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501124", "story_v_side_new_1109501.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501124", "story_v_side_new_1109501.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_10 = math.max(var_504_3, arg_501_1.talkMaxDuration)

			if var_504_2 <= arg_501_1.time_ and arg_501_1.time_ < var_504_2 + var_504_10 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_2) / var_504_10

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_2 + var_504_10 and arg_501_1.time_ < var_504_2 + var_504_10 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1109501125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1109501125
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1109501126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1095ui_story"]) and arg_505_1.var_.characterEffect1095ui_story == nil then
				arg_505_1.var_.characterEffect1095ui_story = arg_505_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1095ui_story"]) then
				if arg_505_1.var_.characterEffect1095ui_story and not isNil(arg_505_1.actors_["1095ui_story"]) then
					arg_505_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_0)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1095ui_story"]) and arg_505_1.var_.characterEffect1095ui_story then
				arg_505_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_508_1 = 0
			local var_508_2 = 0.65

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_3 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1109501125).content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 26 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 26)

				if (26 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 26)) > 0 and var_508_2 < var_508_5 then
					arg_505_1.talkMaxDuration = var_508_5

					if var_508_5 + var_508_1 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + var_508_1
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_6 = math.max(var_508_2, arg_505_1.talkMaxDuration)

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_6 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_1) / var_508_6

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_1 + var_508_6 and arg_505_1.time_ < var_508_1 + var_508_6 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1109501126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1109501126
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1109501127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_512_0 = 0
			local var_512_1 = 0.425

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_2 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(1109501126).content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 17 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_2) / 17)

				if (17 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_2) / 17)) > 0 and var_512_1 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_5 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_5 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_5

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_5 and arg_509_1.time_ < var_512_0 + var_512_5 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1109501127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1109501127
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1109501128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.3

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

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1109501127).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 12 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 12)

				if (12 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 12)) > 0 and var_516_0 < var_516_3 then
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
	Play1109501128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1109501128
		arg_517_1.duration_ = 15

		local var_517_0 = {
			zh = 12.4,
			ja = 15
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1109501129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1095ui_story"]) and arg_517_1.var_.characterEffect1095ui_story == nil then
				arg_517_1.var_.characterEffect1095ui_story = arg_517_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1095ui_story"]) then
				if arg_517_1.var_.characterEffect1095ui_story and not isNil(arg_517_1.actors_["1095ui_story"]) then
					arg_517_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1095ui_story"]) and arg_517_1.var_.characterEffect1095ui_story then
				arg_517_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_520_2 = 0
			local var_520_3 = 1.25

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_4 = arg_517_1:GetWordFromCfg(1109501128)
				local var_520_5 = arg_517_1:FormatText(var_520_4.content)

				arg_517_1.text_.text = var_520_5

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_7 = 50 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_5) / 50)

				if (50 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_5) / 50)) > 0 and var_520_3 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_2
					end
				end

				arg_517_1.text_.text = var_520_5
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501128", "story_v_side_new_1109501.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501128", "story_v_side_new_1109501.awb") / 1000

					if var_520_8 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_2
					end

					if var_520_4.prefab_name ~= "" and arg_517_1.actors_[var_520_4.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_4.prefab_name].transform, "story_v_side_new_1109501", "1109501128", "story_v_side_new_1109501.awb")

						arg_517_1:RecordAudio("1109501128", var_520_9)
						arg_517_1:RecordAudio("1109501128", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501128", "story_v_side_new_1109501.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501128", "story_v_side_new_1109501.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_3, arg_517_1.talkMaxDuration)

			if var_520_2 <= arg_517_1.time_ and arg_517_1.time_ < var_520_2 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_2) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_2 + var_520_10 and arg_517_1.time_ < var_520_2 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1109501129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1109501129
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1109501130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1095ui_story"]) and arg_521_1.var_.characterEffect1095ui_story == nil then
				arg_521_1.var_.characterEffect1095ui_story = arg_521_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1095ui_story"]) then
				if arg_521_1.var_.characterEffect1095ui_story and not isNil(arg_521_1.actors_["1095ui_story"]) then
					arg_521_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1095ui_story"]) and arg_521_1.var_.characterEffect1095ui_story then
				arg_521_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_524_1 = 0
			local var_524_2 = 0.375

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

				local var_524_3 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1109501129).content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 15 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 15)

				if (15 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 15)) > 0 and var_524_2 < var_524_5 then
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
	Play1109501130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1109501130
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1109501131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.425

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1109501130).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 17 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 17)

				if (17 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 17)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1109501131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1109501131
		arg_529_1.duration_ = 3.23

		local var_529_0 = {
			zh = 2.833,
			ja = 3.233
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1109501132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1095ui_story"]) and arg_529_1.var_.characterEffect1095ui_story == nil then
				arg_529_1.var_.characterEffect1095ui_story = arg_529_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1095ui_story"]) then
				if arg_529_1.var_.characterEffect1095ui_story and not isNil(arg_529_1.actors_["1095ui_story"]) then
					arg_529_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1095ui_story"]) and arg_529_1.var_.characterEffect1095ui_story then
				arg_529_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_532_2 = 0
			local var_532_3 = 0.275

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_2 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_4 = arg_529_1:GetWordFromCfg(1109501131)
				local var_532_5 = arg_529_1:FormatText(var_532_4.content)

				arg_529_1.text_.text = var_532_5

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_7 = 11 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_5) / 11)

				if (11 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_5) / 11)) > 0 and var_532_3 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_2
					end
				end

				arg_529_1.text_.text = var_532_5
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501131", "story_v_side_new_1109501.awb") ~= 0 then
					local var_532_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501131", "story_v_side_new_1109501.awb") / 1000

					if var_532_8 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_8 + var_532_2
					end

					if var_532_4.prefab_name ~= "" and arg_529_1.actors_[var_532_4.prefab_name] ~= nil then
						local var_532_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_4.prefab_name].transform, "story_v_side_new_1109501", "1109501131", "story_v_side_new_1109501.awb")

						arg_529_1:RecordAudio("1109501131", var_532_9)
						arg_529_1:RecordAudio("1109501131", var_532_9)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501131", "story_v_side_new_1109501.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501131", "story_v_side_new_1109501.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_3, arg_529_1.talkMaxDuration)

			if var_532_2 <= arg_529_1.time_ and arg_529_1.time_ < var_532_2 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_2) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_2 + var_532_10 and arg_529_1.time_ < var_532_2 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1109501132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1109501132
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1109501133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["1095ui_story"]) and arg_533_1.var_.characterEffect1095ui_story == nil then
				arg_533_1.var_.characterEffect1095ui_story = arg_533_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["1095ui_story"]) then
				if arg_533_1.var_.characterEffect1095ui_story and not isNil(arg_533_1.actors_["1095ui_story"]) then
					arg_533_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_0)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["1095ui_story"]) and arg_533_1.var_.characterEffect1095ui_story then
				arg_533_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_536_1 = 0
			local var_536_2 = 0.45

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1109501132).content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 18 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 18)

				if (18 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 18)) > 0 and var_536_2 < var_536_5 then
					arg_533_1.talkMaxDuration = var_536_5

					if var_536_5 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_6 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_6 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_6

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_6 and arg_533_1.time_ < var_536_1 + var_536_6 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1109501133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1109501133
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1109501134(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 1.575

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1109501133).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 63 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 63)

				if (63 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 63)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1109501134 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1109501134
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1109501135(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.225

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
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

				local var_544_1 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(1109501134).content)

				arg_541_1.text_.text = var_544_1

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_3 = 9 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 9)

				if (9 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 9)) > 0 and var_544_0 < var_544_3 then
					arg_541_1.talkMaxDuration = var_544_3

					if var_544_3 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_3 + 0
					end
				end

				arg_541_1.text_.text = var_544_1
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_4 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_4 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_4

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_4 and arg_541_1.time_ < 0 + var_544_4 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1109501135 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1109501135
		arg_545_1.duration_ = 3.97

		local var_545_0 = {
			zh = 2,
			ja = 3.966
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1109501136(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["1095ui_story"]) and arg_545_1.var_.characterEffect1095ui_story == nil then
				arg_545_1.var_.characterEffect1095ui_story = arg_545_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_0 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["1095ui_story"]) then
				if arg_545_1.var_.characterEffect1095ui_story and not isNil(arg_545_1.actors_["1095ui_story"]) then
					arg_545_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["1095ui_story"]) and arg_545_1.var_.characterEffect1095ui_story then
				arg_545_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_548_2 = 0
			local var_548_3 = 0.225

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_2 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_4 = arg_545_1:GetWordFromCfg(1109501135)
				local var_548_5 = arg_545_1:FormatText(var_548_4.content)

				arg_545_1.text_.text = var_548_5

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_7 = 9 <= 0 and var_548_3 or var_548_3 * (utf8.len(var_548_5) / 9)

				if (9 <= 0 and var_548_3 or var_548_3 * (utf8.len(var_548_5) / 9)) > 0 and var_548_3 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_2 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_2
					end
				end

				arg_545_1.text_.text = var_548_5
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501135", "story_v_side_new_1109501.awb") ~= 0 then
					local var_548_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501135", "story_v_side_new_1109501.awb") / 1000

					if var_548_8 + var_548_2 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_8 + var_548_2
					end

					if var_548_4.prefab_name ~= "" and arg_545_1.actors_[var_548_4.prefab_name] ~= nil then
						local var_548_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_4.prefab_name].transform, "story_v_side_new_1109501", "1109501135", "story_v_side_new_1109501.awb")

						arg_545_1:RecordAudio("1109501135", var_548_9)
						arg_545_1:RecordAudio("1109501135", var_548_9)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501135", "story_v_side_new_1109501.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501135", "story_v_side_new_1109501.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_10 = math.max(var_548_3, arg_545_1.talkMaxDuration)

			if var_548_2 <= arg_545_1.time_ and arg_545_1.time_ < var_548_2 + var_548_10 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_2) / var_548_10

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_2 + var_548_10 and arg_545_1.time_ < var_548_2 + var_548_10 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1109501136 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1109501136
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1109501137(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["1095ui_story"]) and arg_549_1.var_.characterEffect1095ui_story == nil then
				arg_549_1.var_.characterEffect1095ui_story = arg_549_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_0 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["1095ui_story"]) then
				if arg_549_1.var_.characterEffect1095ui_story and not isNil(arg_549_1.actors_["1095ui_story"]) then
					arg_549_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_0)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["1095ui_story"]) and arg_549_1.var_.characterEffect1095ui_story then
				arg_549_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_552_1 = 0
			local var_552_2 = 0.55

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1109501136).content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 22 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 22)

				if (22 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 22)) > 0 and var_552_2 < var_552_5 then
					arg_549_1.talkMaxDuration = var_552_5

					if var_552_5 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_6 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_6 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_6

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_6 and arg_549_1.time_ < var_552_1 + var_552_6 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1109501137 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1109501137
		arg_553_1.duration_ = 5.23

		local var_553_0 = {
			zh = 3.333,
			ja = 5.233
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1109501138(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1095ui_story"]) and arg_553_1.var_.characterEffect1095ui_story == nil then
				arg_553_1.var_.characterEffect1095ui_story = arg_553_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1095ui_story"]) then
				if arg_553_1.var_.characterEffect1095ui_story and not isNil(arg_553_1.actors_["1095ui_story"]) then
					arg_553_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1095ui_story"]) and arg_553_1.var_.characterEffect1095ui_story then
				arg_553_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_556_2 = 0
			local var_556_3 = 0.35

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_2 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_4 = arg_553_1:GetWordFromCfg(1109501137)
				local var_556_5 = arg_553_1:FormatText(var_556_4.content)

				arg_553_1.text_.text = var_556_5

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_7 = 14 <= 0 and var_556_3 or var_556_3 * (utf8.len(var_556_5) / 14)

				if (14 <= 0 and var_556_3 or var_556_3 * (utf8.len(var_556_5) / 14)) > 0 and var_556_3 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_2 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_2
					end
				end

				arg_553_1.text_.text = var_556_5
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501137", "story_v_side_new_1109501.awb") ~= 0 then
					local var_556_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501137", "story_v_side_new_1109501.awb") / 1000

					if var_556_8 + var_556_2 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_8 + var_556_2
					end

					if var_556_4.prefab_name ~= "" and arg_553_1.actors_[var_556_4.prefab_name] ~= nil then
						local var_556_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_4.prefab_name].transform, "story_v_side_new_1109501", "1109501137", "story_v_side_new_1109501.awb")

						arg_553_1:RecordAudio("1109501137", var_556_9)
						arg_553_1:RecordAudio("1109501137", var_556_9)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501137", "story_v_side_new_1109501.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501137", "story_v_side_new_1109501.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_10 = math.max(var_556_3, arg_553_1.talkMaxDuration)

			if var_556_2 <= arg_553_1.time_ and arg_553_1.time_ < var_556_2 + var_556_10 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_2) / var_556_10

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_2 + var_556_10 and arg_553_1.time_ < var_556_2 + var_556_10 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1109501138 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1109501138
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1109501139(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1095ui_story"]) and arg_557_1.var_.characterEffect1095ui_story == nil then
				arg_557_1.var_.characterEffect1095ui_story = arg_557_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1095ui_story"]) then
				if arg_557_1.var_.characterEffect1095ui_story and not isNil(arg_557_1.actors_["1095ui_story"]) then
					arg_557_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_0)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1095ui_story"]) and arg_557_1.var_.characterEffect1095ui_story then
				arg_557_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_560_1 = 0
			local var_560_2 = 0.25

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_3 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(1109501138).content)

				arg_557_1.text_.text = var_560_3

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 10 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_3) / 10)

				if (10 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_3) / 10)) > 0 and var_560_2 < var_560_5 then
					arg_557_1.talkMaxDuration = var_560_5

					if var_560_5 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + var_560_1
					end
				end

				arg_557_1.text_.text = var_560_3
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_6 = math.max(var_560_2, arg_557_1.talkMaxDuration)

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_6 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_1) / var_560_6

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_1 + var_560_6 and arg_557_1.time_ < var_560_1 + var_560_6 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1109501139 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1109501139
		arg_561_1.duration_ = 6.97

		local var_561_0 = {
			zh = 5.833,
			ja = 6.966
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1109501140(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["1095ui_story"]) and arg_561_1.var_.characterEffect1095ui_story == nil then
				arg_561_1.var_.characterEffect1095ui_story = arg_561_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_0 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["1095ui_story"]) then
				if arg_561_1.var_.characterEffect1095ui_story and not isNil(arg_561_1.actors_["1095ui_story"]) then
					arg_561_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["1095ui_story"]) and arg_561_1.var_.characterEffect1095ui_story then
				arg_561_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_564_2 = 0
			local var_564_3 = 0.65

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_2 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_4 = arg_561_1:GetWordFromCfg(1109501139)
				local var_564_5 = arg_561_1:FormatText(var_564_4.content)

				arg_561_1.text_.text = var_564_5

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_7 = 26 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 26)

				if (26 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 26)) > 0 and var_564_3 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_2
					end
				end

				arg_561_1.text_.text = var_564_5
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501139", "story_v_side_new_1109501.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501139", "story_v_side_new_1109501.awb") / 1000

					if var_564_8 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_2
					end

					if var_564_4.prefab_name ~= "" and arg_561_1.actors_[var_564_4.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_4.prefab_name].transform, "story_v_side_new_1109501", "1109501139", "story_v_side_new_1109501.awb")

						arg_561_1:RecordAudio("1109501139", var_564_9)
						arg_561_1:RecordAudio("1109501139", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501139", "story_v_side_new_1109501.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501139", "story_v_side_new_1109501.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_3, arg_561_1.talkMaxDuration)

			if var_564_2 <= arg_561_1.time_ and arg_561_1.time_ < var_564_2 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_2) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_2 + var_564_10 and arg_561_1.time_ < var_564_2 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1109501140 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1109501140
		arg_565_1.duration_ = 6.7

		local var_565_0 = {
			zh = 6.7,
			ja = 6.6
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1109501141(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0.7

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_1 = arg_565_1:GetWordFromCfg(1109501140)
				local var_568_2 = arg_565_1:FormatText(var_568_1.content)

				arg_565_1.text_.text = var_568_2

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_4 = 28 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 28)

				if (28 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 28)) > 0 and var_568_0 < var_568_4 then
					arg_565_1.talkMaxDuration = var_568_4

					if var_568_4 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_4 + 0
					end
				end

				arg_565_1.text_.text = var_568_2
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501140", "story_v_side_new_1109501.awb") ~= 0 then
					local var_568_5 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501140", "story_v_side_new_1109501.awb") / 1000

					if var_568_5 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + 0
					end

					if var_568_1.prefab_name ~= "" and arg_565_1.actors_[var_568_1.prefab_name] ~= nil then
						local var_568_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_1.prefab_name].transform, "story_v_side_new_1109501", "1109501140", "story_v_side_new_1109501.awb")

						arg_565_1:RecordAudio("1109501140", var_568_6)
						arg_565_1:RecordAudio("1109501140", var_568_6)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501140", "story_v_side_new_1109501.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501140", "story_v_side_new_1109501.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_7 = math.max(var_568_0, arg_565_1.talkMaxDuration)

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_7 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - 0) / var_568_7

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= 0 + var_568_7 and arg_565_1.time_ < 0 + var_568_7 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1109501141 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1109501141
		arg_569_1.duration_ = 15.5

		local var_569_0 = {
			zh = 11.3,
			ja = 15.5
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1109501142(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 1.2

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:GetWordFromCfg(1109501141)
				local var_572_2 = arg_569_1:FormatText(var_572_1.content)

				arg_569_1.text_.text = var_572_2

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 48 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 48)

				if (48 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 48)) > 0 and var_572_0 < var_572_4 then
					arg_569_1.talkMaxDuration = var_572_4

					if var_572_4 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_4 + 0
					end
				end

				arg_569_1.text_.text = var_572_2
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501141", "story_v_side_new_1109501.awb") ~= 0 then
					local var_572_5 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501141", "story_v_side_new_1109501.awb") / 1000

					if var_572_5 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + 0
					end

					if var_572_1.prefab_name ~= "" and arg_569_1.actors_[var_572_1.prefab_name] ~= nil then
						local var_572_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_1.prefab_name].transform, "story_v_side_new_1109501", "1109501141", "story_v_side_new_1109501.awb")

						arg_569_1:RecordAudio("1109501141", var_572_6)
						arg_569_1:RecordAudio("1109501141", var_572_6)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501141", "story_v_side_new_1109501.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501141", "story_v_side_new_1109501.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1109501142 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1109501142
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1109501143(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1095ui_story"]) and arg_573_1.var_.characterEffect1095ui_story == nil then
				arg_573_1.var_.characterEffect1095ui_story = arg_573_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1095ui_story"]) then
				if arg_573_1.var_.characterEffect1095ui_story and not isNil(arg_573_1.actors_["1095ui_story"]) then
					arg_573_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_0)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1095ui_story"]) and arg_573_1.var_.characterEffect1095ui_story then
				arg_573_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_576_1 = 0
			local var_576_2 = 0.3

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(1109501142).content)

				arg_573_1.text_.text = var_576_3

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 12 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 12)

				if (12 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 12)) > 0 and var_576_2 < var_576_5 then
					arg_573_1.talkMaxDuration = var_576_5

					if var_576_5 + var_576_1 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + var_576_1
					end
				end

				arg_573_1.text_.text = var_576_3
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_6 = math.max(var_576_2, arg_573_1.talkMaxDuration)

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_6 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_1) / var_576_6

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_1 + var_576_6 and arg_573_1.time_ < var_576_1 + var_576_6 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1109501143 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1109501143
		arg_577_1.duration_ = 6.93

		local var_577_0 = {
			zh = 6.933,
			ja = 4.4
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1109501144(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1095ui_story"]) and arg_577_1.var_.characterEffect1095ui_story == nil then
				arg_577_1.var_.characterEffect1095ui_story = arg_577_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1095ui_story"]) then
				if arg_577_1.var_.characterEffect1095ui_story and not isNil(arg_577_1.actors_["1095ui_story"]) then
					arg_577_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1095ui_story"]) and arg_577_1.var_.characterEffect1095ui_story then
				arg_577_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_580_2 = 0
			local var_580_3 = 0.8

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_2 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_4 = arg_577_1:GetWordFromCfg(1109501143)
				local var_580_5 = arg_577_1:FormatText(var_580_4.content)

				arg_577_1.text_.text = var_580_5

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_7 = 32 <= 0 and var_580_3 or var_580_3 * (utf8.len(var_580_5) / 32)

				if (32 <= 0 and var_580_3 or var_580_3 * (utf8.len(var_580_5) / 32)) > 0 and var_580_3 < var_580_7 then
					arg_577_1.talkMaxDuration = var_580_7

					if var_580_7 + var_580_2 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_7 + var_580_2
					end
				end

				arg_577_1.text_.text = var_580_5
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501143", "story_v_side_new_1109501.awb") ~= 0 then
					local var_580_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501143", "story_v_side_new_1109501.awb") / 1000

					if var_580_8 + var_580_2 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_8 + var_580_2
					end

					if var_580_4.prefab_name ~= "" and arg_577_1.actors_[var_580_4.prefab_name] ~= nil then
						local var_580_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_4.prefab_name].transform, "story_v_side_new_1109501", "1109501143", "story_v_side_new_1109501.awb")

						arg_577_1:RecordAudio("1109501143", var_580_9)
						arg_577_1:RecordAudio("1109501143", var_580_9)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501143", "story_v_side_new_1109501.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501143", "story_v_side_new_1109501.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_10 = math.max(var_580_3, arg_577_1.talkMaxDuration)

			if var_580_2 <= arg_577_1.time_ and arg_577_1.time_ < var_580_2 + var_580_10 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_2) / var_580_10

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_2 + var_580_10 and arg_577_1.time_ < var_580_2 + var_580_10 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1109501144 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1109501144
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1109501145(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["1095ui_story"]) and arg_581_1.var_.characterEffect1095ui_story == nil then
				arg_581_1.var_.characterEffect1095ui_story = arg_581_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_0 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["1095ui_story"]) then
				if arg_581_1.var_.characterEffect1095ui_story and not isNil(arg_581_1.actors_["1095ui_story"]) then
					arg_581_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_581_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_581_1.time_ - 0) / var_584_0)
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["1095ui_story"]) and arg_581_1.var_.characterEffect1095ui_story then
				arg_581_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_581_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_584_1 = 0
			local var_584_2 = 0.55

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_3 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(1109501144).content)

				arg_581_1.text_.text = var_584_3

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_5 = 22 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_3) / 22)

				if (22 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_3) / 22)) > 0 and var_584_2 < var_584_5 then
					arg_581_1.talkMaxDuration = var_584_5

					if var_584_5 + var_584_1 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_5 + var_584_1
					end
				end

				arg_581_1.text_.text = var_584_3
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_6 = math.max(var_584_2, arg_581_1.talkMaxDuration)

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_6 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_1) / var_584_6

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_1 + var_584_6 and arg_581_1.time_ < var_584_1 + var_584_6 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1109501145 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1109501145
		arg_585_1.duration_ = 3.23

		local var_585_0 = {
			zh = 3.066,
			ja = 3.233
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1109501146(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.var_.moveOldPos1095ui_story = arg_585_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_588_0 = 0.001

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 then
				arg_585_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_585_1.time_ - 0) / var_588_0)
				arg_585_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_585_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1095ui_story"].transform.position).z)
				arg_585_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_585_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_585_1.actors_["1095ui_story"].transform.localEulerAngles = arg_585_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 then
				arg_585_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_585_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_585_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1095ui_story"].transform.position).z)
				arg_585_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_585_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_585_1.actors_["1095ui_story"].transform.localEulerAngles = arg_585_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_588_1 = arg_585_1.actors_["1095ui_story"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1095ui_story == nil then
				arg_585_1.var_.characterEffect1095ui_story = var_588_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_2 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_2 and not isNil(var_588_1) then
				if arg_585_1.var_.characterEffect1095ui_story and not isNil(var_588_1) then
					arg_585_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= 0 + var_588_2 and arg_585_1.time_ < 0 + var_588_2 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1095ui_story then
				arg_585_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_588_4 = 0
			local var_588_5 = 0.2

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_4 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_6 = arg_585_1:GetWordFromCfg(1109501145)
				local var_588_7 = arg_585_1:FormatText(var_588_6.content)

				arg_585_1.text_.text = var_588_7

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_9 = 8 <= 0 and var_588_5 or var_588_5 * (utf8.len(var_588_7) / 8)

				if (8 <= 0 and var_588_5 or var_588_5 * (utf8.len(var_588_7) / 8)) > 0 and var_588_5 < var_588_9 then
					arg_585_1.talkMaxDuration = var_588_9

					if var_588_9 + var_588_4 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_9 + var_588_4
					end
				end

				arg_585_1.text_.text = var_588_7
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501145", "story_v_side_new_1109501.awb") ~= 0 then
					local var_588_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501145", "story_v_side_new_1109501.awb") / 1000

					if var_588_10 + var_588_4 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_10 + var_588_4
					end

					if var_588_6.prefab_name ~= "" and arg_585_1.actors_[var_588_6.prefab_name] ~= nil then
						local var_588_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_6.prefab_name].transform, "story_v_side_new_1109501", "1109501145", "story_v_side_new_1109501.awb")

						arg_585_1:RecordAudio("1109501145", var_588_11)
						arg_585_1:RecordAudio("1109501145", var_588_11)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501145", "story_v_side_new_1109501.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501145", "story_v_side_new_1109501.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_12 = math.max(var_588_5, arg_585_1.talkMaxDuration)

			if var_588_4 <= arg_585_1.time_ and arg_585_1.time_ < var_588_4 + var_588_12 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_4) / var_588_12

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_4 + var_588_12 and arg_585_1.time_ < var_588_4 + var_588_12 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play1109501146 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1109501146
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1109501147(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["1095ui_story"]) and arg_589_1.var_.characterEffect1095ui_story == nil then
				arg_589_1.var_.characterEffect1095ui_story = arg_589_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_0 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["1095ui_story"]) then
				if arg_589_1.var_.characterEffect1095ui_story and not isNil(arg_589_1.actors_["1095ui_story"]) then
					arg_589_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_589_1.time_ - 0) / var_592_0)
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["1095ui_story"]) and arg_589_1.var_.characterEffect1095ui_story then
				arg_589_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_592_1 = 0
			local var_592_2 = 1.35

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_3 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1109501146).content)

				arg_589_1.text_.text = var_592_3

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 54 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 54)

				if (54 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 54)) > 0 and var_592_2 < var_592_5 then
					arg_589_1.talkMaxDuration = var_592_5

					if var_592_5 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + var_592_1
					end
				end

				arg_589_1.text_.text = var_592_3
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_6 = math.max(var_592_2, arg_589_1.talkMaxDuration)

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_6 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_1) / var_592_6

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_1 + var_592_6 and arg_589_1.time_ < var_592_1 + var_592_6 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1109501147 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1109501147
		arg_593_1.duration_ = 2

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1109501148(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(arg_593_1.actors_["1095ui_story"]) and arg_593_1.var_.characterEffect1095ui_story == nil then
				arg_593_1.var_.characterEffect1095ui_story = arg_593_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_0 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 and not isNil(arg_593_1.actors_["1095ui_story"]) then
				if arg_593_1.var_.characterEffect1095ui_story and not isNil(arg_593_1.actors_["1095ui_story"]) then
					arg_593_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 and not isNil(arg_593_1.actors_["1095ui_story"]) and arg_593_1.var_.characterEffect1095ui_story then
				arg_593_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_596_2 = 0
			local var_596_3 = 0.15

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_2 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_4 = arg_593_1:GetWordFromCfg(1109501147)
				local var_596_5 = arg_593_1:FormatText(var_596_4.content)

				arg_593_1.text_.text = var_596_5

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_7 = 6 <= 0 and var_596_3 or var_596_3 * (utf8.len(var_596_5) / 6)

				if (6 <= 0 and var_596_3 or var_596_3 * (utf8.len(var_596_5) / 6)) > 0 and var_596_3 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_2 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_2
					end
				end

				arg_593_1.text_.text = var_596_5
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501147", "story_v_side_new_1109501.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501147", "story_v_side_new_1109501.awb") / 1000

					if var_596_8 + var_596_2 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_2
					end

					if var_596_4.prefab_name ~= "" and arg_593_1.actors_[var_596_4.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_4.prefab_name].transform, "story_v_side_new_1109501", "1109501147", "story_v_side_new_1109501.awb")

						arg_593_1:RecordAudio("1109501147", var_596_9)
						arg_593_1:RecordAudio("1109501147", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501147", "story_v_side_new_1109501.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501147", "story_v_side_new_1109501.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_3, arg_593_1.talkMaxDuration)

			if var_596_2 <= arg_593_1.time_ and arg_593_1.time_ < var_596_2 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_2) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_2 + var_596_10 and arg_593_1.time_ < var_596_2 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1109501148 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1109501148
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1109501149(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1095ui_story"]) and arg_597_1.var_.characterEffect1095ui_story == nil then
				arg_597_1.var_.characterEffect1095ui_story = arg_597_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_0 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1095ui_story"]) then
				if arg_597_1.var_.characterEffect1095ui_story and not isNil(arg_597_1.actors_["1095ui_story"]) then
					arg_597_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_597_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_597_1.time_ - 0) / var_600_0)
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1095ui_story"]) and arg_597_1.var_.characterEffect1095ui_story then
				arg_597_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_597_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_600_1 = 0
			local var_600_2 = 0.4

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, true)
				arg_597_1.iconController_:SetSelectedState("hero")

				arg_597_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_597_1.callingController_:SetSelectedState("normal")

				arg_597_1.keyicon_.color = Color.New(1, 1, 1)
				arg_597_1.icon_.color = Color.New(1, 1, 1)

				local var_600_3 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(1109501148).content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 16 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 16)

				if (16 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 16)) > 0 and var_600_2 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_6 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_6 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_6

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_6 and arg_597_1.time_ < var_600_1 + var_600_6 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1109501149 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1109501149
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1109501150(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0.325

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_1 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(1109501149).content)

				arg_601_1.text_.text = var_604_1

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_3 = 13 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_1) / 13)

				if (13 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_1) / 13)) > 0 and var_604_0 < var_604_3 then
					arg_601_1.talkMaxDuration = var_604_3

					if var_604_3 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_3 + 0
					end
				end

				arg_601_1.text_.text = var_604_1
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_4 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_4 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_4

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_4 and arg_601_1.time_ < 0 + var_604_4 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1109501150 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1109501150
		arg_605_1.duration_ = 10

		local var_605_0 = {
			zh = 8.9,
			ja = 10
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1109501151(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 and not isNil(arg_605_1.actors_["1095ui_story"]) and arg_605_1.var_.characterEffect1095ui_story == nil then
				arg_605_1.var_.characterEffect1095ui_story = arg_605_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_0 = 0.200000002980232

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_0 and not isNil(arg_605_1.actors_["1095ui_story"]) then
				if arg_605_1.var_.characterEffect1095ui_story and not isNil(arg_605_1.actors_["1095ui_story"]) then
					arg_605_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= 0 + var_608_0 and arg_605_1.time_ < 0 + var_608_0 + arg_608_0 and not isNil(arg_605_1.actors_["1095ui_story"]) and arg_605_1.var_.characterEffect1095ui_story then
				arg_605_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_608_2 = 0
			local var_608_3 = 0.75

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_2 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_4 = arg_605_1:GetWordFromCfg(1109501150)
				local var_608_5 = arg_605_1:FormatText(var_608_4.content)

				arg_605_1.text_.text = var_608_5

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_7 = 30 <= 0 and var_608_3 or var_608_3 * (utf8.len(var_608_5) / 30)

				if (30 <= 0 and var_608_3 or var_608_3 * (utf8.len(var_608_5) / 30)) > 0 and var_608_3 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_2 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_2
					end
				end

				arg_605_1.text_.text = var_608_5
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501150", "story_v_side_new_1109501.awb") ~= 0 then
					local var_608_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501150", "story_v_side_new_1109501.awb") / 1000

					if var_608_8 + var_608_2 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_8 + var_608_2
					end

					if var_608_4.prefab_name ~= "" and arg_605_1.actors_[var_608_4.prefab_name] ~= nil then
						local var_608_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_4.prefab_name].transform, "story_v_side_new_1109501", "1109501150", "story_v_side_new_1109501.awb")

						arg_605_1:RecordAudio("1109501150", var_608_9)
						arg_605_1:RecordAudio("1109501150", var_608_9)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501150", "story_v_side_new_1109501.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501150", "story_v_side_new_1109501.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_10 = math.max(var_608_3, arg_605_1.talkMaxDuration)

			if var_608_2 <= arg_605_1.time_ and arg_605_1.time_ < var_608_2 + var_608_10 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_2) / var_608_10

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_2 + var_608_10 and arg_605_1.time_ < var_608_2 + var_608_10 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1109501151 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1109501151
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1109501152(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 and not isNil(arg_609_1.actors_["1095ui_story"]) and arg_609_1.var_.characterEffect1095ui_story == nil then
				arg_609_1.var_.characterEffect1095ui_story = arg_609_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_0 = 0.200000002980232

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_0 and not isNil(arg_609_1.actors_["1095ui_story"]) then
				if arg_609_1.var_.characterEffect1095ui_story and not isNil(arg_609_1.actors_["1095ui_story"]) then
					arg_609_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_609_1.time_ - 0) / var_612_0)
				end
			end

			if arg_609_1.time_ >= 0 + var_612_0 and arg_609_1.time_ < 0 + var_612_0 + arg_612_0 and not isNil(arg_609_1.actors_["1095ui_story"]) and arg_609_1.var_.characterEffect1095ui_story then
				arg_609_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_612_1 = 0
			local var_612_2 = 0.625

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_3 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(1109501151).content)

				arg_609_1.text_.text = var_612_3

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 25 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_3) / 25)

				if (25 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_3) / 25)) > 0 and var_612_2 < var_612_5 then
					arg_609_1.talkMaxDuration = var_612_5

					if var_612_5 + var_612_1 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_5 + var_612_1
					end
				end

				arg_609_1.text_.text = var_612_3
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_6 = math.max(var_612_2, arg_609_1.talkMaxDuration)

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_6 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_1) / var_612_6

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_1 + var_612_6 and arg_609_1.time_ < var_612_1 + var_612_6 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1109501152 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1109501152
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1109501153(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(arg_613_1.actors_["1095ui_story"]) and arg_613_1.var_.characterEffect1095ui_story == nil then
				arg_613_1.var_.characterEffect1095ui_story = arg_613_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_0 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 and not isNil(arg_613_1.actors_["1095ui_story"]) then
				if arg_613_1.var_.characterEffect1095ui_story and not isNil(arg_613_1.actors_["1095ui_story"]) then
					arg_613_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_613_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_613_1.time_ - 0) / var_616_0)
				end
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 and not isNil(arg_613_1.actors_["1095ui_story"]) and arg_613_1.var_.characterEffect1095ui_story then
				arg_613_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_613_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_616_1 = 0
			local var_616_2 = 0.35

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1109501152).content)

				arg_613_1.text_.text = var_616_3

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 14 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 14)

				if (14 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 14)) > 0 and var_616_2 < var_616_5 then
					arg_613_1.talkMaxDuration = var_616_5

					if var_616_5 + var_616_1 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_5 + var_616_1
					end
				end

				arg_613_1.text_.text = var_616_3
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_6 = math.max(var_616_2, arg_613_1.talkMaxDuration)

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_6 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_1) / var_616_6

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_1 + var_616_6 and arg_613_1.time_ < var_616_1 + var_616_6 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1109501153 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1109501153
		arg_617_1.duration_ = 6.13

		local var_617_0 = {
			zh = 4.7,
			ja = 6.133
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1109501154(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(arg_617_1.actors_["1095ui_story"]) and arg_617_1.var_.characterEffect1095ui_story == nil then
				arg_617_1.var_.characterEffect1095ui_story = arg_617_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_0 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 and not isNil(arg_617_1.actors_["1095ui_story"]) then
				if arg_617_1.var_.characterEffect1095ui_story and not isNil(arg_617_1.actors_["1095ui_story"]) then
					arg_617_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 and not isNil(arg_617_1.actors_["1095ui_story"]) and arg_617_1.var_.characterEffect1095ui_story then
				arg_617_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action472")
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_620_2 = 0
			local var_620_3 = 0.5

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_2 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_4 = arg_617_1:GetWordFromCfg(1109501153)
				local var_620_5 = arg_617_1:FormatText(var_620_4.content)

				arg_617_1.text_.text = var_620_5

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_7 = 20 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 20)

				if (20 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 20)) > 0 and var_620_3 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_2
					end
				end

				arg_617_1.text_.text = var_620_5
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501153", "story_v_side_new_1109501.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501153", "story_v_side_new_1109501.awb") / 1000

					if var_620_8 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_2
					end

					if var_620_4.prefab_name ~= "" and arg_617_1.actors_[var_620_4.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_4.prefab_name].transform, "story_v_side_new_1109501", "1109501153", "story_v_side_new_1109501.awb")

						arg_617_1:RecordAudio("1109501153", var_620_9)
						arg_617_1:RecordAudio("1109501153", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501153", "story_v_side_new_1109501.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501153", "story_v_side_new_1109501.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_3, arg_617_1.talkMaxDuration)

			if var_620_2 <= arg_617_1.time_ and arg_617_1.time_ < var_620_2 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_2) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_2 + var_620_10 and arg_617_1.time_ < var_620_2 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1109501154 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1109501154
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1109501155(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 and not isNil(arg_621_1.actors_["1095ui_story"]) and arg_621_1.var_.characterEffect1095ui_story == nil then
				arg_621_1.var_.characterEffect1095ui_story = arg_621_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_0 = 0.200000002980232

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 and not isNil(arg_621_1.actors_["1095ui_story"]) then
				if arg_621_1.var_.characterEffect1095ui_story and not isNil(arg_621_1.actors_["1095ui_story"]) then
					arg_621_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_621_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_621_1.time_ - 0) / var_624_0)
				end
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 and not isNil(arg_621_1.actors_["1095ui_story"]) and arg_621_1.var_.characterEffect1095ui_story then
				arg_621_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_621_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_624_1 = 0
			local var_624_2 = 0.625

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, false)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_3 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(1109501154).content)

				arg_621_1.text_.text = var_624_3

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 25 <= 0 and var_624_2 or var_624_2 * (utf8.len(var_624_3) / 25)

				if (25 <= 0 and var_624_2 or var_624_2 * (utf8.len(var_624_3) / 25)) > 0 and var_624_2 < var_624_5 then
					arg_621_1.talkMaxDuration = var_624_5

					if var_624_5 + var_624_1 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + var_624_1
					end
				end

				arg_621_1.text_.text = var_624_3
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_6 = math.max(var_624_2, arg_621_1.talkMaxDuration)

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_6 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_1) / var_624_6

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_1 + var_624_6 and arg_621_1.time_ < var_624_1 + var_624_6 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1109501155 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1109501155
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1109501156(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.175

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_1 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(1109501155).content)

				arg_625_1.text_.text = var_628_1

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_3 = 7 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 7)

				if (7 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 7)) > 0 and var_628_0 < var_628_3 then
					arg_625_1.talkMaxDuration = var_628_3

					if var_628_3 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_3 + 0
					end
				end

				arg_625_1.text_.text = var_628_1
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_4 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_4 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_4

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_4 and arg_625_1.time_ < 0 + var_628_4 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1109501156 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1109501156
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1109501157(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0.6

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, true)
				arg_629_1.iconController_:SetSelectedState("hero")

				arg_629_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_629_1.callingController_:SetSelectedState("normal")

				arg_629_1.keyicon_.color = Color.New(1, 1, 1)
				arg_629_1.icon_.color = Color.New(1, 1, 1)

				local var_632_1 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(1109501156).content)

				arg_629_1.text_.text = var_632_1

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_3 = 24 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 24)

				if (24 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 24)) > 0 and var_632_0 < var_632_3 then
					arg_629_1.talkMaxDuration = var_632_3

					if var_632_3 + 0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_3 + 0
					end
				end

				arg_629_1.text_.text = var_632_1
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_4 = math.max(var_632_0, arg_629_1.talkMaxDuration)

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_4 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - 0) / var_632_4

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= 0 + var_632_4 and arg_629_1.time_ < 0 + var_632_4 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1109501157 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1109501157
		arg_633_1.duration_ = 4.07

		local var_633_0 = {
			zh = 2.233,
			ja = 4.066
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1109501158(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.var_.moveOldPos1095ui_story = arg_633_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_636_0 = 0.001

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 then
				arg_633_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_633_1.time_ - 0) / var_636_0)
				arg_633_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1095ui_story"].transform.position).z)
				arg_633_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["1095ui_story"].transform.localEulerAngles = arg_633_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 then
				arg_633_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_633_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1095ui_story"].transform.position).z)
				arg_633_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["1095ui_story"].transform.localEulerAngles = arg_633_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_636_1 = arg_633_1.actors_["1095ui_story"]

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect1095ui_story == nil then
				arg_633_1.var_.characterEffect1095ui_story = var_636_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_2 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_2 and not isNil(var_636_1) then
				if arg_633_1.var_.characterEffect1095ui_story and not isNil(var_636_1) then
					arg_633_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= 0 + var_636_2 and arg_633_1.time_ < 0 + var_636_2 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect1095ui_story then
				arg_633_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_636_4 = 0
			local var_636_5 = 0.1

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_4 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_6 = arg_633_1:GetWordFromCfg(1109501157)
				local var_636_7 = arg_633_1:FormatText(var_636_6.content)

				arg_633_1.text_.text = var_636_7

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_9 = 4 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 4)

				if (4 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 4)) > 0 and var_636_5 < var_636_9 then
					arg_633_1.talkMaxDuration = var_636_9

					if var_636_9 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_9 + var_636_4
					end
				end

				arg_633_1.text_.text = var_636_7
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501157", "story_v_side_new_1109501.awb") ~= 0 then
					local var_636_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501157", "story_v_side_new_1109501.awb") / 1000

					if var_636_10 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_10 + var_636_4
					end

					if var_636_6.prefab_name ~= "" and arg_633_1.actors_[var_636_6.prefab_name] ~= nil then
						local var_636_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_6.prefab_name].transform, "story_v_side_new_1109501", "1109501157", "story_v_side_new_1109501.awb")

						arg_633_1:RecordAudio("1109501157", var_636_11)
						arg_633_1:RecordAudio("1109501157", var_636_11)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501157", "story_v_side_new_1109501.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501157", "story_v_side_new_1109501.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_12 = math.max(var_636_5, arg_633_1.talkMaxDuration)

			if var_636_4 <= arg_633_1.time_ and arg_633_1.time_ < var_636_4 + var_636_12 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_4) / var_636_12

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_4 + var_636_12 and arg_633_1.time_ < var_636_4 + var_636_12 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play1109501158 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1109501158
		arg_637_1.duration_ = 9

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1109501159(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 2 < arg_637_1.time_ and arg_637_1.time_ <= 2 + arg_640_0 then
				local var_640_0 = arg_637_1.bgs_.STblack

				arg_637_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_640_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_640_1 = var_640_0:GetComponent("SpriteRenderer")

				if var_640_1 and var_640_1.sprite then
					local var_640_2 = 2 * (var_640_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_640_0.transform.localScale = Vector3.New(var_640_2 / var_640_1.sprite.bounds.size.y < var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x and var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x or var_640_2 / var_640_1.sprite.bounds.size.y, var_640_2 / var_640_1.sprite.bounds.size.y < var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x and var_640_2 * manager.ui.mainCameraCom_.aspect / var_640_1.sprite.bounds.size.x or var_640_2 / var_640_1.sprite.bounds.size.y, 0)
				end

				for iter_640_0, iter_640_1 in pairs(arg_637_1.bgs_) do
					if iter_640_0 ~= "STblack" then
						iter_640_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_640_3 = 0

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_3 + arg_640_0 then
				arg_637_1.mask_.enabled = true
				arg_637_1.mask_.raycastTarget = true

				arg_637_1:SetGaussion(false)
			end

			local var_640_4 = 2

			if var_640_3 <= arg_637_1.time_ and arg_637_1.time_ < var_640_3 + var_640_4 then
				local var_640_5 = Color.New(0, 0, 0)

				var_640_5.a = Mathf.Lerp(0, 1, (arg_637_1.time_ - var_640_3) / var_640_4)
				arg_637_1.mask_.color = var_640_5
			end

			if arg_637_1.time_ >= var_640_3 + var_640_4 and arg_637_1.time_ < var_640_3 + var_640_4 + arg_640_0 then
				local var_640_6 = Color.New(0, 0, 0)

				var_640_6.a = 1
				arg_637_1.mask_.color = var_640_6
			end

			local var_640_7 = 2

			if 2 < arg_637_1.time_ and arg_637_1.time_ <= var_640_7 + arg_640_0 then
				arg_637_1.mask_.enabled = true
				arg_637_1.mask_.raycastTarget = true

				arg_637_1:SetGaussion(false)
			end

			local var_640_8 = 2

			if var_640_7 <= arg_637_1.time_ and arg_637_1.time_ < var_640_7 + var_640_8 then
				local var_640_9 = Color.New(0, 0, 0)

				var_640_9.a = Mathf.Lerp(1, 0, (arg_637_1.time_ - var_640_7) / var_640_8)
				arg_637_1.mask_.color = var_640_9
			end

			if arg_637_1.time_ >= var_640_7 + var_640_8 and arg_637_1.time_ < var_640_7 + var_640_8 + arg_640_0 then
				local var_640_10 = Color.New(0, 0, 0)

				arg_637_1.mask_.enabled = false
				var_640_10.a = 0
				arg_637_1.mask_.color = var_640_10
			end

			local var_640_11 = arg_637_1.actors_["1095ui_story"].transform

			if 1.96599999815226 < arg_637_1.time_ and arg_637_1.time_ <= 1.96599999815226 + arg_640_0 then
				arg_637_1.var_.moveOldPos1095ui_story = var_640_11.localPosition
			end

			local var_640_12 = 0.001

			if 1.96599999815226 <= arg_637_1.time_ and arg_637_1.time_ < 1.96599999815226 + var_640_12 then
				var_640_11.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_637_1.time_ - 1.96599999815226) / var_640_12)
				var_640_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_640_11.position).x, (manager.ui.mainCamera.transform.position - var_640_11.position).y, (manager.ui.mainCamera.transform.position - var_640_11.position).z)
				var_640_11.localEulerAngles.z = 0
				var_640_11.localEulerAngles.x = 0
				var_640_11.localEulerAngles = var_640_11.localEulerAngles
			end

			if arg_637_1.time_ >= 1.96599999815226 + var_640_12 and arg_637_1.time_ < 1.96599999815226 + var_640_12 + arg_640_0 then
				var_640_11.localPosition = Vector3.New(0, 100, 0)
				var_640_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_640_11.position).x, (manager.ui.mainCamera.transform.position - var_640_11.position).y, (manager.ui.mainCamera.transform.position - var_640_11.position).z)
				var_640_11.localEulerAngles.z = 0
				var_640_11.localEulerAngles.x = 0
				var_640_11.localEulerAngles = var_640_11.localEulerAngles
			end

			local var_640_13 = arg_637_1.actors_["1095ui_story"]

			if 1.96599999815226 < arg_637_1.time_ and arg_637_1.time_ <= 1.96599999815226 + arg_640_0 and not isNil(var_640_13) and arg_637_1.var_.characterEffect1095ui_story == nil then
				arg_637_1.var_.characterEffect1095ui_story = var_640_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_14 = 0.034000001847744

			if 1.96599999815226 <= arg_637_1.time_ and arg_637_1.time_ < 1.96599999815226 + var_640_14 and not isNil(var_640_13) then
				if arg_637_1.var_.characterEffect1095ui_story and not isNil(var_640_13) then
					arg_637_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_637_1.time_ - 1.96599999815226) / var_640_14)
				end
			end

			if arg_637_1.time_ >= 1.96599999815226 + var_640_14 and arg_637_1.time_ < 1.96599999815226 + var_640_14 + arg_640_0 and not isNil(var_640_13) and arg_637_1.var_.characterEffect1095ui_story then
				arg_637_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 3.775 < arg_637_1.time_ and arg_637_1.time_ <= 3.775 + arg_640_0 then
				arg_637_1:AudioAction("stop", "effect", "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_637_1.frameCnt_ <= 1 then
				arg_637_1.dialog_:SetActive(false)
			end

			local var_640_16 = 4
			local var_640_17 = 0.775

			if 4 < arg_637_1.time_ and arg_637_1.time_ <= var_640_16 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0

				arg_637_1.dialog_:SetActive(true)

				arg_637_1.dialogCg_.alpha = 0

				local var_640_18 = LeanTween.value(arg_637_1.dialog_, 0, 1, 0.3)

				var_640_18:setOnUpdate(LuaHelper.FloatAction(function(arg_641_0)
					arg_637_1.dialogCg_.alpha = arg_641_0
				end))
				var_640_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_637_1.dialog_)
					var_640_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_637_1.duration_ = arg_637_1.duration_ + 0.3

				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_19 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(1109501158).content)

				arg_637_1.text_.text = var_640_19

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_21 = 31 <= 0 and var_640_17 or var_640_17 * (utf8.len(var_640_19) / 31)

				if (31 <= 0 and var_640_17 or var_640_17 * (utf8.len(var_640_19) / 31)) > 0 and var_640_17 < var_640_21 then
					arg_637_1.talkMaxDuration = var_640_21
					var_640_16 = var_640_16 + 0.3

					if var_640_21 + var_640_16 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_21 + var_640_16
					end
				end

				arg_637_1.text_.text = var_640_19
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_22 = var_640_16 + 0.3
			local var_640_23 = math.max(var_640_17, arg_637_1.talkMaxDuration)

			if var_640_16 + 0.3 <= arg_637_1.time_ and arg_637_1.time_ < var_640_22 + var_640_23 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_22) / var_640_23

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_22 + var_640_23 and arg_637_1.time_ < var_640_22 + var_640_23 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_637_1:InitPlayNodeList()
	end,
	Play1109501159 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109501159
		arg_643_1.duration_ = 7

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109501160(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				local var_646_0 = arg_643_1.bgs_.ST02

				arg_643_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_646_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_646_1 = var_646_0:GetComponent("SpriteRenderer")

				if var_646_1 and var_646_1.sprite then
					local var_646_2 = 2 * (var_646_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_646_0.transform.localScale = Vector3.New(var_646_2 / var_646_1.sprite.bounds.size.y < var_646_2 * manager.ui.mainCameraCom_.aspect / var_646_1.sprite.bounds.size.x and var_646_2 * manager.ui.mainCameraCom_.aspect / var_646_1.sprite.bounds.size.x or var_646_2 / var_646_1.sprite.bounds.size.y, var_646_2 / var_646_1.sprite.bounds.size.y < var_646_2 * manager.ui.mainCameraCom_.aspect / var_646_1.sprite.bounds.size.x and var_646_2 * manager.ui.mainCameraCom_.aspect / var_646_1.sprite.bounds.size.x or var_646_2 / var_646_1.sprite.bounds.size.y, 0)
				end

				for iter_646_0, iter_646_1 in pairs(arg_643_1.bgs_) do
					if iter_646_0 ~= "ST02" then
						iter_646_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_646_3 = 1.999999999999

			if 1.999999999999 < arg_643_1.time_ and arg_643_1.time_ <= var_646_3 + arg_646_0 then
				arg_643_1.allBtn_.enabled = false
			end

			if arg_643_1.time_ >= var_646_3 + 0.3 and arg_643_1.time_ < var_646_3 + 0.3 + arg_646_0 then
				arg_643_1.allBtn_.enabled = true
			end

			local var_646_4 = 0

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_5 = 2

			if var_646_4 <= arg_643_1.time_ and arg_643_1.time_ < var_646_4 + var_646_5 then
				local var_646_6 = Color.New(0, 0, 0)

				var_646_6.a = Mathf.Lerp(1, 0, (arg_643_1.time_ - var_646_4) / var_646_5)
				arg_643_1.mask_.color = var_646_6
			end

			if arg_643_1.time_ >= var_646_4 + var_646_5 and arg_643_1.time_ < var_646_4 + var_646_5 + arg_646_0 then
				local var_646_7 = Color.New(0, 0, 0)

				arg_643_1.mask_.enabled = false
				var_646_7.a = 0
				arg_643_1.mask_.color = var_646_7
			end

			local var_646_8 = arg_643_1.actors_["1095ui_story"].transform

			if 1.79999999701977 < arg_643_1.time_ and arg_643_1.time_ <= 1.79999999701977 + arg_646_0 then
				arg_643_1.var_.moveOldPos1095ui_story = var_646_8.localPosition
			end

			local var_646_9 = 0.001

			if 1.79999999701977 <= arg_643_1.time_ and arg_643_1.time_ < 1.79999999701977 + var_646_9 then
				var_646_8.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_643_1.time_ - 1.79999999701977) / var_646_9)
				var_646_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_646_8.position).x, (manager.ui.mainCamera.transform.position - var_646_8.position).y, (manager.ui.mainCamera.transform.position - var_646_8.position).z)
				var_646_8.localEulerAngles.z = 0
				var_646_8.localEulerAngles.x = 0
				var_646_8.localEulerAngles = var_646_8.localEulerAngles
			end

			if arg_643_1.time_ >= 1.79999999701977 + var_646_9 and arg_643_1.time_ < 1.79999999701977 + var_646_9 + arg_646_0 then
				var_646_8.localPosition = Vector3.New(0, -0.98, -6.1)
				var_646_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_646_8.position).x, (manager.ui.mainCamera.transform.position - var_646_8.position).y, (manager.ui.mainCamera.transform.position - var_646_8.position).z)
				var_646_8.localEulerAngles.z = 0
				var_646_8.localEulerAngles.x = 0
				var_646_8.localEulerAngles = var_646_8.localEulerAngles
			end

			local var_646_10 = arg_643_1.actors_["1095ui_story"]

			if 1.79999999701977 < arg_643_1.time_ and arg_643_1.time_ <= 1.79999999701977 + arg_646_0 and not isNil(var_646_10) and arg_643_1.var_.characterEffect1095ui_story == nil then
				arg_643_1.var_.characterEffect1095ui_story = var_646_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_11 = 0.200000002980232

			if 1.79999999701977 <= arg_643_1.time_ and arg_643_1.time_ < 1.79999999701977 + var_646_11 and not isNil(var_646_10) then
				if arg_643_1.var_.characterEffect1095ui_story and not isNil(var_646_10) then
					arg_643_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_643_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_643_1.time_ - 1.79999999701977) / var_646_11)
				end
			end

			if arg_643_1.time_ >= 1.79999999701977 + var_646_11 and arg_643_1.time_ < 1.79999999701977 + var_646_11 + arg_646_0 and not isNil(var_646_10) and arg_643_1.var_.characterEffect1095ui_story then
				arg_643_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_643_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if arg_643_1.frameCnt_ <= 1 then
				arg_643_1.dialog_:SetActive(false)
			end

			local var_646_12 = 2
			local var_646_13 = 0.9

			if 2 < arg_643_1.time_ and arg_643_1.time_ <= var_646_12 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0

				arg_643_1.dialog_:SetActive(true)

				arg_643_1.dialogCg_.alpha = 0

				local var_646_14 = LeanTween.value(arg_643_1.dialog_, 0, 1, 0.3)

				var_646_14:setOnUpdate(LuaHelper.FloatAction(function(arg_647_0)
					arg_643_1.dialogCg_.alpha = arg_647_0
				end))
				var_646_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_643_1.dialog_)
					var_646_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_643_1.duration_ = arg_643_1.duration_ + 0.3

				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_15 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(1109501159).content)

				arg_643_1.text_.text = var_646_15

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_17 = 36 <= 0 and var_646_13 or var_646_13 * (utf8.len(var_646_15) / 36)

				if (36 <= 0 and var_646_13 or var_646_13 * (utf8.len(var_646_15) / 36)) > 0 and var_646_13 < var_646_17 then
					arg_643_1.talkMaxDuration = var_646_17
					var_646_12 = var_646_12 + 0.3

					if var_646_17 + var_646_12 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_17 + var_646_12
					end
				end

				arg_643_1.text_.text = var_646_15
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_18 = var_646_12 + 0.3
			local var_646_19 = math.max(var_646_13, arg_643_1.talkMaxDuration)

			if var_646_12 + 0.3 <= arg_643_1.time_ and arg_643_1.time_ < var_646_18 + var_646_19 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_18) / var_646_19

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_18 + var_646_19 and arg_643_1.time_ < var_646_18 + var_646_19 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1109501160 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1109501160
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1109501161(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.25

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1109501160).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 10 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 10)

				if (10 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 10)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1109501161 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1109501161
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1109501162(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0.625

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_1 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(1109501161).content)

				arg_653_1.text_.text = var_656_1

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_3 = 25 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 25)

				if (25 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 25)) > 0 and var_656_0 < var_656_3 then
					arg_653_1.talkMaxDuration = var_656_3

					if var_656_3 + 0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_3 + 0
					end
				end

				arg_653_1.text_.text = var_656_1
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_4 = math.max(var_656_0, arg_653_1.talkMaxDuration)

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - 0) / var_656_4

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1109501162 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1109501162
		arg_657_1.duration_ = 6.1

		local var_657_0 = {
			zh = 3.8,
			ja = 6.1
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1109501163(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.var_.moveOldPos1095ui_story = arg_657_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_660_0 = 0.001

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 then
				arg_657_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_657_1.time_ - 0) / var_660_0)
				arg_657_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1095ui_story"].transform.position).z)
				arg_657_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1095ui_story"].transform.localEulerAngles = arg_657_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 then
				arg_657_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_657_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1095ui_story"].transform.position).z)
				arg_657_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1095ui_story"].transform.localEulerAngles = arg_657_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_660_1 = arg_657_1.actors_["1095ui_story"]

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1095ui_story == nil then
				arg_657_1.var_.characterEffect1095ui_story = var_660_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_2 and not isNil(var_660_1) then
				if arg_657_1.var_.characterEffect1095ui_story and not isNil(var_660_1) then
					arg_657_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= 0 + var_660_2 and arg_657_1.time_ < 0 + var_660_2 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1095ui_story then
				arg_657_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_660_4 = 0
			local var_660_5 = 0.425

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_6 = arg_657_1:GetWordFromCfg(1109501162)
				local var_660_7 = arg_657_1:FormatText(var_660_6.content)

				arg_657_1.text_.text = var_660_7

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_9 = 17 <= 0 and var_660_5 or var_660_5 * (utf8.len(var_660_7) / 17)

				if (17 <= 0 and var_660_5 or var_660_5 * (utf8.len(var_660_7) / 17)) > 0 and var_660_5 < var_660_9 then
					arg_657_1.talkMaxDuration = var_660_9

					if var_660_9 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_9 + var_660_4
					end
				end

				arg_657_1.text_.text = var_660_7
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501162", "story_v_side_new_1109501.awb") ~= 0 then
					local var_660_10 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501162", "story_v_side_new_1109501.awb") / 1000

					if var_660_10 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_10 + var_660_4
					end

					if var_660_6.prefab_name ~= "" and arg_657_1.actors_[var_660_6.prefab_name] ~= nil then
						local var_660_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_6.prefab_name].transform, "story_v_side_new_1109501", "1109501162", "story_v_side_new_1109501.awb")

						arg_657_1:RecordAudio("1109501162", var_660_11)
						arg_657_1:RecordAudio("1109501162", var_660_11)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501162", "story_v_side_new_1109501.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501162", "story_v_side_new_1109501.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_12 = math.max(var_660_5, arg_657_1.talkMaxDuration)

			if var_660_4 <= arg_657_1.time_ and arg_657_1.time_ < var_660_4 + var_660_12 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_4) / var_660_12

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_4 + var_660_12 and arg_657_1.time_ < var_660_4 + var_660_12 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play1109501163 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1109501163
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1109501164(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["1095ui_story"]) and arg_661_1.var_.characterEffect1095ui_story == nil then
				arg_661_1.var_.characterEffect1095ui_story = arg_661_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_0 = 0.200000002980232

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["1095ui_story"]) then
				if arg_661_1.var_.characterEffect1095ui_story and not isNil(arg_661_1.actors_["1095ui_story"]) then
					arg_661_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_661_1.time_ - 0) / var_664_0)
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["1095ui_story"]) and arg_661_1.var_.characterEffect1095ui_story then
				arg_661_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_664_1 = 0
			local var_664_2 = 0.175

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_3 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(1109501163).content)

				arg_661_1.text_.text = var_664_3

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 7 <= 0 and var_664_2 or var_664_2 * (utf8.len(var_664_3) / 7)

				if (7 <= 0 and var_664_2 or var_664_2 * (utf8.len(var_664_3) / 7)) > 0 and var_664_2 < var_664_5 then
					arg_661_1.talkMaxDuration = var_664_5

					if var_664_5 + var_664_1 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_5 + var_664_1
					end
				end

				arg_661_1.text_.text = var_664_3
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_6 = math.max(var_664_2, arg_661_1.talkMaxDuration)

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_6 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_1) / var_664_6

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_1 + var_664_6 and arg_661_1.time_ < var_664_1 + var_664_6 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1109501164 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1109501164
		arg_665_1.duration_ = 7.87

		local var_665_0 = {
			zh = 7.866,
			ja = 6.3
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1109501165(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 and not isNil(arg_665_1.actors_["1095ui_story"]) and arg_665_1.var_.characterEffect1095ui_story == nil then
				arg_665_1.var_.characterEffect1095ui_story = arg_665_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_0 = 0.200000002980232

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_0 and not isNil(arg_665_1.actors_["1095ui_story"]) then
				if arg_665_1.var_.characterEffect1095ui_story and not isNil(arg_665_1.actors_["1095ui_story"]) then
					arg_665_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= 0 + var_668_0 and arg_665_1.time_ < 0 + var_668_0 + arg_668_0 and not isNil(arg_665_1.actors_["1095ui_story"]) and arg_665_1.var_.characterEffect1095ui_story then
				arg_665_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_668_2 = 0
			local var_668_3 = 0.925

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_2 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_4 = arg_665_1:GetWordFromCfg(1109501164)
				local var_668_5 = arg_665_1:FormatText(var_668_4.content)

				arg_665_1.text_.text = var_668_5

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_7 = 37 <= 0 and var_668_3 or var_668_3 * (utf8.len(var_668_5) / 37)

				if (37 <= 0 and var_668_3 or var_668_3 * (utf8.len(var_668_5) / 37)) > 0 and var_668_3 < var_668_7 then
					arg_665_1.talkMaxDuration = var_668_7

					if var_668_7 + var_668_2 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_7 + var_668_2
					end
				end

				arg_665_1.text_.text = var_668_5
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501164", "story_v_side_new_1109501.awb") ~= 0 then
					local var_668_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501164", "story_v_side_new_1109501.awb") / 1000

					if var_668_8 + var_668_2 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_8 + var_668_2
					end

					if var_668_4.prefab_name ~= "" and arg_665_1.actors_[var_668_4.prefab_name] ~= nil then
						local var_668_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_4.prefab_name].transform, "story_v_side_new_1109501", "1109501164", "story_v_side_new_1109501.awb")

						arg_665_1:RecordAudio("1109501164", var_668_9)
						arg_665_1:RecordAudio("1109501164", var_668_9)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501164", "story_v_side_new_1109501.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501164", "story_v_side_new_1109501.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_10 = math.max(var_668_3, arg_665_1.talkMaxDuration)

			if var_668_2 <= arg_665_1.time_ and arg_665_1.time_ < var_668_2 + var_668_10 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_2) / var_668_10

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_2 + var_668_10 and arg_665_1.time_ < var_668_2 + var_668_10 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1109501165 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1109501165
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1109501166(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(arg_669_1.actors_["1095ui_story"]) and arg_669_1.var_.characterEffect1095ui_story == nil then
				arg_669_1.var_.characterEffect1095ui_story = arg_669_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_0 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 and not isNil(arg_669_1.actors_["1095ui_story"]) then
				if arg_669_1.var_.characterEffect1095ui_story and not isNil(arg_669_1.actors_["1095ui_story"]) then
					arg_669_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_669_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_669_1.time_ - 0) / var_672_0)
				end
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 and not isNil(arg_669_1.actors_["1095ui_story"]) and arg_669_1.var_.characterEffect1095ui_story then
				arg_669_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_669_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_672_1 = 0
			local var_672_2 = 0.225

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_3 = arg_669_1:FormatText(arg_669_1:GetWordFromCfg(1109501165).content)

				arg_669_1.text_.text = var_672_3

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 9 <= 0 and var_672_2 or var_672_2 * (utf8.len(var_672_3) / 9)

				if (9 <= 0 and var_672_2 or var_672_2 * (utf8.len(var_672_3) / 9)) > 0 and var_672_2 < var_672_5 then
					arg_669_1.talkMaxDuration = var_672_5

					if var_672_5 + var_672_1 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_5 + var_672_1
					end
				end

				arg_669_1.text_.text = var_672_3
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_6 = math.max(var_672_2, arg_669_1.talkMaxDuration)

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_6 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_1) / var_672_6

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_1 + var_672_6 and arg_669_1.time_ < var_672_1 + var_672_6 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1109501166 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1109501166
		arg_673_1.duration_ = 5.4

		local var_673_0 = {
			zh = 4.733,
			ja = 5.4
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
			arg_673_1.auto_ = false
		end

		function arg_673_1.playNext_(arg_675_0)
			arg_673_1.onStoryFinished_()
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["1095ui_story"]) and arg_673_1.var_.characterEffect1095ui_story == nil then
				arg_673_1.var_.characterEffect1095ui_story = arg_673_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_0 = 0.200000002980232

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["1095ui_story"]) then
				if arg_673_1.var_.characterEffect1095ui_story and not isNil(arg_673_1.actors_["1095ui_story"]) then
					arg_673_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["1095ui_story"]) and arg_673_1.var_.characterEffect1095ui_story then
				arg_673_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_676_2 = 0
			local var_676_3 = 0.575

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_2 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_4 = arg_673_1:GetWordFromCfg(1109501166)
				local var_676_5 = arg_673_1:FormatText(var_676_4.content)

				arg_673_1.text_.text = var_676_5

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_7 = 23 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_5) / 23)

				if (23 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_5) / 23)) > 0 and var_676_3 < var_676_7 then
					arg_673_1.talkMaxDuration = var_676_7

					if var_676_7 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_7 + var_676_2
					end
				end

				arg_673_1.text_.text = var_676_5
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501166", "story_v_side_new_1109501.awb") ~= 0 then
					local var_676_8 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501166", "story_v_side_new_1109501.awb") / 1000

					if var_676_8 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_8 + var_676_2
					end

					if var_676_4.prefab_name ~= "" and arg_673_1.actors_[var_676_4.prefab_name] ~= nil then
						local var_676_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_4.prefab_name].transform, "story_v_side_new_1109501", "1109501166", "story_v_side_new_1109501.awb")

						arg_673_1:RecordAudio("1109501166", var_676_9)
						arg_673_1:RecordAudio("1109501166", var_676_9)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501166", "story_v_side_new_1109501.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501166", "story_v_side_new_1109501.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_10 = math.max(var_676_3, arg_673_1.talkMaxDuration)

			if var_676_2 <= arg_673_1.time_ and arg_673_1.time_ < var_676_2 + var_676_10 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_2) / var_676_10

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_2 + var_676_10 and arg_673_1.time_ < var_676_2 + var_676_10 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1109501022 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1109501022
		arg_677_1.duration_ = 3.37

		local var_677_0 = {
			zh = 3.266,
			ja = 3.366
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1109501023(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 and not isNil(arg_677_1.actors_["1095ui_story"]) and arg_677_1.var_.characterEffect1095ui_story == nil then
				arg_677_1.var_.characterEffect1095ui_story = arg_677_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_0 = 0.200000002980232

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_0 and not isNil(arg_677_1.actors_["1095ui_story"]) then
				if arg_677_1.var_.characterEffect1095ui_story and not isNil(arg_677_1.actors_["1095ui_story"]) then
					arg_677_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= 0 + var_680_0 and arg_677_1.time_ < 0 + var_680_0 + arg_680_0 and not isNil(arg_677_1.actors_["1095ui_story"]) and arg_677_1.var_.characterEffect1095ui_story then
				arg_677_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_680_2 = "1095ui_story"

			if arg_677_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_680_3 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_677_1.stage_.transform)

				var_680_3.name = var_680_2
				var_680_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.actors_[var_680_2] = var_680_3

				local var_680_4 = var_680_3:GetComponentInChildren(typeof(CharacterEffect))

				var_680_4.enabled = true

				local var_680_5 = GameObjectTools.GetOrAddComponent(var_680_3, typeof(DynamicBoneHelper))

				if var_680_5 then
					var_680_5:EnableDynamicBone(false)
				end

				arg_677_1:ShowWeapon(var_680_4.transform, false)

				arg_677_1.var_[var_680_2 .. "Animator"] = var_680_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_677_1.var_[var_680_2 .. "Animator"].applyRootMotion = true
				arg_677_1.var_[var_680_2 .. "LipSync"] = var_680_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_680_6 = "1095ui_story"

			if arg_677_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_680_7 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_677_1.stage_.transform)

				var_680_7.name = var_680_6
				var_680_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.actors_[var_680_6] = var_680_7

				local var_680_8 = var_680_7:GetComponentInChildren(typeof(CharacterEffect))

				var_680_8.enabled = true

				local var_680_9 = GameObjectTools.GetOrAddComponent(var_680_7, typeof(DynamicBoneHelper))

				if var_680_9 then
					var_680_9:EnableDynamicBone(false)
				end

				arg_677_1:ShowWeapon(var_680_8.transform, false)

				arg_677_1.var_[var_680_6 .. "Animator"] = var_680_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_677_1.var_[var_680_6 .. "Animator"].applyRootMotion = true
				arg_677_1.var_[var_680_6 .. "LipSync"] = var_680_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_680_10 = 0
			local var_680_11 = 0.325

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_10 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_12 = arg_677_1:GetWordFromCfg(1109501022)
				local var_680_13 = arg_677_1:FormatText(var_680_12.content)

				arg_677_1.text_.text = var_680_13

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_15 = 13 <= 0 and var_680_11 or var_680_11 * (utf8.len(var_680_13) / 13)

				if (13 <= 0 and var_680_11 or var_680_11 * (utf8.len(var_680_13) / 13)) > 0 and var_680_11 < var_680_15 then
					arg_677_1.talkMaxDuration = var_680_15

					if var_680_15 + var_680_10 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_15 + var_680_10
					end
				end

				arg_677_1.text_.text = var_680_13
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501022", "story_v_side_new_1109501.awb") ~= 0 then
					local var_680_16 = manager.audio:GetVoiceLength("story_v_side_new_1109501", "1109501022", "story_v_side_new_1109501.awb") / 1000

					if var_680_16 + var_680_10 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_16 + var_680_10
					end

					if var_680_12.prefab_name ~= "" and arg_677_1.actors_[var_680_12.prefab_name] ~= nil then
						local var_680_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_12.prefab_name].transform, "story_v_side_new_1109501", "1109501022", "story_v_side_new_1109501.awb")

						arg_677_1:RecordAudio("1109501022", var_680_17)
						arg_677_1:RecordAudio("1109501022", var_680_17)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_side_new_1109501", "1109501022", "story_v_side_new_1109501.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_side_new_1109501", "1109501022", "story_v_side_new_1109501.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_18 = math.max(var_680_11, arg_677_1.talkMaxDuration)

			if var_680_10 <= arg_677_1.time_ and arg_677_1.time_ < var_680_10 + var_680_18 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_10) / var_680_18

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_10 + var_680_18 and arg_677_1.time_ < var_680_10 + var_680_18 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_side_new_1109501.awb"
	}
}
