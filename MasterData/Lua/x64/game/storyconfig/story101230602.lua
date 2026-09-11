return {
	Play123062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K05f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_4_0.name = "K05f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K05f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K05f

				arg_1_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K05f" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

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
			local var_4_15 = 1.675

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123062001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 67 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 67)

				if (67 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 67)) > 0 and var_4_15 < var_4_19 then
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
	Play123062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123062002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.55

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(123062002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 22)

				if (22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 22)) > 0 and var_12_0 < var_12_3 then
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
	Play123062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123062003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.5

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(123062003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 20)

				if (20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 20)) > 0 and var_16_0 < var_16_3 then
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
	Play123062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123062004
		arg_17_1.duration_ = 3.43

		local var_17_0 = {
			zh = 3.433,
			ja = 3.1
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
				arg_17_0:Play123062005(arg_17_1)
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
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1093ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_8 = "1050ui_story"

			if arg_17_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_20_9 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_17_1.stage_.transform)

				var_20_9.name = var_20_8
				var_20_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_8] = var_20_9

				local var_20_10 = var_20_9:GetComponentInChildren(typeof(CharacterEffect))

				var_20_10.enabled = true

				local var_20_11 = GameObjectTools.GetOrAddComponent(var_20_9, typeof(DynamicBoneHelper))

				if var_20_11 then
					var_20_11:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_10.transform, false)

				arg_17_1.var_[var_20_8 .. "Animator"] = var_20_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_8 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_8 .. "LipSync"] = var_20_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_12 = arg_17_1.actors_["1050ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1050ui_story = var_20_12.localPosition
			end

			local var_20_13 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_13 then
				var_20_12.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_17_1.time_ - 0) / var_20_13)
				var_20_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_12.position).x, (manager.ui.mainCamera.transform.position - var_20_12.position).y, (manager.ui.mainCamera.transform.position - var_20_12.position).z)
				var_20_12.localEulerAngles.z = 0
				var_20_12.localEulerAngles.x = 0
				var_20_12.localEulerAngles = var_20_12.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_13 and arg_17_1.time_ < 0 + var_20_13 + arg_20_0 then
				var_20_12.localPosition = Vector3.New(0.7, -1, -6.1)
				var_20_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_12.position).x, (manager.ui.mainCamera.transform.position - var_20_12.position).y, (manager.ui.mainCamera.transform.position - var_20_12.position).z)
				var_20_12.localEulerAngles.z = 0
				var_20_12.localEulerAngles.x = 0
				var_20_12.localEulerAngles = var_20_12.localEulerAngles
			end

			local var_20_14 = arg_17_1.actors_["1050ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1050ui_story == nil then
				arg_17_1.var_.characterEffect1050ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_15 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_15 and not isNil(var_20_14) then
				if arg_17_1.var_.characterEffect1050ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_15)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_15 and arg_17_1.time_ < 0 + var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1050ui_story then
				arg_17_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_20_16 = 0
			local var_20_17 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
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

				local var_20_18 = arg_17_1:GetWordFromCfg(123062004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 15 <= 0 and var_20_17 or var_20_17 * (utf8.len(var_20_19) / 15)

				if (15 <= 0 and var_20_17 or var_20_17 * (utf8.len(var_20_19) / 15)) > 0 and var_20_17 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062004", "story_v_out_123062.awb") ~= 0 then
					local var_20_22 = manager.audio:GetVoiceLength("story_v_out_123062", "123062004", "story_v_out_123062.awb") / 1000

					if var_20_22 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_16
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_123062", "123062004", "story_v_out_123062.awb")

						arg_17_1:RecordAudio("123062004", var_20_23)
						arg_17_1:RecordAudio("123062004", var_20_23)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123062", "123062004", "story_v_out_123062.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123062", "123062004", "story_v_out_123062.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_16) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_16 + var_20_24 and arg_17_1.time_ < var_20_16 + var_20_24 + arg_20_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play123062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123062005
		arg_21_1.duration_ = 3.9

		local var_21_0 = {
			zh = 2.833,
			ja = 3.9
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1050ui_story = arg_21_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1050ui_story"].transform.position).z)
				arg_21_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1050ui_story"].transform.localEulerAngles = arg_21_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.1)
				arg_21_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1050ui_story"].transform.position).z)
				arg_21_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1050ui_story"].transform.localEulerAngles = arg_21_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1050ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1050ui_story == nil then
				arg_21_1.var_.characterEffect1050ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1050ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1050ui_story then
				arg_21_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_24_4 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_24_6 = 0
			local var_24_7 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(123062005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 7 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 7)

				if (7 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 7)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062005", "story_v_out_123062.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_123062", "123062005", "story_v_out_123062.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_123062", "123062005", "story_v_out_123062.awb")

						arg_21_1:RecordAudio("123062005", var_24_13)
						arg_21_1:RecordAudio("123062005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123062", "123062005", "story_v_out_123062.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123062", "123062005", "story_v_out_123062.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play123062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123062006
		arg_25_1.duration_ = 7.8

		local var_25_0 = {
			zh = 4.4,
			ja = 7.8
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
				arg_25_0:Play123062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1093ui_story"]) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = arg_25_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1093ui_story"]) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(arg_25_1.actors_["1093ui_story"]) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1093ui_story"]) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_2 = arg_25_1.actors_["1050ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1050ui_story == nil then
				arg_25_1.var_.characterEffect1050ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1050ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1050ui_story then
				arg_25_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
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

				local var_28_6 = arg_25_1:GetWordFromCfg(123062006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 22 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 22)

				if (22 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 22)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062006", "story_v_out_123062.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062006", "story_v_out_123062.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_123062", "123062006", "story_v_out_123062.awb")

						arg_25_1:RecordAudio("123062006", var_28_11)
						arg_25_1:RecordAudio("123062006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_123062", "123062006", "story_v_out_123062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_123062", "123062006", "story_v_out_123062.awb")
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play123062007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123062007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123062008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1050ui_story = arg_29_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).z)
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles = arg_29_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.1)
				arg_29_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1050ui_story"].transform.position).z)
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1050ui_story"].transform.localEulerAngles = arg_29_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1050ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1050ui_story == nil then
				arg_29_1.var_.characterEffect1050ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1050ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1050ui_story then
				arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_4 = arg_29_1.actors_["1093ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1093ui_story == nil then
				arg_29_1.var_.characterEffect1093ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_5 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 and not isNil(var_32_4) then
				if arg_29_1.var_.characterEffect1093ui_story and not isNil(var_32_4) then
					arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_5)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1093ui_story then
				arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_32_6 = 0
			local var_32_7 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(123062007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 3 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 3)

				if (3 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 3)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062007", "story_v_out_123062.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_123062", "123062007", "story_v_out_123062.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_123062", "123062007", "story_v_out_123062.awb")

						arg_29_1:RecordAudio("123062007", var_32_13)
						arg_29_1:RecordAudio("123062007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_123062", "123062007", "story_v_out_123062.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_123062", "123062007", "story_v_out_123062.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play123062008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123062008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123062009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1093ui_story = arg_33_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1093ui_story"].transform.position).z)
				arg_33_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1093ui_story"].transform.localEulerAngles = arg_33_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1093ui_story"].transform.position).z)
				arg_33_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1093ui_story"].transform.localEulerAngles = arg_33_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1093ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_36_3 = arg_33_1.actors_["1050ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1050ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, 100, 0)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1050ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1050ui_story == nil then
				arg_33_1.var_.characterEffect1050ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1050ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_6)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1050ui_story then
				arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_36_7 = 0
			local var_36_8 = 1.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(123062008).content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 54 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_9) / 54)

				if (54 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_9) / 54)) > 0 and var_36_8 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_12 and arg_33_1.time_ < var_36_7 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play123062009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123062009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play123062010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(123062009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 48 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 48)

				if (48 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 48)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play123062010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123062010
		arg_41_1.duration_ = 9

		local var_41_0 = {
			zh = 9,
			ja = 8.7
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
				arg_41_0:Play123062011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1093ui_story = arg_41_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).z)
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles = arg_41_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_41_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).z)
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles = arg_41_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1093ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1093ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_44_3 = arg_41_1.actors_["1050ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1050ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(0.7, -1, -6.1)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["1050ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect1050ui_story == nil then
				arg_41_1.var_.characterEffect1050ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect1050ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect1050ui_story then
				arg_41_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_8 = 0
			local var_44_9 = 1.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(123062010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 45 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 45)

				if (45 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 45)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062010", "story_v_out_123062.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_123062", "123062010", "story_v_out_123062.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_123062", "123062010", "story_v_out_123062.awb")

						arg_41_1:RecordAudio("123062010", var_44_15)
						arg_41_1:RecordAudio("123062010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123062", "123062010", "story_v_out_123062.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123062", "123062010", "story_v_out_123062.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
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
	Play123062011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123062011
		arg_45_1.duration_ = 9.6

		local var_45_0 = {
			zh = 7.766,
			ja = 9.6
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123062012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_0 = 0
			local var_48_1 = 1.025

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(123062011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 41 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 41)

				if (41 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 41)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062011", "story_v_out_123062.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_123062", "123062011", "story_v_out_123062.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_123062", "123062011", "story_v_out_123062.awb")

						arg_45_1:RecordAudio("123062011", var_48_7)
						arg_45_1:RecordAudio("123062011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123062", "123062011", "story_v_out_123062.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123062", "123062011", "story_v_out_123062.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123062012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123062012
		arg_49_1.duration_ = 10.37

		local var_49_0 = {
			zh = 10.366,
			ja = 8.466
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
				arg_49_0:Play123062013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = arg_49_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) then
				if arg_49_1.var_.characterEffect1093ui_story and not isNil(arg_49_1.actors_["1093ui_story"]) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_52_2 = arg_49_1.actors_["1050ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1050ui_story == nil then
				arg_49_1.var_.characterEffect1050ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1050ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1050ui_story then
				arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 1.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
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

				local var_52_6 = arg_49_1:GetWordFromCfg(123062012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 42 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 42)

				if (42 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 42)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062012", "story_v_out_123062.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062012", "story_v_out_123062.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_123062", "123062012", "story_v_out_123062.awb")

						arg_49_1:RecordAudio("123062012", var_52_11)
						arg_49_1:RecordAudio("123062012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_123062", "123062012", "story_v_out_123062.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_123062", "123062012", "story_v_out_123062.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123062013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123062013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play123062014(arg_53_1)
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

			local var_56_1 = arg_53_1.actors_["1093ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1093ui_story == nil then
				arg_53_1.var_.characterEffect1093ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1093ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1093ui_story then
				arg_53_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_56_3 = arg_53_1.actors_["1050ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1050ui_story = var_56_3.localPosition
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(0, 100, 0)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["1050ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1050ui_story == nil then
				arg_53_1.var_.characterEffect1050ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect1050ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_6)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1050ui_story then
				arg_53_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_56_7 = 0
			local var_56_8 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_9 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(123062013).content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 33 <= 0 and var_56_8 or var_56_8 * (utf8.len(var_56_9) / 33)

				if (33 <= 0 and var_56_8 or var_56_8 * (utf8.len(var_56_9) / 33)) > 0 and var_56_8 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_7) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_7 + var_56_12 and arg_53_1.time_ < var_56_7 + var_56_12 + arg_56_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play123062014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123062014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play123062015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(123062014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 20 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 20)

				if (20 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 20)) > 0 and var_60_0 < var_60_3 then
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
	Play123062015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123062015
		arg_61_1.duration_ = 9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123062016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_0 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				local var_64_1 = Color.New(0, 0, 0)

				var_64_1.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.mask_.color = var_64_1
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				local var_64_2 = Color.New(0, 0, 0)

				var_64_2.a = 1
				arg_61_1.mask_.color = var_64_2
			end

			local var_64_3 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_4 = 2

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 then
				local var_64_5 = Color.New(0, 0, 0)

				var_64_5.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_3) / var_64_4)
				arg_61_1.mask_.color = var_64_5
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 then
				local var_64_6 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_6.a = 0
				arg_61_1.mask_.color = var_64_6
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_7 = 3.999999999999
			local var_64_8 = 1.15

			if 3.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_9 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_9:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(123062015).content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_12 = 46 <= 0 and var_64_8 or var_64_8 * (utf8.len(var_64_10) / 46)

				if (46 <= 0 and var_64_8 or var_64_8 * (utf8.len(var_64_10) / 46)) > 0 and var_64_8 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12
					var_64_7 = var_64_7 + 0.3

					if var_64_12 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_7
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = var_64_7 + 0.3
			local var_64_14 = math.max(var_64_8, arg_61_1.talkMaxDuration)

			if var_64_7 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_13 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_13) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_13 + var_64_14 and arg_61_1.time_ < var_64_13 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123062016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 123062016
		arg_67_1.duration_ = 4.63

		local var_67_0 = {
			zh = 3.5,
			ja = 4.633
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play123062017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.actors_["10048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10048ui_story"))) then
				local var_70_0 = Object.Instantiate(Asset.Load("Char/" .. "10048ui_story"), arg_67_1.stage_.transform)

				var_70_0.name = "10048ui_story"
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["10048ui_story"] = var_70_0

				local var_70_1 = var_70_0:GetComponentInChildren(typeof(CharacterEffect))

				var_70_1.enabled = true

				local var_70_2 = GameObjectTools.GetOrAddComponent(var_70_0, typeof(DynamicBoneHelper))

				if var_70_2 then
					var_70_2:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_1.transform, false)

				arg_67_1.var_["10048ui_story" .. "Animator"] = var_70_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_["10048ui_story" .. "Animator"].applyRootMotion = true
				arg_67_1.var_["10048ui_story" .. "LipSync"] = var_70_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_3 = arg_67_1.actors_["10048ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10048ui_story = var_70_3.localPosition
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_3.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10048ui_story, Vector3.New(-0.7, -1.155, -6.13), (arg_67_1.time_ - 0) / var_70_4)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_3.localPosition = Vector3.New(-0.7, -1.155, -6.13)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			local var_70_5 = arg_67_1.actors_["10048ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10048ui_story == nil then
				arg_67_1.var_.characterEffect10048ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect10048ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10048ui_story then
				arg_67_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action1_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_70_8 = "1055ui_story"

			if arg_67_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_70_9 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_67_1.stage_.transform)

				var_70_9.name = var_70_8
				var_70_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_[var_70_8] = var_70_9

				local var_70_10 = var_70_9:GetComponentInChildren(typeof(CharacterEffect))

				var_70_10.enabled = true

				local var_70_11 = GameObjectTools.GetOrAddComponent(var_70_9, typeof(DynamicBoneHelper))

				if var_70_11 then
					var_70_11:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_10.transform, false)

				arg_67_1.var_[var_70_8 .. "Animator"] = var_70_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_[var_70_8 .. "Animator"].applyRootMotion = true
				arg_67_1.var_[var_70_8 .. "LipSync"] = var_70_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_12 = arg_67_1.actors_["1055ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1055ui_story = var_70_12.localPosition
			end

			local var_70_13 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_13 then
				var_70_12.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_67_1.time_ - 0) / var_70_13)
				var_70_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_12.position).x, (manager.ui.mainCamera.transform.position - var_70_12.position).y, (manager.ui.mainCamera.transform.position - var_70_12.position).z)
				var_70_12.localEulerAngles.z = 0
				var_70_12.localEulerAngles.x = 0
				var_70_12.localEulerAngles = var_70_12.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_13 and arg_67_1.time_ < 0 + var_70_13 + arg_70_0 then
				var_70_12.localPosition = Vector3.New(0.7, -0.965, -6.2)
				var_70_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_12.position).x, (manager.ui.mainCamera.transform.position - var_70_12.position).y, (manager.ui.mainCamera.transform.position - var_70_12.position).z)
				var_70_12.localEulerAngles.z = 0
				var_70_12.localEulerAngles.x = 0
				var_70_12.localEulerAngles = var_70_12.localEulerAngles
			end

			local var_70_14 = arg_67_1.actors_["1055ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_14) and arg_67_1.var_.characterEffect1055ui_story == nil then
				arg_67_1.var_.characterEffect1055ui_story = var_70_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_15 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_15 and not isNil(var_70_14) then
				if arg_67_1.var_.characterEffect1055ui_story and not isNil(var_70_14) then
					arg_67_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_15)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_15 and arg_67_1.time_ < 0 + var_70_15 + arg_70_0 and not isNil(var_70_14) and arg_67_1.var_.characterEffect1055ui_story then
				arg_67_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_70_16 = 0
			local var_70_17 = 0.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(123062016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_21 = 18 <= 0 and var_70_17 or var_70_17 * (utf8.len(var_70_19) / 18)

				if (18 <= 0 and var_70_17 or var_70_17 * (utf8.len(var_70_19) / 18)) > 0 and var_70_17 < var_70_21 then
					arg_67_1.talkMaxDuration = var_70_21

					if var_70_21 + var_70_16 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_21 + var_70_16
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062016", "story_v_out_123062.awb") ~= 0 then
					local var_70_22 = manager.audio:GetVoiceLength("story_v_out_123062", "123062016", "story_v_out_123062.awb") / 1000

					if var_70_22 + var_70_16 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_16
					end

					if var_70_18.prefab_name ~= "" and arg_67_1.actors_[var_70_18.prefab_name] ~= nil then
						local var_70_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_18.prefab_name].transform, "story_v_out_123062", "123062016", "story_v_out_123062.awb")

						arg_67_1:RecordAudio("123062016", var_70_23)
						arg_67_1:RecordAudio("123062016", var_70_23)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_123062", "123062016", "story_v_out_123062.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_123062", "123062016", "story_v_out_123062.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_24 = math.max(var_70_17, arg_67_1.talkMaxDuration)

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_24 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_16) / var_70_24

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_16 + var_70_24 and arg_67_1.time_ < var_70_16 + var_70_24 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play123062017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 123062017
		arg_71_1.duration_ = 5.47

		local var_71_0 = {
			zh = 4.9,
			ja = 5.466
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play123062018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1055ui_story"]) and arg_71_1.var_.characterEffect1055ui_story == nil then
				arg_71_1.var_.characterEffect1055ui_story = arg_71_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1055ui_story"]) then
				if arg_71_1.var_.characterEffect1055ui_story and not isNil(arg_71_1.actors_["1055ui_story"]) then
					arg_71_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1055ui_story"]) and arg_71_1.var_.characterEffect1055ui_story then
				arg_71_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_2 = arg_71_1.actors_["10048ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect10048ui_story == nil then
				arg_71_1.var_.characterEffect10048ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect10048ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect10048ui_story then
				arg_71_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_74_4 = 0
			local var_74_5 = 0.575

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(123062017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 23 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 23)

				if (23 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 23)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062017", "story_v_out_123062.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062017", "story_v_out_123062.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_123062", "123062017", "story_v_out_123062.awb")

						arg_71_1:RecordAudio("123062017", var_74_11)
						arg_71_1:RecordAudio("123062017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_123062", "123062017", "story_v_out_123062.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_123062", "123062017", "story_v_out_123062.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play123062018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 123062018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play123062019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1055ui_story"]) and arg_75_1.var_.characterEffect1055ui_story == nil then
				arg_75_1.var_.characterEffect1055ui_story = arg_75_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1055ui_story"]) then
				if arg_75_1.var_.characterEffect1055ui_story and not isNil(arg_75_1.actors_["1055ui_story"]) then
					arg_75_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1055ui_story"]) and arg_75_1.var_.characterEffect1055ui_story then
				arg_75_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1.4

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(123062018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 56 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 56)

				if (56 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 56)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play123062019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 123062019
		arg_79_1.duration_ = 5.5

		local var_79_0 = {
			zh = 5.5,
			ja = 5.233
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play123062020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action3_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_82_0 = arg_79_1.actors_["10048ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10048ui_story == nil then
				arg_79_1.var_.characterEffect10048ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect10048ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10048ui_story then
				arg_79_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_82_3 = 0
			local var_82_4 = 0.725

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:GetWordFromCfg(123062019)
				local var_82_6 = arg_79_1:FormatText(var_82_5.content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 29 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 29)

				if (29 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 29)) > 0 and var_82_4 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062019", "story_v_out_123062.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_out_123062", "123062019", "story_v_out_123062.awb") / 1000

					if var_82_9 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_3
					end

					if var_82_5.prefab_name ~= "" and arg_79_1.actors_[var_82_5.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_5.prefab_name].transform, "story_v_out_123062", "123062019", "story_v_out_123062.awb")

						arg_79_1:RecordAudio("123062019", var_82_10)
						arg_79_1:RecordAudio("123062019", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_123062", "123062019", "story_v_out_123062.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_123062", "123062019", "story_v_out_123062.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_11 and arg_79_1.time_ < var_82_3 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play123062020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 123062020
		arg_83_1.duration_ = 10.27

		local var_83_0 = {
			zh = 7.233,
			ja = 10.266
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play123062021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1055ui_story"]) and arg_83_1.var_.characterEffect1055ui_story == nil then
				arg_83_1.var_.characterEffect1055ui_story = arg_83_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1055ui_story"]) then
				if arg_83_1.var_.characterEffect1055ui_story and not isNil(arg_83_1.actors_["1055ui_story"]) then
					arg_83_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1055ui_story"]) and arg_83_1.var_.characterEffect1055ui_story then
				arg_83_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_2 = arg_83_1.actors_["10048ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect10048ui_story == nil then
				arg_83_1.var_.characterEffect10048ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_3 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.characterEffect10048ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_3)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect10048ui_story then
				arg_83_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_86_4 = 0
			local var_86_5 = 0.575

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(123062020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 23 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 23)

				if (23 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 23)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062020", "story_v_out_123062.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062020", "story_v_out_123062.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_out_123062", "123062020", "story_v_out_123062.awb")

						arg_83_1:RecordAudio("123062020", var_86_11)
						arg_83_1:RecordAudio("123062020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_123062", "123062020", "story_v_out_123062.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_123062", "123062020", "story_v_out_123062.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play123062021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 123062021
		arg_87_1.duration_ = 10

		local var_87_0 = {
			zh = 10,
			ja = 8.2
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play123062022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				local var_90_0 = arg_87_1.bgs_.K05f

				arg_87_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_1 = var_90_0:GetComponent("SpriteRenderer")

				if var_90_1 and var_90_1.sprite then
					local var_90_2 = 2 * (var_90_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_0.transform.localScale = Vector3.New(var_90_2 / var_90_1.sprite.bounds.size.y < var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x and var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x or var_90_2 / var_90_1.sprite.bounds.size.y, var_90_2 / var_90_1.sprite.bounds.size.y < var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x and var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x or var_90_2 / var_90_1.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "K05f" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_3 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_4 = 2

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_4 then
				local var_90_5 = Color.New(0, 0, 0)

				var_90_5.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_3) / var_90_4)
				arg_87_1.mask_.color = var_90_5
			end

			if arg_87_1.time_ >= var_90_3 + var_90_4 and arg_87_1.time_ < var_90_3 + var_90_4 + arg_90_0 then
				local var_90_6 = Color.New(0, 0, 0)

				var_90_6.a = 1
				arg_87_1.mask_.color = var_90_6
			end

			local var_90_7 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_8 = 2

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 then
				local var_90_9 = Color.New(0, 0, 0)

				var_90_9.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_7) / var_90_8)
				arg_87_1.mask_.color = var_90_9
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 then
				local var_90_10 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_10.a = 0
				arg_87_1.mask_.color = var_90_10
			end

			local var_90_11 = arg_87_1.actors_["10048ui_story"]

			if 3.8 < arg_87_1.time_ and arg_87_1.time_ <= 3.8 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.characterEffect10048ui_story == nil then
				arg_87_1.var_.characterEffect10048ui_story = var_90_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_12 = 0.200000002980232

			if 3.8 <= arg_87_1.time_ and arg_87_1.time_ < 3.8 + var_90_12 and not isNil(var_90_11) then
				if arg_87_1.var_.characterEffect10048ui_story and not isNil(var_90_11) then
					arg_87_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 3.8 + var_90_12 and arg_87_1.time_ < 3.8 + var_90_12 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.characterEffect10048ui_story then
				arg_87_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 3.8 < arg_87_1.time_ and arg_87_1.time_ <= 3.8 + arg_90_0 then
				arg_87_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048actionlink/10048action432")
			end

			if 3.8 < arg_87_1.time_ and arg_87_1.time_ <= 3.8 + arg_90_0 then
				arg_87_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_14 = 4
			local var_90_15 = 0.9

			if 4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_16 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_16:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_17 = arg_87_1:GetWordFromCfg(123062021)
				local var_90_18 = arg_87_1:FormatText(var_90_17.content)

				arg_87_1.text_.text = var_90_18

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 36 <= 0 and var_90_15 or var_90_15 * (utf8.len(var_90_18) / 36)

				if (36 <= 0 and var_90_15 or var_90_15 * (utf8.len(var_90_18) / 36)) > 0 and var_90_15 < var_90_20 then
					arg_87_1.talkMaxDuration = var_90_20
					var_90_14 = var_90_14 + 0.3

					if var_90_20 + var_90_14 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_14
					end
				end

				arg_87_1.text_.text = var_90_18
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062021", "story_v_out_123062.awb") ~= 0 then
					local var_90_21 = manager.audio:GetVoiceLength("story_v_out_123062", "123062021", "story_v_out_123062.awb") / 1000

					if var_90_21 + var_90_14 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_21 + var_90_14
					end

					if var_90_17.prefab_name ~= "" and arg_87_1.actors_[var_90_17.prefab_name] ~= nil then
						local var_90_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_17.prefab_name].transform, "story_v_out_123062", "123062021", "story_v_out_123062.awb")

						arg_87_1:RecordAudio("123062021", var_90_22)
						arg_87_1:RecordAudio("123062021", var_90_22)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_123062", "123062021", "story_v_out_123062.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_123062", "123062021", "story_v_out_123062.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_23 = var_90_14 + 0.3
			local var_90_24 = math.max(var_90_15, arg_87_1.talkMaxDuration)

			if var_90_14 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_23) / var_90_24

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play123062022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123062022
		arg_93_1.duration_ = 3.8

		local var_93_0 = {
			zh = 2.7,
			ja = 3.8
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play123062023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1055ui_story"]) and arg_93_1.var_.characterEffect1055ui_story == nil then
				arg_93_1.var_.characterEffect1055ui_story = arg_93_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1055ui_story"]) then
				if arg_93_1.var_.characterEffect1055ui_story and not isNil(arg_93_1.actors_["1055ui_story"]) then
					arg_93_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1055ui_story"]) and arg_93_1.var_.characterEffect1055ui_story then
				arg_93_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_96_2 = arg_93_1.actors_["10048ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect10048ui_story == nil then
				arg_93_1.var_.characterEffect10048ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect10048ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect10048ui_story then
				arg_93_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_96_4 = 0
			local var_96_5 = 0.4

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(123062022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 16 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 16)

				if (16 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 16)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062022", "story_v_out_123062.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062022", "story_v_out_123062.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_123062", "123062022", "story_v_out_123062.awb")

						arg_93_1:RecordAudio("123062022", var_96_11)
						arg_93_1:RecordAudio("123062022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123062", "123062022", "story_v_out_123062.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123062", "123062022", "story_v_out_123062.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123062023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123062023
		arg_97_1.duration_ = 3.03

		local var_97_0 = {
			zh = 2.866,
			ja = 3.033
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
				arg_97_0:Play123062024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1055ui_story"]) and arg_97_1.var_.characterEffect1055ui_story == nil then
				arg_97_1.var_.characterEffect1055ui_story = arg_97_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1055ui_story"]) then
				if arg_97_1.var_.characterEffect1055ui_story and not isNil(arg_97_1.actors_["1055ui_story"]) then
					arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1055ui_story"]) and arg_97_1.var_.characterEffect1055ui_story then
				arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_100_1 = arg_97_1.actors_["10048ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10048ui_story == nil then
				arg_97_1.var_.characterEffect10048ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10048ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10048ui_story then
				arg_97_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(123062023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 12 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 12)

				if (12 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 12)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062023", "story_v_out_123062.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062023", "story_v_out_123062.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_123062", "123062023", "story_v_out_123062.awb")

						arg_97_1:RecordAudio("123062023", var_100_11)
						arg_97_1:RecordAudio("123062023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123062", "123062023", "story_v_out_123062.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123062", "123062023", "story_v_out_123062.awb")
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

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play123062024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123062024
		arg_101_1.duration_ = 18.37

		local var_101_0 = {
			zh = 11.366,
			ja = 18.366
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play123062025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1055ui_story"]) and arg_101_1.var_.characterEffect1055ui_story == nil then
				arg_101_1.var_.characterEffect1055ui_story = arg_101_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1055ui_story"]) then
				if arg_101_1.var_.characterEffect1055ui_story and not isNil(arg_101_1.actors_["1055ui_story"]) then
					arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1055ui_story"]) and arg_101_1.var_.characterEffect1055ui_story then
				arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["10048ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect10048ui_story == nil then
				arg_101_1.var_.characterEffect10048ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect10048ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect10048ui_story then
				arg_101_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_104_4 = 0
			local var_104_5 = 1.425

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(123062024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 57 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 57)

				if (57 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 57)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062024", "story_v_out_123062.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062024", "story_v_out_123062.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_123062", "123062024", "story_v_out_123062.awb")

						arg_101_1:RecordAudio("123062024", var_104_11)
						arg_101_1:RecordAudio("123062024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123062", "123062024", "story_v_out_123062.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123062", "123062024", "story_v_out_123062.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play123062025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123062025
		arg_105_1.duration_ = 6.3

		local var_105_0 = {
			zh = 6.3,
			ja = 4.033
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
				arg_105_0:Play123062026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_108_0 = arg_105_1.actors_["1055ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story == nil then
				arg_105_1.var_.characterEffect1055ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_1 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 and not isNil(var_108_0) then
				if arg_105_1.var_.characterEffect1055ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_1)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story then
				arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_108_2 = arg_105_1.actors_["10048ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10048ui_story == nil then
				arg_105_1.var_.characterEffect10048ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect10048ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10048ui_story then
				arg_105_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_108_5 = 0
			local var_108_6 = 0.75

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(123062025)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 30 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 30)

				if (30 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 30)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062025", "story_v_out_123062.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_123062", "123062025", "story_v_out_123062.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_123062", "123062025", "story_v_out_123062.awb")

						arg_105_1:RecordAudio("123062025", var_108_12)
						arg_105_1:RecordAudio("123062025", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_123062", "123062025", "story_v_out_123062.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_123062", "123062025", "story_v_out_123062.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_13 and arg_105_1.time_ < var_108_5 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123062026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123062026
		arg_109_1.duration_ = 5.2

		local var_109_0 = {
			zh = 5.133,
			ja = 5.2
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play123062027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10048ui_story"]) and arg_109_1.var_.characterEffect10048ui_story == nil then
				arg_109_1.var_.characterEffect10048ui_story = arg_109_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10048ui_story"]) then
				if arg_109_1.var_.characterEffect10048ui_story and not isNil(arg_109_1.actors_["10048ui_story"]) then
					arg_109_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10048ui_story"]) and arg_109_1.var_.characterEffect10048ui_story then
				arg_109_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_112_1 = arg_109_1.actors_["1055ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1055ui_story == nil then
				arg_109_1.var_.characterEffect1055ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1055ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1055ui_story then
				arg_109_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_112_4 = 0
			local var_112_5 = 0.575

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(123062026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 23 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 23)

				if (23 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 23)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062026", "story_v_out_123062.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062026", "story_v_out_123062.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_123062", "123062026", "story_v_out_123062.awb")

						arg_109_1:RecordAudio("123062026", var_112_11)
						arg_109_1:RecordAudio("123062026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123062", "123062026", "story_v_out_123062.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123062", "123062026", "story_v_out_123062.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play123062027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123062027
		arg_113_1.duration_ = 4.93

		local var_113_0 = {
			zh = 4.433,
			ja = 4.933
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123062028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10048ui_story"]) and arg_113_1.var_.characterEffect10048ui_story == nil then
				arg_113_1.var_.characterEffect10048ui_story = arg_113_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10048ui_story"]) then
				if arg_113_1.var_.characterEffect10048ui_story and not isNil(arg_113_1.actors_["10048ui_story"]) then
					arg_113_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10048ui_story"]) and arg_113_1.var_.characterEffect10048ui_story then
				arg_113_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_2 = arg_113_1.actors_["1055ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1055ui_story == nil then
				arg_113_1.var_.characterEffect1055ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1055ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1055ui_story then
				arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_116_4 = 0
			local var_116_5 = 0.375

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(123062027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 15 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 15)

				if (15 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 15)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062027", "story_v_out_123062.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062027", "story_v_out_123062.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_123062", "123062027", "story_v_out_123062.awb")

						arg_113_1:RecordAudio("123062027", var_116_11)
						arg_113_1:RecordAudio("123062027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_123062", "123062027", "story_v_out_123062.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_123062", "123062027", "story_v_out_123062.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123062028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123062028
		arg_117_1.duration_ = 9.27

		local var_117_0 = {
			zh = 9.266,
			ja = 7.8
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play123062029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1055ui_story"]) and arg_117_1.var_.characterEffect1055ui_story == nil then
				arg_117_1.var_.characterEffect1055ui_story = arg_117_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1055ui_story"]) then
				if arg_117_1.var_.characterEffect1055ui_story and not isNil(arg_117_1.actors_["1055ui_story"]) then
					arg_117_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1055ui_story"]) and arg_117_1.var_.characterEffect1055ui_story then
				arg_117_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_120_2 = arg_117_1.actors_["10048ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect10048ui_story == nil then
				arg_117_1.var_.characterEffect10048ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect10048ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect10048ui_story then
				arg_117_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.775

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(123062028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 31 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 31)

				if (31 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 31)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123062", "123062028", "story_v_out_123062.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_123062", "123062028", "story_v_out_123062.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_123062", "123062028", "story_v_out_123062.awb")

						arg_117_1:RecordAudio("123062028", var_120_11)
						arg_117_1:RecordAudio("123062028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123062", "123062028", "story_v_out_123062.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123062", "123062028", "story_v_out_123062.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play123062029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123062029
		arg_121_1.duration_ = 9

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
			arg_121_1.auto_ = false
		end

		function arg_121_1.playNext_(arg_123_0)
			arg_121_1.onStoryFinished_()
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if arg_121_1.bgs_.STblack == nil then
				local var_124_0 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_124_0.name = "STblack"
				var_124_0.transform.parent = arg_121_1.stage_.transform
				var_124_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_.STblack = var_124_0
			end

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= 2 + arg_124_0 then
				local var_124_1 = arg_121_1.bgs_.STblack

				arg_121_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_2 = var_124_1:GetComponent("SpriteRenderer")

				if var_124_2 and var_124_2.sprite then
					local var_124_3 = 2 * (var_124_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_1.transform.localScale = Vector3.New(var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "STblack" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_4 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_5 = 2

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_5 then
				local var_124_6 = Color.New(0, 0, 0)

				var_124_6.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - var_124_4) / var_124_5)
				arg_121_1.mask_.color = var_124_6
			end

			if arg_121_1.time_ >= var_124_4 + var_124_5 and arg_121_1.time_ < var_124_4 + var_124_5 + arg_124_0 then
				local var_124_7 = Color.New(0, 0, 0)

				var_124_7.a = 1
				arg_121_1.mask_.color = var_124_7
			end

			local var_124_8 = 2

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_9 = 2

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 then
				local var_124_10 = Color.New(0, 0, 0)

				var_124_10.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_8) / var_124_9)
				arg_121_1.mask_.color = var_124_10
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 then
				local var_124_11 = Color.New(0, 0, 0)

				arg_121_1.mask_.enabled = false
				var_124_11.a = 0
				arg_121_1.mask_.color = var_124_11
			end

			local var_124_12 = arg_121_1.actors_["10048ui_story"].transform

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 then
				arg_121_1.var_.moveOldPos10048ui_story = var_124_12.localPosition
			end

			local var_124_13 = 0.001

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_13 then
				var_124_12.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.96599999815226) / var_124_13)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_13 and arg_121_1.time_ < 1.96599999815226 + var_124_13 + arg_124_0 then
				var_124_12.localPosition = Vector3.New(0, 100, 0)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			local var_124_14 = arg_121_1.actors_["10048ui_story"]

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect10048ui_story == nil then
				arg_121_1.var_.characterEffect10048ui_story = var_124_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_15 = 0.034000001847744

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_15 and not isNil(var_124_14) then
				if arg_121_1.var_.characterEffect10048ui_story and not isNil(var_124_14) then
					arg_121_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.96599999815226) / var_124_15)
				end
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_15 and arg_121_1.time_ < 1.96599999815226 + var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect10048ui_story then
				arg_121_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_124_16 = arg_121_1.actors_["1055ui_story"].transform

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 then
				arg_121_1.var_.moveOldPos1055ui_story = var_124_16.localPosition
			end

			local var_124_17 = 0.001

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_17 then
				var_124_16.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.96599999815226) / var_124_17)
				var_124_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_16.position).x, (manager.ui.mainCamera.transform.position - var_124_16.position).y, (manager.ui.mainCamera.transform.position - var_124_16.position).z)
				var_124_16.localEulerAngles.z = 0
				var_124_16.localEulerAngles.x = 0
				var_124_16.localEulerAngles = var_124_16.localEulerAngles
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_17 and arg_121_1.time_ < 1.96599999815226 + var_124_17 + arg_124_0 then
				var_124_16.localPosition = Vector3.New(0, 100, 0)
				var_124_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_16.position).x, (manager.ui.mainCamera.transform.position - var_124_16.position).y, (manager.ui.mainCamera.transform.position - var_124_16.position).z)
				var_124_16.localEulerAngles.z = 0
				var_124_16.localEulerAngles.x = 0
				var_124_16.localEulerAngles = var_124_16.localEulerAngles
			end

			local var_124_18 = arg_121_1.actors_["1055ui_story"]

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 and not isNil(var_124_18) and arg_121_1.var_.characterEffect1055ui_story == nil then
				arg_121_1.var_.characterEffect1055ui_story = var_124_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_19 = 0.034000001847744

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_19 and not isNil(var_124_18) then
				if arg_121_1.var_.characterEffect1055ui_story and not isNil(var_124_18) then
					arg_121_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.96599999815226) / var_124_19)
				end
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_19 and arg_121_1.time_ < 1.96599999815226 + var_124_19 + arg_124_0 and not isNil(var_124_18) and arg_121_1.var_.characterEffect1055ui_story then
				arg_121_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_20 = 4
			local var_124_21 = 1.425

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_22 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_22:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_23 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(123062029).content)

				arg_121_1.text_.text = var_124_23

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_25 = 57 <= 0 and var_124_21 or var_124_21 * (utf8.len(var_124_23) / 57)

				if (57 <= 0 and var_124_21 or var_124_21 * (utf8.len(var_124_23) / 57)) > 0 and var_124_21 < var_124_25 then
					arg_121_1.talkMaxDuration = var_124_25
					var_124_20 = var_124_20 + 0.3

					if var_124_25 + var_124_20 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_25 + var_124_20
					end
				end

				arg_121_1.text_.text = var_124_23
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_26 = var_124_20 + 0.3
			local var_124_27 = math.max(var_124_21, arg_121_1.talkMaxDuration)

			if var_124_20 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_26 + var_124_27 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_26) / var_124_27

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_26 + var_124_27 and arg_121_1.time_ < var_124_26 + var_124_27 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_123062.awb"
	}
}
