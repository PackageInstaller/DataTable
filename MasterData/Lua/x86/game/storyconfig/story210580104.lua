return {
	Play1105804001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105804001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1105804002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K01i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K01i")
				var_4_0.name = "K01i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K01i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K01i

				arg_1_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K01i" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
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
			local var_4_15 = 0.625

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1105804001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)

				if (25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)) > 0 and var_4_15 < var_4_19 then
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
	Play1105804002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105804002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1105804003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.575

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1105804002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 23 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 23)

				if (23 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 23)) > 0 and var_12_0 < var_12_3 then
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
	Play1105804003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105804003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105804004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.275

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1105804003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 11 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 11)

				if (11 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 11)) > 0 and var_16_0 < var_16_3 then
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
	Play1105804004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105804004
		arg_17_1.duration_ = 2.3

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_17_0:Play1105804005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1058ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1058ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1058ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1058ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1058ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1058ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1058ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1058ui_story == nil then
				arg_17_1.var_.characterEffect1058ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1058ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1058ui_story then
				arg_17_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1105804004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 9 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 9)

				if (9 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 9)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804004", "story_v_side_new_1105804.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804004", "story_v_side_new_1105804.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1105804", "1105804004", "story_v_side_new_1105804.awb")

						arg_17_1:RecordAudio("1105804004", var_20_15)
						arg_17_1:RecordAudio("1105804004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804004", "story_v_side_new_1105804.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804004", "story_v_side_new_1105804.awb")
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
				actorName = "1058ui_story",
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
	Play1105804005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105804005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105804006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1058ui_story"]) and arg_21_1.var_.characterEffect1058ui_story == nil then
				arg_21_1.var_.characterEffect1058ui_story = arg_21_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1058ui_story"]) then
				if arg_21_1.var_.characterEffect1058ui_story and not isNil(arg_21_1.actors_["1058ui_story"]) then
					arg_21_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1058ui_story"]) and arg_21_1.var_.characterEffect1058ui_story then
				arg_21_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.45

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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1105804005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 18)

				if (18 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 18)) > 0 and var_24_2 < var_24_5 then
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
	Play1105804006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105804006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1105804007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1105804006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 19)

				if (19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 19)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1105804007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105804007
		arg_29_1.duration_ = 4.4

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 4.4
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1105804008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1058ui_story = arg_29_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1058ui_story"].transform.position).z)
				arg_29_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1058ui_story"].transform.localEulerAngles = arg_29_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_29_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1058ui_story"].transform.position).z)
				arg_29_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1058ui_story"].transform.localEulerAngles = arg_29_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1058ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1058ui_story == nil then
				arg_29_1.var_.characterEffect1058ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1058ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1058ui_story then
				arg_29_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_32_4 = 0
			local var_32_5 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(1105804007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 8 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 8)

				if (8 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 8)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804007", "story_v_side_new_1105804.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804007", "story_v_side_new_1105804.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_side_new_1105804", "1105804007", "story_v_side_new_1105804.awb")

						arg_29_1:RecordAudio("1105804007", var_32_11)
						arg_29_1:RecordAudio("1105804007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804007", "story_v_side_new_1105804.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804007", "story_v_side_new_1105804.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105804008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105804008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1105804009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1058ui_story"]) and arg_33_1.var_.characterEffect1058ui_story == nil then
				arg_33_1.var_.characterEffect1058ui_story = arg_33_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1058ui_story"]) then
				if arg_33_1.var_.characterEffect1058ui_story and not isNil(arg_33_1.actors_["1058ui_story"]) then
					arg_33_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1058ui_story"]) and arg_33_1.var_.characterEffect1058ui_story then
				arg_33_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.15

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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1105804008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 6 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 6)

				if (6 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 6)) > 0 and var_36_2 < var_36_5 then
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
	Play1105804009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105804009
		arg_37_1.duration_ = 4.63

		local var_37_0 = {
			zh = 3.766,
			ja = 4.633
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105804010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1058ui_story = arg_37_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).z)
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles = arg_37_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_37_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1058ui_story"].transform.position).z)
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1058ui_story"].transform.localEulerAngles = arg_37_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1058ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1058ui_story == nil then
				arg_37_1.var_.characterEffect1058ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1058ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1058ui_story then
				arg_37_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.325

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(1105804009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 13 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 13)

				if (13 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 13)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804009", "story_v_side_new_1105804.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804009", "story_v_side_new_1105804.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_side_new_1105804", "1105804009", "story_v_side_new_1105804.awb")

						arg_37_1:RecordAudio("1105804009", var_40_11)
						arg_37_1:RecordAudio("1105804009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804009", "story_v_side_new_1105804.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804009", "story_v_side_new_1105804.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1105804010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105804010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1105804011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1058ui_story"]) and arg_41_1.var_.characterEffect1058ui_story == nil then
				arg_41_1.var_.characterEffect1058ui_story = arg_41_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1058ui_story"]) then
				if arg_41_1.var_.characterEffect1058ui_story and not isNil(arg_41_1.actors_["1058ui_story"]) then
					arg_41_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1058ui_story"]) and arg_41_1.var_.characterEffect1058ui_story then
				arg_41_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1105804010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 3 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 3)

				if (3 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 3)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1105804011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105804011
		arg_45_1.duration_ = 7.27

		local var_45_0 = {
			zh = 7.266,
			ja = 6.6
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
				arg_45_0:Play1105804012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1058ui_story = arg_45_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).z)
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles = arg_45_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_45_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).z)
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles = arg_45_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1058ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1058ui_story == nil then
				arg_45_1.var_.characterEffect1058ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1058ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1058ui_story then
				arg_45_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(1105804011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 31 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 31)

				if (31 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 31)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804011", "story_v_side_new_1105804.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804011", "story_v_side_new_1105804.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_side_new_1105804", "1105804011", "story_v_side_new_1105804.awb")

						arg_45_1:RecordAudio("1105804011", var_48_11)
						arg_45_1:RecordAudio("1105804011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804011", "story_v_side_new_1105804.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804011", "story_v_side_new_1105804.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105804012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105804012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1105804013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1058ui_story"]) and arg_49_1.var_.characterEffect1058ui_story == nil then
				arg_49_1.var_.characterEffect1058ui_story = arg_49_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1058ui_story"]) then
				if arg_49_1.var_.characterEffect1058ui_story and not isNil(arg_49_1.actors_["1058ui_story"]) then
					arg_49_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1058ui_story"]) and arg_49_1.var_.characterEffect1058ui_story then
				arg_49_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1105804012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 10 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 10)

				if (10 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 10)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1105804013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105804013
		arg_53_1.duration_ = 9.2

		local var_53_0 = {
			zh = 9.2,
			ja = 8.7
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1105804014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1058ui_story = arg_53_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).z)
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles = arg_53_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_53_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1058ui_story"].transform.position).z)
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1058ui_story"].transform.localEulerAngles = arg_53_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1058ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1058ui_story == nil then
				arg_53_1.var_.characterEffect1058ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1058ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1058ui_story then
				arg_53_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = 0
			local var_56_5 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1105804013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 42 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 42)

				if (42 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 42)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804013", "story_v_side_new_1105804.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804013", "story_v_side_new_1105804.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1105804", "1105804013", "story_v_side_new_1105804.awb")

						arg_53_1:RecordAudio("1105804013", var_56_11)
						arg_53_1:RecordAudio("1105804013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804013", "story_v_side_new_1105804.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804013", "story_v_side_new_1105804.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105804014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1105804014
		arg_57_1.duration_ = 5.93

		local var_57_0 = {
			zh = 5.066,
			ja = 5.933
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
				arg_57_0:Play1105804015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_0 = 0
			local var_60_1 = 0.6

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(1105804014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 24 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 24)

				if (24 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 24)) > 0 and var_60_1 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804014", "story_v_side_new_1105804.awb") ~= 0 then
					local var_60_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804014", "story_v_side_new_1105804.awb") / 1000

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end

					if var_60_2.prefab_name ~= "" and arg_57_1.actors_[var_60_2.prefab_name] ~= nil then
						local var_60_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_2.prefab_name].transform, "story_v_side_new_1105804", "1105804014", "story_v_side_new_1105804.awb")

						arg_57_1:RecordAudio("1105804014", var_60_7)
						arg_57_1:RecordAudio("1105804014", var_60_7)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804014", "story_v_side_new_1105804.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804014", "story_v_side_new_1105804.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1105804015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1105804015
		arg_61_1.duration_ = 4.7

		local var_61_0 = {
			zh = 3.266,
			ja = 4.7
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1105804016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_0 = 0
			local var_64_1 = 0.45

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(1105804015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 18 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 18)

				if (18 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 18)) > 0 and var_64_1 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804015", "story_v_side_new_1105804.awb") ~= 0 then
					local var_64_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804015", "story_v_side_new_1105804.awb") / 1000

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end

					if var_64_2.prefab_name ~= "" and arg_61_1.actors_[var_64_2.prefab_name] ~= nil then
						local var_64_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_2.prefab_name].transform, "story_v_side_new_1105804", "1105804015", "story_v_side_new_1105804.awb")

						arg_61_1:RecordAudio("1105804015", var_64_7)
						arg_61_1:RecordAudio("1105804015", var_64_7)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804015", "story_v_side_new_1105804.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804015", "story_v_side_new_1105804.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1105804016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1105804016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1105804017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1058ui_story"]) and arg_65_1.var_.characterEffect1058ui_story == nil then
				arg_65_1.var_.characterEffect1058ui_story = arg_65_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1058ui_story"]) then
				if arg_65_1.var_.characterEffect1058ui_story and not isNil(arg_65_1.actors_["1058ui_story"]) then
					arg_65_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1058ui_story"]) and arg_65_1.var_.characterEffect1058ui_story then
				arg_65_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.875

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1105804016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 35 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 35)

				if (35 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 35)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1105804017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1105804017
		arg_69_1.duration_ = 11.37

		local var_69_0 = {
			zh = 11.366,
			ja = 10.2
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1105804018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1058ui_story = arg_69_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).z)
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles = arg_69_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_69_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).z)
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles = arg_69_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1058ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1058ui_story == nil then
				arg_69_1.var_.characterEffect1058ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1058ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1058ui_story then
				arg_69_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = 0
			local var_72_5 = 1.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1105804017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 57 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 57)

				if (57 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 57)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804017", "story_v_side_new_1105804.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804017", "story_v_side_new_1105804.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1105804", "1105804017", "story_v_side_new_1105804.awb")

						arg_69_1:RecordAudio("1105804017", var_72_11)
						arg_69_1:RecordAudio("1105804017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804017", "story_v_side_new_1105804.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804017", "story_v_side_new_1105804.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1105804018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1105804018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1105804019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1058ui_story"]) and arg_73_1.var_.characterEffect1058ui_story == nil then
				arg_73_1.var_.characterEffect1058ui_story = arg_73_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1058ui_story"]) then
				if arg_73_1.var_.characterEffect1058ui_story and not isNil(arg_73_1.actors_["1058ui_story"]) then
					arg_73_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1058ui_story"]) and arg_73_1.var_.characterEffect1058ui_story then
				arg_73_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.3

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

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1105804018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 12 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 12)

				if (12 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 12)) > 0 and var_76_2 < var_76_5 then
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
	Play1105804019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1105804019
		arg_77_1.duration_ = 3.13

		local var_77_0 = {
			zh = 2.166,
			ja = 3.133
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1105804020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1058ui_story = arg_77_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1058ui_story"].transform.position).z)
				arg_77_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1058ui_story"].transform.localEulerAngles = arg_77_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_77_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1058ui_story"].transform.position).z)
				arg_77_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1058ui_story"].transform.localEulerAngles = arg_77_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1058ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1058ui_story == nil then
				arg_77_1.var_.characterEffect1058ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1058ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1058ui_story then
				arg_77_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action427")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.325

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(1105804019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 13 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 13)

				if (13 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 13)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804019", "story_v_side_new_1105804.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804019", "story_v_side_new_1105804.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_new_1105804", "1105804019", "story_v_side_new_1105804.awb")

						arg_77_1:RecordAudio("1105804019", var_80_11)
						arg_77_1:RecordAudio("1105804019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804019", "story_v_side_new_1105804.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804019", "story_v_side_new_1105804.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1105804020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1105804020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1105804021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1058ui_story"]) and arg_81_1.var_.characterEffect1058ui_story == nil then
				arg_81_1.var_.characterEffect1058ui_story = arg_81_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1058ui_story"]) then
				if arg_81_1.var_.characterEffect1058ui_story and not isNil(arg_81_1.actors_["1058ui_story"]) then
					arg_81_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1058ui_story"]) and arg_81_1.var_.characterEffect1058ui_story then
				arg_81_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.75

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1105804020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 30 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 30)

				if (30 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 30)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1105804021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1105804021
		arg_85_1.duration_ = 6.63

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1105804022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1058ui_story = arg_85_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1058ui_story"].transform.position).z)
				arg_85_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1058ui_story"].transform.localEulerAngles = arg_85_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_85_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1058ui_story"].transform.position).z)
				arg_85_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1058ui_story"].transform.localEulerAngles = arg_85_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1058ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1058ui_story == nil then
				arg_85_1.var_.characterEffect1058ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1058ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1058ui_story then
				arg_85_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action7_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.7

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(1105804021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 28 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 28)

				if (28 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 28)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804021", "story_v_side_new_1105804.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804021", "story_v_side_new_1105804.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_new_1105804", "1105804021", "story_v_side_new_1105804.awb")

						arg_85_1:RecordAudio("1105804021", var_88_11)
						arg_85_1:RecordAudio("1105804021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804021", "story_v_side_new_1105804.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804021", "story_v_side_new_1105804.awb")
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
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play1105804022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1105804022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1105804023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1058ui_story"]) and arg_89_1.var_.characterEffect1058ui_story == nil then
				arg_89_1.var_.characterEffect1058ui_story = arg_89_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1058ui_story"]) then
				if arg_89_1.var_.characterEffect1058ui_story and not isNil(arg_89_1.actors_["1058ui_story"]) then
					arg_89_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1058ui_story"]) and arg_89_1.var_.characterEffect1058ui_story then
				arg_89_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.375

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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1105804022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 15 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 15)

				if (15 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 15)) > 0 and var_92_2 < var_92_5 then
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
	Play1105804023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1105804023
		arg_93_1.duration_ = 9

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1105804024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.bgs_.C06b == nil then
				local var_96_0 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C06b")
				var_96_0.name = "C06b"
				var_96_0.transform.parent = arg_93_1.stage_.transform
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_.C06b = var_96_0
			end

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				local var_96_1 = arg_93_1.bgs_.C06b

				arg_93_1.bgs_.C06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_2 = var_96_1:GetComponent("SpriteRenderer")

				if var_96_2 and var_96_2.sprite then
					local var_96_3 = 2 * (var_96_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_1.transform.localScale = Vector3.New(var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "C06b" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_4 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_5 = 2

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_5 then
				local var_96_6 = Color.New(0, 0, 0)

				var_96_6.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_4) / var_96_5)
				arg_93_1.mask_.color = var_96_6
			end

			if arg_93_1.time_ >= var_96_4 + var_96_5 and arg_93_1.time_ < var_96_4 + var_96_5 + arg_96_0 then
				local var_96_7 = Color.New(0, 0, 0)

				var_96_7.a = 1
				arg_93_1.mask_.color = var_96_7
			end

			local var_96_8 = 2

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 then
				local var_96_10 = Color.New(0, 0, 0)

				var_96_10.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_8) / var_96_9)
				arg_93_1.mask_.color = var_96_10
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 then
				local var_96_11 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_11.a = 0
				arg_93_1.mask_.color = var_96_11
			end

			local var_96_12 = arg_93_1.actors_["1058ui_story"].transform

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				arg_93_1.var_.moveOldPos1058ui_story = var_96_12.localPosition
			end

			local var_96_13 = 0.001

			if 2 <= arg_93_1.time_ and arg_93_1.time_ < 2 + var_96_13 then
				var_96_12.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 2) / var_96_13)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			if arg_93_1.time_ >= 2 + var_96_13 and arg_93_1.time_ < 2 + var_96_13 + arg_96_0 then
				var_96_12.localPosition = Vector3.New(0, 100, 0)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_14 = 4
			local var_96_15 = 0.525

			if 4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_16 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_16:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

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

				local var_96_17 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1105804023).content)

				arg_93_1.text_.text = var_96_17

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 21 <= 0 and var_96_15 or var_96_15 * (utf8.len(var_96_17) / 21)

				if (21 <= 0 and var_96_15 or var_96_15 * (utf8.len(var_96_17) / 21)) > 0 and var_96_15 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19
					var_96_14 = var_96_14 + 0.3

					if var_96_19 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_14
					end
				end

				arg_93_1.text_.text = var_96_17
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = var_96_14 + 0.3
			local var_96_21 = math.max(var_96_15, arg_93_1.talkMaxDuration)

			if var_96_14 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_20 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_20) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_20 + var_96_21 and arg_93_1.time_ < var_96_20 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1105804024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1105804024
		arg_99_1.duration_ = 10.47

		local var_99_0 = {
			zh = 10.466,
			ja = 9.4
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1105804025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1058ui_story = arg_99_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1058ui_story"].transform.position).z)
				arg_99_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1058ui_story"].transform.localEulerAngles = arg_99_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_99_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1058ui_story"].transform.position).z)
				arg_99_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1058ui_story"].transform.localEulerAngles = arg_99_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1058ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1058ui_story == nil then
				arg_99_1.var_.characterEffect1058ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1058ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1058ui_story then
				arg_99_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_4 = 0
			local var_102_5 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(1105804024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 29 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 29)

				if (29 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 29)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804024", "story_v_side_new_1105804.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804024", "story_v_side_new_1105804.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_side_new_1105804", "1105804024", "story_v_side_new_1105804.awb")

						arg_99_1:RecordAudio("1105804024", var_102_11)
						arg_99_1:RecordAudio("1105804024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804024", "story_v_side_new_1105804.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804024", "story_v_side_new_1105804.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play1105804025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1105804025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1105804026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1058ui_story"]) and arg_103_1.var_.characterEffect1058ui_story == nil then
				arg_103_1.var_.characterEffect1058ui_story = arg_103_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1058ui_story"]) then
				if arg_103_1.var_.characterEffect1058ui_story and not isNil(arg_103_1.actors_["1058ui_story"]) then
					arg_103_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1058ui_story"]) and arg_103_1.var_.characterEffect1058ui_story then
				arg_103_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.5

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(1105804025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 20 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 20)

				if (20 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 20)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1105804026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1105804026
		arg_107_1.duration_ = 2.63

		local var_107_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1105804027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1058ui_story = arg_107_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).z)
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles = arg_107_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_107_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).z)
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles = arg_107_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1058ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1058ui_story == nil then
				arg_107_1.var_.characterEffect1058ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1058ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1058ui_story then
				arg_107_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_4 = 0
			local var_110_5 = 0.125

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(1105804026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 5 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 5)

				if (5 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 5)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804026", "story_v_side_new_1105804.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804026", "story_v_side_new_1105804.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_side_new_1105804", "1105804026", "story_v_side_new_1105804.awb")

						arg_107_1:RecordAudio("1105804026", var_110_11)
						arg_107_1:RecordAudio("1105804026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804026", "story_v_side_new_1105804.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804026", "story_v_side_new_1105804.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1105804027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1105804027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1105804028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1058ui_story = arg_111_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1058ui_story"].transform.position).z)
				arg_111_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1058ui_story"].transform.localEulerAngles = arg_111_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1058ui_story"].transform.position).z)
				arg_111_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1058ui_story"].transform.localEulerAngles = arg_111_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_114_1 = 0
			local var_114_2 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1105804027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 20 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 20)

				if (20 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 20)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play1105804028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1105804028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1105804029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.625

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1105804028).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 25 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 25)

				if (25 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 25)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1105804029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1105804029
		arg_119_1.duration_ = 3.1

		local var_119_0 = {
			zh = 1.5,
			ja = 3.1
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1105804030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1058ui_story = arg_119_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1058ui_story"].transform.position).z)
				arg_119_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1058ui_story"].transform.localEulerAngles = arg_119_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_119_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1058ui_story"].transform.position).z)
				arg_119_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1058ui_story"].transform.localEulerAngles = arg_119_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1058ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1058ui_story == nil then
				arg_119_1.var_.characterEffect1058ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1058ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1058ui_story then
				arg_119_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(1105804029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 8 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 8)

				if (8 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 8)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804029", "story_v_side_new_1105804.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804029", "story_v_side_new_1105804.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_side_new_1105804", "1105804029", "story_v_side_new_1105804.awb")

						arg_119_1:RecordAudio("1105804029", var_122_11)
						arg_119_1:RecordAudio("1105804029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804029", "story_v_side_new_1105804.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804029", "story_v_side_new_1105804.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play1105804030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1105804030
		arg_123_1.duration_ = 9.13

		local var_123_0 = {
			zh = 9.133,
			ja = 8.266
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1105804031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action7_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_0 = 0
			local var_126_1 = 0.825

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(1105804030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 33 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 33)

				if (33 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 33)) > 0 and var_126_1 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804030", "story_v_side_new_1105804.awb") ~= 0 then
					local var_126_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804030", "story_v_side_new_1105804.awb") / 1000

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end

					if var_126_2.prefab_name ~= "" and arg_123_1.actors_[var_126_2.prefab_name] ~= nil then
						local var_126_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_2.prefab_name].transform, "story_v_side_new_1105804", "1105804030", "story_v_side_new_1105804.awb")

						arg_123_1:RecordAudio("1105804030", var_126_7)
						arg_123_1:RecordAudio("1105804030", var_126_7)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804030", "story_v_side_new_1105804.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804030", "story_v_side_new_1105804.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1105804031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1105804031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1105804032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1058ui_story = arg_127_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).z)
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles = arg_127_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).z)
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles = arg_127_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_130_1 = 0
			local var_130_2 = 0.85

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1105804031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 34 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 34)

				if (34 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 34)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play1105804032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1105804032
		arg_131_1.duration_ = 11.9

		local var_131_0 = {
			zh = 10.966,
			ja = 11.9
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1105804033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1058ui_story = arg_131_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).z)
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles = arg_131_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_131_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).z)
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles = arg_131_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1058ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1058ui_story == nil then
				arg_131_1.var_.characterEffect1058ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1058ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1058ui_story then
				arg_131_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = 0
			local var_134_5 = 1.3

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(1105804032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 52 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 52)

				if (52 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 52)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804032", "story_v_side_new_1105804.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804032", "story_v_side_new_1105804.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_new_1105804", "1105804032", "story_v_side_new_1105804.awb")

						arg_131_1:RecordAudio("1105804032", var_134_11)
						arg_131_1:RecordAudio("1105804032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804032", "story_v_side_new_1105804.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804032", "story_v_side_new_1105804.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1105804033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1105804033
		arg_135_1.duration_ = 4.53

		local var_135_0 = {
			zh = 3.633,
			ja = 4.533
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1105804034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_0 = 0
			local var_138_1 = 0.4

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(1105804033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 16 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 16)

				if (16 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 16)) > 0 and var_138_1 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804033", "story_v_side_new_1105804.awb") ~= 0 then
					local var_138_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804033", "story_v_side_new_1105804.awb") / 1000

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end

					if var_138_2.prefab_name ~= "" and arg_135_1.actors_[var_138_2.prefab_name] ~= nil then
						local var_138_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_2.prefab_name].transform, "story_v_side_new_1105804", "1105804033", "story_v_side_new_1105804.awb")

						arg_135_1:RecordAudio("1105804033", var_138_7)
						arg_135_1:RecordAudio("1105804033", var_138_7)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804033", "story_v_side_new_1105804.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804033", "story_v_side_new_1105804.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1105804034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1105804034
		arg_139_1.duration_ = 5.87

		local var_139_0 = {
			zh = 4.2,
			ja = 5.866
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1105804035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_142_0 = 0
			local var_142_1 = 0.55

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(1105804034)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 22 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 22)

				if (22 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 22)) > 0 and var_142_1 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804034", "story_v_side_new_1105804.awb") ~= 0 then
					local var_142_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804034", "story_v_side_new_1105804.awb") / 1000

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end

					if var_142_2.prefab_name ~= "" and arg_139_1.actors_[var_142_2.prefab_name] ~= nil then
						local var_142_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_2.prefab_name].transform, "story_v_side_new_1105804", "1105804034", "story_v_side_new_1105804.awb")

						arg_139_1:RecordAudio("1105804034", var_142_7)
						arg_139_1:RecordAudio("1105804034", var_142_7)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804034", "story_v_side_new_1105804.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804034", "story_v_side_new_1105804.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1105804035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1105804035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1105804036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1058ui_story"]) and arg_143_1.var_.characterEffect1058ui_story == nil then
				arg_143_1.var_.characterEffect1058ui_story = arg_143_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1058ui_story"]) then
				if arg_143_1.var_.characterEffect1058ui_story and not isNil(arg_143_1.actors_["1058ui_story"]) then
					arg_143_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1058ui_story"]) and arg_143_1.var_.characterEffect1058ui_story then
				arg_143_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.775

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1105804035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 31 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 31)

				if (31 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 31)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1105804036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1105804036
		arg_147_1.duration_ = 3.23

		local var_147_0 = {
			zh = 3.233,
			ja = 2.833
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1105804037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1058ui_story = arg_147_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1058ui_story"].transform.position).z)
				arg_147_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1058ui_story"].transform.localEulerAngles = arg_147_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_147_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1058ui_story"].transform.position).z)
				arg_147_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1058ui_story"].transform.localEulerAngles = arg_147_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1058ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1058ui_story == nil then
				arg_147_1.var_.characterEffect1058ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1058ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1058ui_story then
				arg_147_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action423")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_4 = 0
			local var_150_5 = 0.4

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(1105804036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 16 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 16)

				if (16 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 16)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804036", "story_v_side_new_1105804.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804036", "story_v_side_new_1105804.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_side_new_1105804", "1105804036", "story_v_side_new_1105804.awb")

						arg_147_1:RecordAudio("1105804036", var_150_11)
						arg_147_1:RecordAudio("1105804036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804036", "story_v_side_new_1105804.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804036", "story_v_side_new_1105804.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1105804037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1105804037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1105804038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1058ui_story"]) and arg_151_1.var_.characterEffect1058ui_story == nil then
				arg_151_1.var_.characterEffect1058ui_story = arg_151_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1058ui_story"]) then
				if arg_151_1.var_.characterEffect1058ui_story and not isNil(arg_151_1.actors_["1058ui_story"]) then
					arg_151_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1058ui_story"]) and arg_151_1.var_.characterEffect1058ui_story then
				arg_151_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.175

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1105804037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 7 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 7)

				if (7 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 7)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1105804038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1105804038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1105804039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_fireworks1", "")
			end

			local var_158_1 = 0
			local var_158_2 = 0.9

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1105804038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 36 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 36)

				if (36 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 36)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1105804039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1105804039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1105804040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.025

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1105804039).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 41 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 41)

				if (41 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 41)) > 0 and var_162_0 < var_162_3 then
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
	Play1105804040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1105804040
		arg_163_1.duration_ = 9.13

		local var_163_0 = {
			zh = 3.5,
			ja = 9.133
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1105804041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1058ui_story = arg_163_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).z)
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles = arg_163_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_163_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).z)
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles = arg_163_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1058ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1058ui_story == nil then
				arg_163_1.var_.characterEffect1058ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1058ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1058ui_story then
				arg_163_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(1105804040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 12 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 12)

				if (12 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 12)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804040", "story_v_side_new_1105804.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804040", "story_v_side_new_1105804.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_side_new_1105804", "1105804040", "story_v_side_new_1105804.awb")

						arg_163_1:RecordAudio("1105804040", var_166_11)
						arg_163_1:RecordAudio("1105804040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804040", "story_v_side_new_1105804.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804040", "story_v_side_new_1105804.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play1105804041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1105804041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1105804042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1058ui_story"]) and arg_167_1.var_.characterEffect1058ui_story == nil then
				arg_167_1.var_.characterEffect1058ui_story = arg_167_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1058ui_story"]) then
				if arg_167_1.var_.characterEffect1058ui_story and not isNil(arg_167_1.actors_["1058ui_story"]) then
					arg_167_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1058ui_story"]) and arg_167_1.var_.characterEffect1058ui_story then
				arg_167_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_170_1 = arg_167_1.actors_["1058ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1058ui_story = var_170_1.localPosition
			end

			local var_170_2 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 then
				var_170_1.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_2)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 then
				var_170_1.localPosition = Vector3.New(0, 100, 0)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			local var_170_3 = 0
			local var_170_4 = 0.725

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_3 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_5 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1105804041).content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 29 <= 0 and var_170_4 or var_170_4 * (utf8.len(var_170_5) / 29)

				if (29 <= 0 and var_170_4 or var_170_4 * (utf8.len(var_170_5) / 29)) > 0 and var_170_4 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_3 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_3
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_4, arg_167_1.talkMaxDuration)

			if var_170_3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_3 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_3) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_3 + var_170_8 and arg_167_1.time_ < var_170_3 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play1105804042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1105804042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1105804043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.9

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1105804042).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 36 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 36)

				if (36 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 36)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1105804043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1105804043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1105804044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
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

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1105804043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 20 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 20)

				if (20 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 20)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1105804044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1105804044
		arg_179_1.duration_ = 9.03

		local var_179_0 = {
			zh = 5.433,
			ja = 9.033
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1105804045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1058ui_story = arg_179_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).z)
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles = arg_179_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_179_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).z)
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles = arg_179_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1058ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1058ui_story == nil then
				arg_179_1.var_.characterEffect1058ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1058ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1058ui_story then
				arg_179_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.425

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(1105804044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 17 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 17)

				if (17 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 17)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804044", "story_v_side_new_1105804.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804044", "story_v_side_new_1105804.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_side_new_1105804", "1105804044", "story_v_side_new_1105804.awb")

						arg_179_1:RecordAudio("1105804044", var_182_11)
						arg_179_1:RecordAudio("1105804044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804044", "story_v_side_new_1105804.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804044", "story_v_side_new_1105804.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play1105804045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1105804045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1105804046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1058ui_story"]) and arg_183_1.var_.characterEffect1058ui_story == nil then
				arg_183_1.var_.characterEffect1058ui_story = arg_183_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1058ui_story"]) then
				if arg_183_1.var_.characterEffect1058ui_story and not isNil(arg_183_1.actors_["1058ui_story"]) then
					arg_183_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1058ui_story"]) and arg_183_1.var_.characterEffect1058ui_story then
				arg_183_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.525

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

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1105804045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 21 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 21)

				if (21 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 21)) > 0 and var_186_2 < var_186_5 then
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
	Play1105804046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1105804046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1105804047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.725

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1105804046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 29 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 29)

				if (29 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 29)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1105804047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1105804047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1105804048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.625

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1105804047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 25 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 25)

				if (25 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 25)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1105804048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1105804048
		arg_195_1.duration_ = 2

		local var_195_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_195_0:Play1105804049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1058ui_story = arg_195_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1058ui_story"].transform.position).z)
				arg_195_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1058ui_story"].transform.localEulerAngles = arg_195_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_195_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1058ui_story"].transform.position).z)
				arg_195_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1058ui_story"].transform.localEulerAngles = arg_195_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1058ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1058ui_story == nil then
				arg_195_1.var_.characterEffect1058ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1058ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1058ui_story then
				arg_195_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_198_4 = 0
			local var_198_5 = 0.175

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(1105804048)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 7 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 7)

				if (7 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 7)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804048", "story_v_side_new_1105804.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804048", "story_v_side_new_1105804.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_side_new_1105804", "1105804048", "story_v_side_new_1105804.awb")

						arg_195_1:RecordAudio("1105804048", var_198_11)
						arg_195_1:RecordAudio("1105804048", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804048", "story_v_side_new_1105804.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804048", "story_v_side_new_1105804.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play1105804049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1105804049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1105804050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1058ui_story"]) and arg_199_1.var_.characterEffect1058ui_story == nil then
				arg_199_1.var_.characterEffect1058ui_story = arg_199_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1058ui_story"]) then
				if arg_199_1.var_.characterEffect1058ui_story and not isNil(arg_199_1.actors_["1058ui_story"]) then
					arg_199_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1058ui_story"]) and arg_199_1.var_.characterEffect1058ui_story then
				arg_199_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1105804049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 27 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 27)

				if (27 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 27)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1105804050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1105804050
		arg_203_1.duration_ = 4.07

		local var_203_0 = {
			zh = 3,
			ja = 4.066
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1105804051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1058ui_story = arg_203_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1058ui_story"].transform.position).z)
				arg_203_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1058ui_story"].transform.localEulerAngles = arg_203_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_203_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1058ui_story"].transform.position).z)
				arg_203_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1058ui_story"].transform.localEulerAngles = arg_203_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1058ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1058ui_story == nil then
				arg_203_1.var_.characterEffect1058ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1058ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1058ui_story then
				arg_203_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.225

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(1105804050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 9 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 9)

				if (9 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 9)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804050", "story_v_side_new_1105804.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804050", "story_v_side_new_1105804.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_side_new_1105804", "1105804050", "story_v_side_new_1105804.awb")

						arg_203_1:RecordAudio("1105804050", var_206_11)
						arg_203_1:RecordAudio("1105804050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804050", "story_v_side_new_1105804.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804050", "story_v_side_new_1105804.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play1105804051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1105804051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1105804052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1058ui_story"]) and arg_207_1.var_.characterEffect1058ui_story == nil then
				arg_207_1.var_.characterEffect1058ui_story = arg_207_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1058ui_story"]) then
				if arg_207_1.var_.characterEffect1058ui_story and not isNil(arg_207_1.actors_["1058ui_story"]) then
					arg_207_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1058ui_story"]) and arg_207_1.var_.characterEffect1058ui_story then
				arg_207_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
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

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1105804051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 40 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 40)

				if (40 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 40)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1105804052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1105804052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1105804053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1058ui_story = arg_211_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_214_1 = 0
			local var_214_2 = 0.825

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1105804052).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 33 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 33)

				if (33 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 33)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1105804053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1105804053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1105804054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.55

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1105804053).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 22 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 22)

				if (22 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 22)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1105804054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1105804054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1105804055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_fireworks2", "")
			end

			local var_222_1 = 0
			local var_222_2 = 1.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1105804054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 53 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 53)

				if (53 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 53)) > 0 and var_222_2 < var_222_5 then
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
	Play1105804055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1105804055
		arg_223_1.duration_ = 9

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1105804056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.R5801a == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R5801a")
				var_226_0.name = "R5801a"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.R5801a = var_226_0
			end

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.R5801a

				arg_223_1.bgs_.R5801a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "R5801a" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_5 = 2

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_5 then
				local var_226_6 = Color.New(0, 0, 0)

				var_226_6.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_4) / var_226_5)
				arg_223_1.mask_.color = var_226_6
			end

			if arg_223_1.time_ >= var_226_4 + var_226_5 and arg_223_1.time_ < var_226_4 + var_226_5 + arg_226_0 then
				local var_226_7 = Color.New(0, 0, 0)

				var_226_7.a = 1
				arg_223_1.mask_.color = var_226_7
			end

			local var_226_8 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_9 = 2

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 then
				local var_226_10 = Color.New(0, 0, 0)

				var_226_10.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_8) / var_226_9)
				arg_223_1.mask_.color = var_226_10
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 then
				local var_226_11 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_11.a = 0
				arg_223_1.mask_.color = var_226_11
			end

			local var_226_12 = arg_223_1.bgs_.R5801a.transform

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				arg_223_1.var_.moveOldPosR5801a = var_226_12.localPosition
			end

			local var_226_13 = 0.001

			if 2 <= arg_223_1.time_ and arg_223_1.time_ < 2 + var_226_13 then
				var_226_12.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosR5801a, Vector3.New(3.3, -0.72, 2.02), (arg_223_1.time_ - 2) / var_226_13)
			end

			if arg_223_1.time_ >= 2 + var_226_13 and arg_223_1.time_ < 2 + var_226_13 + arg_226_0 then
				var_226_12.localPosition = Vector3.New(3.3, -0.72, 2.02)
			end

			local var_226_14 = arg_223_1.bgs_.R5801a.transform

			if 2.034 < arg_223_1.time_ and arg_223_1.time_ <= 2.034 + arg_226_0 then
				arg_223_1.var_.moveOldPosR5801a = var_226_14.localPosition
			end

			local var_226_15 = 3.49933333333333

			if 2.034 <= arg_223_1.time_ and arg_223_1.time_ < 2.034 + var_226_15 then
				var_226_14.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosR5801a, Vector3.New(3.3, -0.72, 1.38), (arg_223_1.time_ - 2.034) / var_226_15)
			end

			if arg_223_1.time_ >= 2.034 + var_226_15 and arg_223_1.time_ < 2.034 + var_226_15 + arg_226_0 then
				var_226_14.localPosition = Vector3.New(3.3, -0.72, 1.38)
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_16 = 4
			local var_226_17 = 0.175

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_18 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_18:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

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

				local var_226_19 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1105804055).content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_21 = 7 <= 0 and var_226_17 or var_226_17 * (utf8.len(var_226_19) / 7)

				if (7 <= 0 and var_226_17 or var_226_17 * (utf8.len(var_226_19) / 7)) > 0 and var_226_17 < var_226_21 then
					arg_223_1.talkMaxDuration = var_226_21
					var_226_16 = var_226_16 + 0.3

					if var_226_21 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_21 + var_226_16
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_22 = var_226_16 + 0.3
			local var_226_23 = math.max(var_226_17, arg_223_1.talkMaxDuration)

			if var_226_16 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_22 + var_226_23 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_22) / var_226_23

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_22 + var_226_23 and arg_223_1.time_ < var_226_22 + var_226_23 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R5801a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R5801a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.49933333333333,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play1105804056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1105804056
		arg_229_1.duration_ = 4.57

		local var_229_0 = {
			zh = 4.566,
			ja = 3.833
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1105804057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.3

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(1105804056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 12 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 12)

				if (12 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 12)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804056", "story_v_side_new_1105804.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804056", "story_v_side_new_1105804.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_side_new_1105804", "1105804056", "story_v_side_new_1105804.awb")

						arg_229_1:RecordAudio("1105804056", var_232_6)
						arg_229_1:RecordAudio("1105804056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804056", "story_v_side_new_1105804.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804056", "story_v_side_new_1105804.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1105804057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1105804057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1105804058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.425

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1105804057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 17 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 17)

				if (17 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 17)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1105804058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1105804058
		arg_237_1.duration_ = 7

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1105804059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				local var_240_0 = arg_237_1.bgs_.R5801a

				arg_237_1.bgs_.R5801a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_240_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_1 = var_240_0:GetComponent("SpriteRenderer")

				if var_240_1 and var_240_1.sprite then
					local var_240_2 = 2 * (var_240_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_240_0.transform.localScale = Vector3.New(var_240_2 / var_240_1.sprite.bounds.size.y < var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x and var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x or var_240_2 / var_240_1.sprite.bounds.size.y, var_240_2 / var_240_1.sprite.bounds.size.y < var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x and var_240_2 * manager.ui.mainCameraCom_.aspect / var_240_1.sprite.bounds.size.x or var_240_2 / var_240_1.sprite.bounds.size.y, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "R5801a" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_3 = arg_237_1.bgs_.R5801a.transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPosR5801a = var_240_3.localPosition
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_3.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPosR5801a, Vector3.New(-1.71, -0.09, 6.14), (arg_237_1.time_ - 0) / var_240_4)
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = Vector3.New(-1.71, -0.09, 6.14)
			end

			local var_240_5 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_6 = 2

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_6 then
				local var_240_7 = Color.New(0, 0, 0)

				var_240_7.a = Mathf.Lerp(1, 0, (arg_237_1.time_ - var_240_5) / var_240_6)
				arg_237_1.mask_.color = var_240_7
			end

			if arg_237_1.time_ >= var_240_5 + var_240_6 and arg_237_1.time_ < var_240_5 + var_240_6 + arg_240_0 then
				local var_240_8 = Color.New(0, 0, 0)

				arg_237_1.mask_.enabled = false
				var_240_8.a = 0
				arg_237_1.mask_.color = var_240_8
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_9 = 2
			local var_240_10 = 0.7

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_11 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_11:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_12 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1105804058).content)

				arg_237_1.text_.text = var_240_12

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_14 = 28 <= 0 and var_240_10 or var_240_10 * (utf8.len(var_240_12) / 28)

				if (28 <= 0 and var_240_10 or var_240_10 * (utf8.len(var_240_12) / 28)) > 0 and var_240_10 < var_240_14 then
					arg_237_1.talkMaxDuration = var_240_14
					var_240_9 = var_240_9 + 0.3

					if var_240_14 + var_240_9 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_9
					end
				end

				arg_237_1.text_.text = var_240_12
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_15 = var_240_9 + 0.3
			local var_240_16 = math.max(var_240_10, arg_237_1.talkMaxDuration)

			if var_240_9 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_16 and arg_237_1.time_ < var_240_15 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R5801a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1105804059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1105804059
		arg_243_1.duration_ = 4.5

		local var_243_0 = {
			zh = 4.5,
			ja = 4.2
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1105804060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.55

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(1105804059)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 22 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 22)

				if (22 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 22)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804059", "story_v_side_new_1105804.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804059", "story_v_side_new_1105804.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_side_new_1105804", "1105804059", "story_v_side_new_1105804.awb")

						arg_243_1:RecordAudio("1105804059", var_246_6)
						arg_243_1:RecordAudio("1105804059", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804059", "story_v_side_new_1105804.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804059", "story_v_side_new_1105804.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1105804060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1105804060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1105804061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.425

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1105804060).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 17 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 17)

				if (17 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 17)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1105804061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1105804061
		arg_251_1.duration_ = 4.3

		local var_251_0 = {
			zh = 4.166,
			ja = 4.3
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1105804062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_0 = arg_251_1.bgs_.R5801a

				arg_251_1.bgs_.R5801a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_1 = var_254_0:GetComponent("SpriteRenderer")

				if var_254_1 and var_254_1.sprite then
					local var_254_2 = 2 * (var_254_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_0.transform.localScale = Vector3.New(var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "R5801a" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_3 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = false

				arg_251_1:SetGaussion(false)
			end

			local var_254_4 = 2

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_4 then
				local var_254_5 = Color.New(1, 1, 1)

				var_254_5.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_3) / var_254_4)
				arg_251_1.mask_.color = var_254_5
			end

			if arg_251_1.time_ >= var_254_3 + var_254_4 and arg_251_1.time_ < var_254_3 + var_254_4 + arg_254_0 then
				local var_254_6 = Color.New(1, 1, 1)

				arg_251_1.mask_.enabled = false
				var_254_6.a = 0
				arg_251_1.mask_.color = var_254_6
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_7 = 2
			local var_254_8 = 0.175

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_9 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_9:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(1105804061)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 7 <= 0 and var_254_8 or var_254_8 * (utf8.len(var_254_11) / 7)

				if (7 <= 0 and var_254_8 or var_254_8 * (utf8.len(var_254_11) / 7)) > 0 and var_254_8 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13
					var_254_7 = var_254_7 + 0.3

					if var_254_13 + var_254_7 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_7
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804061", "story_v_side_new_1105804.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804061", "story_v_side_new_1105804.awb") / 1000

					if var_254_14 + var_254_7 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_7
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_side_new_1105804", "1105804061", "story_v_side_new_1105804.awb")

						arg_251_1:RecordAudio("1105804061", var_254_15)
						arg_251_1:RecordAudio("1105804061", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804061", "story_v_side_new_1105804.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804061", "story_v_side_new_1105804.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = var_254_7 + 0.3
			local var_254_17 = math.max(var_254_8, arg_251_1.talkMaxDuration)

			if var_254_7 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_16) / var_254_17

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1105804062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1105804062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1105804063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.8

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1105804062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 32 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 32)

				if (32 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 32)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1105804063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1105804063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1105804064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.6

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

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1105804063).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 24 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 24)

				if (24 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 24)) > 0 and var_264_0 < var_264_3 then
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
	Play1105804064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1105804064
		arg_265_1.duration_ = 4.4

		local var_265_0 = {
			zh = 3.4,
			ja = 4.4
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1105804065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.375

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(1105804064)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 15 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 15)

				if (15 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 15)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804064", "story_v_side_new_1105804.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804064", "story_v_side_new_1105804.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_side_new_1105804", "1105804064", "story_v_side_new_1105804.awb")

						arg_265_1:RecordAudio("1105804064", var_268_6)
						arg_265_1:RecordAudio("1105804064", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804064", "story_v_side_new_1105804.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804064", "story_v_side_new_1105804.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1105804065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1105804065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1105804066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.3

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
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

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1105804065).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 12 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 12)

				if (12 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 12)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1105804066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1105804066
		arg_273_1.duration_ = 2.6

		local var_273_0 = {
			zh = 1.233,
			ja = 2.6
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1105804067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.125

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(1105804066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 5 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 5)

				if (5 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 5)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804066", "story_v_side_new_1105804.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804066", "story_v_side_new_1105804.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_side_new_1105804", "1105804066", "story_v_side_new_1105804.awb")

						arg_273_1:RecordAudio("1105804066", var_276_6)
						arg_273_1:RecordAudio("1105804066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804066", "story_v_side_new_1105804.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804066", "story_v_side_new_1105804.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1105804067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1105804067
		arg_277_1.duration_ = 9

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1105804068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if arg_277_1.bgs_.R5801 == nil then
				local var_280_0 = Object.Instantiate(arg_277_1.paintGo_)

				var_280_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R5801")
				var_280_0.name = "R5801"
				var_280_0.transform.parent = arg_277_1.stage_.transform
				var_280_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.bgs_.R5801 = var_280_0
			end

			if 2 < arg_277_1.time_ and arg_277_1.time_ <= 2 + arg_280_0 then
				local var_280_1 = arg_277_1.bgs_.R5801

				arg_277_1.bgs_.R5801.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_280_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_2 = var_280_1:GetComponent("SpriteRenderer")

				if var_280_2 and var_280_2.sprite then
					local var_280_3 = 2 * (var_280_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_280_1.transform.localScale = Vector3.New(var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "R5801" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_4 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_5 = 2

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_5 then
				local var_280_6 = Color.New(0, 0, 0)

				var_280_6.a = Mathf.Lerp(0, 1, (arg_277_1.time_ - var_280_4) / var_280_5)
				arg_277_1.mask_.color = var_280_6
			end

			if arg_277_1.time_ >= var_280_4 + var_280_5 and arg_277_1.time_ < var_280_4 + var_280_5 + arg_280_0 then
				local var_280_7 = Color.New(0, 0, 0)

				var_280_7.a = 1
				arg_277_1.mask_.color = var_280_7
			end

			local var_280_8 = 2

			if 2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_9 = 2

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 then
				local var_280_10 = Color.New(0, 0, 0)

				var_280_10.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_8) / var_280_9)
				arg_277_1.mask_.color = var_280_10
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 then
				local var_280_11 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_11.a = 0
				arg_277_1.mask_.color = var_280_11
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_12 = 4
			local var_280_13 = 0.725

			if 4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_14 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_14:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_15 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1105804067).content)

				arg_277_1.text_.text = var_280_15

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_17 = 29 <= 0 and var_280_13 or var_280_13 * (utf8.len(var_280_15) / 29)

				if (29 <= 0 and var_280_13 or var_280_13 * (utf8.len(var_280_15) / 29)) > 0 and var_280_13 < var_280_17 then
					arg_277_1.talkMaxDuration = var_280_17
					var_280_12 = var_280_12 + 0.3

					if var_280_17 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_17 + var_280_12
					end
				end

				arg_277_1.text_.text = var_280_15
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = var_280_12 + 0.3
			local var_280_19 = math.max(var_280_13, arg_277_1.talkMaxDuration)

			if var_280_12 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_18 + var_280_19 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_18) / var_280_19

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_18 + var_280_19 and arg_277_1.time_ < var_280_18 + var_280_19 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1105804068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1105804068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1105804069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.1

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1105804068).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 44 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 44)

				if (44 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 44)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1105804069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1105804069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1105804070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.725

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1105804069).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 29 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 29)

				if (29 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 29)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1105804070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1105804070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1105804071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.525

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

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1105804070).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 21 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 21)

				if (21 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 21)) > 0 and var_294_0 < var_294_3 then
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
	Play1105804071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1105804071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1105804072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_298_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_295_1.bgmTxt_.text ~= var_298_2 and arg_295_1.bgmTxt_.text ~= "" then
						if arg_295_1.bgmTxt2_.text ~= "" then
							arg_295_1.bgmTxt_.text = arg_295_1.bgmTxt2_.text
						end

						arg_295_1.bgmTxt2_.text = var_298_2

						arg_295_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_295_1.bgmTxt_.text = var_298_2
						arg_295_1.bgmTxt2_.text = var_298_2
					end

					if arg_295_1.bgmTimer then
						arg_295_1.bgmTimer:Stop()

						arg_295_1.bgmTimer = nil
					end

					if arg_295_1.settingData.show_music_name == 1 then
						arg_295_1.musicController:SetSelectedState("show")
						arg_295_1.musicAnimator_:Play("open", 0, 0)

						if arg_295_1.settingData.music_time ~= 0 then
							arg_295_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_295_1.settingData.music_time), function()
								if arg_295_1 == nil or isNil(arg_295_1.bgmTxt_) then
									return
								end

								arg_295_1.musicController:SetSelectedState("hide")
								arg_295_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_298_3 = 0
			local var_298_4 = 0.25

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1105804071).content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 10 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 10)

				if (10 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 10)) > 0 and var_298_4 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_3
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_4, arg_295_1.talkMaxDuration)

			if var_298_3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_3 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_3) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_3 + var_298_8 and arg_295_1.time_ < var_298_3 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1105804072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1105804072
		arg_300_1.duration_ = 9

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1105804073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 2 < arg_300_1.time_ and arg_300_1.time_ <= 2 + arg_303_0 then
				local var_303_0 = arg_300_1.bgs_.C06b

				arg_300_1.bgs_.C06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_303_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_1 = var_303_0:GetComponent("SpriteRenderer")

				if var_303_1 and var_303_1.sprite then
					local var_303_2 = 2 * (var_303_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_303_0.transform.localScale = Vector3.New(var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "C06b" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_3 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_3 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_4 = 2

			if var_303_3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_3 + var_303_4 then
				local var_303_5 = Color.New(0, 0, 0)

				var_303_5.a = Mathf.Lerp(0, 1, (arg_300_1.time_ - var_303_3) / var_303_4)
				arg_300_1.mask_.color = var_303_5
			end

			if arg_300_1.time_ >= var_303_3 + var_303_4 and arg_300_1.time_ < var_303_3 + var_303_4 + arg_303_0 then
				local var_303_6 = Color.New(0, 0, 0)

				var_303_6.a = 1
				arg_300_1.mask_.color = var_303_6
			end

			local var_303_7 = 2

			if 2 < arg_300_1.time_ and arg_300_1.time_ <= var_303_7 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_8 = 2

			if var_303_7 <= arg_300_1.time_ and arg_300_1.time_ < var_303_7 + var_303_8 then
				local var_303_9 = Color.New(0, 0, 0)

				var_303_9.a = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_7) / var_303_8)
				arg_300_1.mask_.color = var_303_9
			end

			if arg_300_1.time_ >= var_303_7 + var_303_8 and arg_300_1.time_ < var_303_7 + var_303_8 + arg_303_0 then
				local var_303_10 = Color.New(0, 0, 0)

				arg_300_1.mask_.enabled = false
				var_303_10.a = 0
				arg_300_1.mask_.color = var_303_10
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_303_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_300_1.bgmTxt_.text ~= var_303_13 and arg_300_1.bgmTxt_.text ~= "" then
						if arg_300_1.bgmTxt2_.text ~= "" then
							arg_300_1.bgmTxt_.text = arg_300_1.bgmTxt2_.text
						end

						arg_300_1.bgmTxt2_.text = var_303_13

						arg_300_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_300_1.bgmTxt_.text = var_303_13
						arg_300_1.bgmTxt2_.text = var_303_13
					end

					if arg_300_1.bgmTimer then
						arg_300_1.bgmTimer:Stop()

						arg_300_1.bgmTimer = nil
					end

					if arg_300_1.settingData.show_music_name == 1 then
						arg_300_1.musicController:SetSelectedState("show")
						arg_300_1.musicAnimator_:Play("open", 0, 0)

						if arg_300_1.settingData.music_time ~= 0 then
							arg_300_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_300_1.settingData.music_time), function()
								if arg_300_1 == nil or isNil(arg_300_1.bgmTxt_) then
									return
								end

								arg_300_1.musicController:SetSelectedState("hide")
								arg_300_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_300_1.time_ and arg_300_1.time_ <= 0.3 + arg_303_0 then
				arg_300_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_303_16 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_300_1.bgmTxt_.text ~= var_303_16 and arg_300_1.bgmTxt_.text ~= "" then
						if arg_300_1.bgmTxt2_.text ~= "" then
							arg_300_1.bgmTxt_.text = arg_300_1.bgmTxt2_.text
						end

						arg_300_1.bgmTxt2_.text = var_303_16

						arg_300_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_300_1.bgmTxt_.text = var_303_16
						arg_300_1.bgmTxt2_.text = var_303_16
					end

					if arg_300_1.bgmTimer then
						arg_300_1.bgmTimer:Stop()

						arg_300_1.bgmTimer = nil
					end

					if arg_300_1.settingData.show_music_name == 1 then
						arg_300_1.musicController:SetSelectedState("show")
						arg_300_1.musicAnimator_:Play("open", 0, 0)

						if arg_300_1.settingData.music_time ~= 0 then
							arg_300_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_300_1.settingData.music_time), function()
								if arg_300_1 == nil or isNil(arg_300_1.bgmTxt_) then
									return
								end

								arg_300_1.musicController:SetSelectedState("hide")
								arg_300_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_17 = 4
			local var_303_18 = 0.85

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_17 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_19 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_19:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_300_1.dialogCg_.alpha = arg_306_0
				end))
				var_303_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_20 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(1105804072).content)

				arg_300_1.text_.text = var_303_20

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_22 = 34 <= 0 and var_303_18 or var_303_18 * (utf8.len(var_303_20) / 34)

				if (34 <= 0 and var_303_18 or var_303_18 * (utf8.len(var_303_20) / 34)) > 0 and var_303_18 < var_303_22 then
					arg_300_1.talkMaxDuration = var_303_22
					var_303_17 = var_303_17 + 0.3

					if var_303_22 + var_303_17 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_22 + var_303_17
					end
				end

				arg_300_1.text_.text = var_303_20
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_23 = var_303_17 + 0.3
			local var_303_24 = math.max(var_303_18, arg_300_1.talkMaxDuration)

			if var_303_17 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_23 + var_303_24 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_23) / var_303_24

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_23 + var_303_24 and arg_300_1.time_ < var_303_23 + var_303_24 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1105804073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1105804073
		arg_308_1.duration_ = 6.03

		local var_308_0 = {
			zh = 5.133,
			ja = 6.033
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1105804074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1058ui_story = arg_308_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1058ui_story"].transform.position).z)
				arg_308_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1058ui_story"].transform.localEulerAngles = arg_308_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_308_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1058ui_story"].transform.position).z)
				arg_308_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1058ui_story"].transform.localEulerAngles = arg_308_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_311_1 = arg_308_1.actors_["1058ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1058ui_story == nil then
				arg_308_1.var_.characterEffect1058ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 and not isNil(var_311_1) then
				if arg_308_1.var_.characterEffect1058ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1058ui_story then
				arg_308_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_311_4 = 0
			local var_311_5 = 0.6

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_6 = arg_308_1:GetWordFromCfg(1105804073)
				local var_311_7 = arg_308_1:FormatText(var_311_6.content)

				arg_308_1.text_.text = var_311_7

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_9 = 24 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 24)

				if (24 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 24)) > 0 and var_311_5 < var_311_9 then
					arg_308_1.talkMaxDuration = var_311_9

					if var_311_9 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_9 + var_311_4
					end
				end

				arg_308_1.text_.text = var_311_7
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804073", "story_v_side_new_1105804.awb") ~= 0 then
					local var_311_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804073", "story_v_side_new_1105804.awb") / 1000

					if var_311_10 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_4
					end

					if var_311_6.prefab_name ~= "" and arg_308_1.actors_[var_311_6.prefab_name] ~= nil then
						local var_311_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_6.prefab_name].transform, "story_v_side_new_1105804", "1105804073", "story_v_side_new_1105804.awb")

						arg_308_1:RecordAudio("1105804073", var_311_11)
						arg_308_1:RecordAudio("1105804073", var_311_11)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804073", "story_v_side_new_1105804.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804073", "story_v_side_new_1105804.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_12 = math.max(var_311_5, arg_308_1.talkMaxDuration)

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_12 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_4) / var_311_12

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_4 + var_311_12 and arg_308_1.time_ < var_311_4 + var_311_12 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play1105804074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1105804074
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1105804075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1058ui_story"]) and arg_312_1.var_.characterEffect1058ui_story == nil then
				arg_312_1.var_.characterEffect1058ui_story = arg_312_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1058ui_story"]) then
				if arg_312_1.var_.characterEffect1058ui_story and not isNil(arg_312_1.actors_["1058ui_story"]) then
					arg_312_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_0)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1058ui_story"]) and arg_312_1.var_.characterEffect1058ui_story then
				arg_312_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_315_1 = 0
			local var_315_2 = 0.425

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(1105804074).content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 17 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_3) / 17)

				if (17 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_3) / 17)) > 0 and var_315_2 < var_315_5 then
					arg_312_1.talkMaxDuration = var_315_5

					if var_315_5 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + var_315_1
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_6 = math.max(var_315_2, arg_312_1.talkMaxDuration)

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_6 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_1) / var_315_6

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_1 + var_315_6 and arg_312_1.time_ < var_315_1 + var_315_6 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1105804075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1105804075
		arg_316_1.duration_ = 8.43

		local var_316_0 = {
			zh = 6.066,
			ja = 8.433
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1105804076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1058ui_story = arg_316_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_319_0 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 then
				arg_316_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_316_1.time_ - 0) / var_319_0)
				arg_316_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1058ui_story"].transform.position).z)
				arg_316_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1058ui_story"].transform.localEulerAngles = arg_316_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 then
				arg_316_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_316_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1058ui_story"].transform.position).z)
				arg_316_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1058ui_story"].transform.localEulerAngles = arg_316_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_319_1 = arg_316_1.actors_["1058ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1058ui_story == nil then
				arg_316_1.var_.characterEffect1058ui_story = var_319_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_2 and not isNil(var_319_1) then
				if arg_316_1.var_.characterEffect1058ui_story and not isNil(var_319_1) then
					arg_316_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_2 and arg_316_1.time_ < 0 + var_319_2 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1058ui_story then
				arg_316_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_1")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_319_4 = 0
			local var_319_5 = 0.725

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_6 = arg_316_1:GetWordFromCfg(1105804075)
				local var_319_7 = arg_316_1:FormatText(var_319_6.content)

				arg_316_1.text_.text = var_319_7

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_9 = 29 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 29)

				if (29 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 29)) > 0 and var_319_5 < var_319_9 then
					arg_316_1.talkMaxDuration = var_319_9

					if var_319_9 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_9 + var_319_4
					end
				end

				arg_316_1.text_.text = var_319_7
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804075", "story_v_side_new_1105804.awb") ~= 0 then
					local var_319_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804075", "story_v_side_new_1105804.awb") / 1000

					if var_319_10 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_4
					end

					if var_319_6.prefab_name ~= "" and arg_316_1.actors_[var_319_6.prefab_name] ~= nil then
						local var_319_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_6.prefab_name].transform, "story_v_side_new_1105804", "1105804075", "story_v_side_new_1105804.awb")

						arg_316_1:RecordAudio("1105804075", var_319_11)
						arg_316_1:RecordAudio("1105804075", var_319_11)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804075", "story_v_side_new_1105804.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804075", "story_v_side_new_1105804.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_12 = math.max(var_319_5, arg_316_1.talkMaxDuration)

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_12 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_4) / var_319_12

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_4 + var_319_12 and arg_316_1.time_ < var_319_4 + var_319_12 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play1105804076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1105804076
		arg_320_1.duration_ = 4.47

		local var_320_0 = {
			zh = 2.766,
			ja = 4.466
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1105804077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_323_0 = 0
			local var_323_1 = 0.325

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(1105804076)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 13 <= 0 and var_323_1 or var_323_1 * (utf8.len(var_323_3) / 13)

				if (13 <= 0 and var_323_1 or var_323_1 * (utf8.len(var_323_3) / 13)) > 0 and var_323_1 < var_323_5 then
					arg_320_1.talkMaxDuration = var_323_5

					if var_323_5 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804076", "story_v_side_new_1105804.awb") ~= 0 then
					local var_323_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804076", "story_v_side_new_1105804.awb") / 1000

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end

					if var_323_2.prefab_name ~= "" and arg_320_1.actors_[var_323_2.prefab_name] ~= nil then
						local var_323_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_2.prefab_name].transform, "story_v_side_new_1105804", "1105804076", "story_v_side_new_1105804.awb")

						arg_320_1:RecordAudio("1105804076", var_323_7)
						arg_320_1:RecordAudio("1105804076", var_323_7)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804076", "story_v_side_new_1105804.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804076", "story_v_side_new_1105804.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_8 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_8 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_8

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_8 and arg_320_1.time_ < var_323_0 + var_323_8 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1105804077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1105804077
		arg_324_1.duration_ = 1

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"

			SetActive(arg_324_1.choicesGo_, true)

			for iter_325_0, iter_325_1 in ipairs(arg_324_1.choices_) do
				SetActive(iter_325_1.go, iter_325_0 <= 2)
			end

			arg_324_1.choices_[1].txt.text = arg_324_1:FormatText(StoryChoiceCfg[535].name)
			arg_324_1.choices_[2].txt.text = arg_324_1:FormatText(StoryChoiceCfg[536].name)
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1105804078(arg_324_1)
			end

			if arg_326_0 == 2 then
				arg_324_0:Play1105804079(arg_324_1)
			end

			arg_324_1:RecordChoiceLog(1105804077, 535, 536)
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1058ui_story"]) and arg_324_1.var_.characterEffect1058ui_story == nil then
				arg_324_1.var_.characterEffect1058ui_story = arg_324_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1058ui_story"]) then
				if arg_324_1.var_.characterEffect1058ui_story and not isNil(arg_324_1.actors_["1058ui_story"]) then
					arg_324_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_0)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1058ui_story"]) and arg_324_1.var_.characterEffect1058ui_story then
				arg_324_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1105804078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1105804078
		arg_328_1.duration_ = 3

		local var_328_0 = {
			zh = 3,
			ja = 2.066
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1105804081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_2")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_331_0 = arg_328_1.actors_["1058ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1058ui_story == nil then
				arg_328_1.var_.characterEffect1058ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_1 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_1 and not isNil(var_331_0) then
				if arg_328_1.var_.characterEffect1058ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_1 and arg_328_1.time_ < 0 + var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1058ui_story then
				arg_328_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_331_3 = 0
			local var_331_4 = 0.3

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_5 = arg_328_1:GetWordFromCfg(1105804078)
				local var_331_6 = arg_328_1:FormatText(var_331_5.content)

				arg_328_1.text_.text = var_331_6

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_8 = 12 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_6) / 12)

				if (12 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_6) / 12)) > 0 and var_331_4 < var_331_8 then
					arg_328_1.talkMaxDuration = var_331_8

					if var_331_8 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_3
					end
				end

				arg_328_1.text_.text = var_331_6
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804078", "story_v_side_new_1105804.awb") ~= 0 then
					local var_331_9 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804078", "story_v_side_new_1105804.awb") / 1000

					if var_331_9 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_3
					end

					if var_331_5.prefab_name ~= "" and arg_328_1.actors_[var_331_5.prefab_name] ~= nil then
						local var_331_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_5.prefab_name].transform, "story_v_side_new_1105804", "1105804078", "story_v_side_new_1105804.awb")

						arg_328_1:RecordAudio("1105804078", var_331_10)
						arg_328_1:RecordAudio("1105804078", var_331_10)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804078", "story_v_side_new_1105804.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804078", "story_v_side_new_1105804.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_11 = math.max(var_331_4, arg_328_1.talkMaxDuration)

			if var_331_3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_3 + var_331_11 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_3) / var_331_11

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_3 + var_331_11 and arg_328_1.time_ < var_331_3 + var_331_11 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1105804081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1105804081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1105804082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_fireworks3", "")
			end

			local var_335_1 = arg_332_1.actors_["1058ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1058ui_story = var_335_1.localPosition
			end

			local var_335_2 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 then
				var_335_1.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_2)
				var_335_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_1.position).x, (manager.ui.mainCamera.transform.position - var_335_1.position).y, (manager.ui.mainCamera.transform.position - var_335_1.position).z)
				var_335_1.localEulerAngles.z = 0
				var_335_1.localEulerAngles.x = 0
				var_335_1.localEulerAngles = var_335_1.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 then
				var_335_1.localPosition = Vector3.New(0, 100, 0)
				var_335_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_1.position).x, (manager.ui.mainCamera.transform.position - var_335_1.position).y, (manager.ui.mainCamera.transform.position - var_335_1.position).z)
				var_335_1.localEulerAngles.z = 0
				var_335_1.localEulerAngles.x = 0
				var_335_1.localEulerAngles = var_335_1.localEulerAngles
			end

			local var_335_3 = 0
			local var_335_4 = 1.025

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_3 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_5 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(1105804081).content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_7 = 41 <= 0 and var_335_4 or var_335_4 * (utf8.len(var_335_5) / 41)

				if (41 <= 0 and var_335_4 or var_335_4 * (utf8.len(var_335_5) / 41)) > 0 and var_335_4 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_3 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_3
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_8 = math.max(var_335_4, arg_332_1.talkMaxDuration)

			if var_335_3 <= arg_332_1.time_ and arg_332_1.time_ < var_335_3 + var_335_8 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_3) / var_335_8

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_3 + var_335_8 and arg_332_1.time_ < var_335_3 + var_335_8 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1105804082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1105804082
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1105804083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.525

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_1 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(1105804082).content)

				arg_336_1.text_.text = var_339_1

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_3 = 21 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 21)

				if (21 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 21)) > 0 and var_339_0 < var_339_3 then
					arg_336_1.talkMaxDuration = var_339_3

					if var_339_3 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_3 + 0
					end
				end

				arg_336_1.text_.text = var_339_1
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_4 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_4

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1105804083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1105804083
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1105804084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.35

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_1 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(1105804083).content)

				arg_340_1.text_.text = var_343_1

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_3 = 14 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 14)

				if (14 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 14)) > 0 and var_343_0 < var_343_3 then
					arg_340_1.talkMaxDuration = var_343_3

					if var_343_3 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_3 + 0
					end
				end

				arg_340_1.text_.text = var_343_1
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_4 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_4

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1105804084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1105804084
		arg_344_1.duration_ = 7.8

		local var_344_0 = {
			zh = 5.2,
			ja = 7.8
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1105804085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos1058ui_story = arg_344_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_347_0 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 then
				arg_344_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_344_1.time_ - 0) / var_347_0)
				arg_344_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1058ui_story"].transform.position).z)
				arg_344_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["1058ui_story"].transform.localEulerAngles = arg_344_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 then
				arg_344_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_344_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["1058ui_story"].transform.position).z)
				arg_344_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["1058ui_story"].transform.localEulerAngles = arg_344_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_347_1 = arg_344_1.actors_["1058ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect1058ui_story == nil then
				arg_344_1.var_.characterEffect1058ui_story = var_347_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_2 and not isNil(var_347_1) then
				if arg_344_1.var_.characterEffect1058ui_story and not isNil(var_347_1) then
					arg_344_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_2 and arg_344_1.time_ < 0 + var_347_2 + arg_347_0 and not isNil(var_347_1) and arg_344_1.var_.characterEffect1058ui_story then
				arg_344_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_4 = 0
			local var_347_5 = 0.6

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_6 = arg_344_1:GetWordFromCfg(1105804084)
				local var_347_7 = arg_344_1:FormatText(var_347_6.content)

				arg_344_1.text_.text = var_347_7

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_9 = 24 <= 0 and var_347_5 or var_347_5 * (utf8.len(var_347_7) / 24)

				if (24 <= 0 and var_347_5 or var_347_5 * (utf8.len(var_347_7) / 24)) > 0 and var_347_5 < var_347_9 then
					arg_344_1.talkMaxDuration = var_347_9

					if var_347_9 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_9 + var_347_4
					end
				end

				arg_344_1.text_.text = var_347_7
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804084", "story_v_side_new_1105804.awb") ~= 0 then
					local var_347_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804084", "story_v_side_new_1105804.awb") / 1000

					if var_347_10 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_4
					end

					if var_347_6.prefab_name ~= "" and arg_344_1.actors_[var_347_6.prefab_name] ~= nil then
						local var_347_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_6.prefab_name].transform, "story_v_side_new_1105804", "1105804084", "story_v_side_new_1105804.awb")

						arg_344_1:RecordAudio("1105804084", var_347_11)
						arg_344_1:RecordAudio("1105804084", var_347_11)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804084", "story_v_side_new_1105804.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804084", "story_v_side_new_1105804.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_12 = math.max(var_347_5, arg_344_1.talkMaxDuration)

			if var_347_4 <= arg_344_1.time_ and arg_344_1.time_ < var_347_4 + var_347_12 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_4) / var_347_12

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_4 + var_347_12 and arg_344_1.time_ < var_347_4 + var_347_12 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play1105804085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1105804085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1105804086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["1058ui_story"]) and arg_348_1.var_.characterEffect1058ui_story == nil then
				arg_348_1.var_.characterEffect1058ui_story = arg_348_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["1058ui_story"]) then
				if arg_348_1.var_.characterEffect1058ui_story and not isNil(arg_348_1.actors_["1058ui_story"]) then
					arg_348_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_0)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["1058ui_story"]) and arg_348_1.var_.characterEffect1058ui_story then
				arg_348_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_351_1 = 0
			local var_351_2 = 0.475

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(1105804085).content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 19 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 19)

				if (19 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 19)) > 0 and var_351_2 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_6 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_6 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_6

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_6 and arg_348_1.time_ < var_351_1 + var_351_6 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1105804086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1105804086
		arg_352_1.duration_ = 4.13

		local var_352_0 = {
			zh = 4.133,
			ja = 3.7
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1105804087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1058ui_story = arg_352_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_355_0 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 then
				arg_352_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_352_1.time_ - 0) / var_355_0)
				arg_352_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1058ui_story"].transform.position).z)
				arg_352_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1058ui_story"].transform.localEulerAngles = arg_352_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 then
				arg_352_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_352_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1058ui_story"].transform.position).z)
				arg_352_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1058ui_story"].transform.localEulerAngles = arg_352_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_355_1 = arg_352_1.actors_["1058ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1058ui_story == nil then
				arg_352_1.var_.characterEffect1058ui_story = var_355_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_2 and not isNil(var_355_1) then
				if arg_352_1.var_.characterEffect1058ui_story and not isNil(var_355_1) then
					arg_352_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_2 and arg_352_1.time_ < 0 + var_355_2 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1058ui_story then
				arg_352_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_4 = 0
			local var_355_5 = 0.35

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_6 = arg_352_1:GetWordFromCfg(1105804086)
				local var_355_7 = arg_352_1:FormatText(var_355_6.content)

				arg_352_1.text_.text = var_355_7

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 14 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 14)

				if (14 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 14)) > 0 and var_355_5 < var_355_9 then
					arg_352_1.talkMaxDuration = var_355_9

					if var_355_9 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_9 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_7
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804086", "story_v_side_new_1105804.awb") ~= 0 then
					local var_355_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804086", "story_v_side_new_1105804.awb") / 1000

					if var_355_10 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_4
					end

					if var_355_6.prefab_name ~= "" and arg_352_1.actors_[var_355_6.prefab_name] ~= nil then
						local var_355_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_6.prefab_name].transform, "story_v_side_new_1105804", "1105804086", "story_v_side_new_1105804.awb")

						arg_352_1:RecordAudio("1105804086", var_355_11)
						arg_352_1:RecordAudio("1105804086", var_355_11)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804086", "story_v_side_new_1105804.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804086", "story_v_side_new_1105804.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_12 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_12 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_12

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_12 and arg_352_1.time_ < var_355_4 + var_355_12 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play1105804087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1105804087
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1105804088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1058ui_story"]) and arg_356_1.var_.characterEffect1058ui_story == nil then
				arg_356_1.var_.characterEffect1058ui_story = arg_356_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1058ui_story"]) then
				if arg_356_1.var_.characterEffect1058ui_story and not isNil(arg_356_1.actors_["1058ui_story"]) then
					arg_356_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 0) / var_359_0)
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1058ui_story"]) and arg_356_1.var_.characterEffect1058ui_story then
				arg_356_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_359_1 = 0
			local var_359_2 = 0.575

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(1105804087).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 23 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 23)

				if (23 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 23)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1105804088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1105804088
		arg_360_1.duration_ = 7.03

		local var_360_0 = {
			zh = 7.033,
			ja = 3.3
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1105804089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos1058ui_story = arg_360_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1058ui_story"].transform.position).z)
				arg_360_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1058ui_story"].transform.localEulerAngles = arg_360_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_360_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1058ui_story"].transform.position).z)
				arg_360_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1058ui_story"].transform.localEulerAngles = arg_360_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_363_1 = arg_360_1.actors_["1058ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1058ui_story == nil then
				arg_360_1.var_.characterEffect1058ui_story = var_363_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_2 and not isNil(var_363_1) then
				if arg_360_1.var_.characterEffect1058ui_story and not isNil(var_363_1) then
					arg_360_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_2 and arg_360_1.time_ < 0 + var_363_2 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1058ui_story then
				arg_360_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action423")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_363_4 = 0
			local var_363_5 = 0.8

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(1105804088)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 32 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 32)

				if (32 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 32)) > 0 and var_363_5 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804088", "story_v_side_new_1105804.awb") ~= 0 then
					local var_363_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804088", "story_v_side_new_1105804.awb") / 1000

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end

					if var_363_6.prefab_name ~= "" and arg_360_1.actors_[var_363_6.prefab_name] ~= nil then
						local var_363_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_6.prefab_name].transform, "story_v_side_new_1105804", "1105804088", "story_v_side_new_1105804.awb")

						arg_360_1:RecordAudio("1105804088", var_363_11)
						arg_360_1:RecordAudio("1105804088", var_363_11)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804088", "story_v_side_new_1105804.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804088", "story_v_side_new_1105804.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_12 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_12 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_12

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_12 and arg_360_1.time_ < var_363_4 + var_363_12 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play1105804089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1105804089
		arg_364_1.duration_ = 14.13

		local var_364_0 = {
			zh = 9.7,
			ja = 14.133
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1105804090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_367_0 = 0
			local var_367_1 = 1.1

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(1105804089)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 44 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 44)

				if (44 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 44)) > 0 and var_367_1 < var_367_5 then
					arg_364_1.talkMaxDuration = var_367_5

					if var_367_5 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804089", "story_v_side_new_1105804.awb") ~= 0 then
					local var_367_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804089", "story_v_side_new_1105804.awb") / 1000

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end

					if var_367_2.prefab_name ~= "" and arg_364_1.actors_[var_367_2.prefab_name] ~= nil then
						local var_367_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_2.prefab_name].transform, "story_v_side_new_1105804", "1105804089", "story_v_side_new_1105804.awb")

						arg_364_1:RecordAudio("1105804089", var_367_7)
						arg_364_1:RecordAudio("1105804089", var_367_7)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804089", "story_v_side_new_1105804.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804089", "story_v_side_new_1105804.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_8 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_8 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_8

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_8 and arg_364_1.time_ < var_367_0 + var_367_8 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1105804090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1105804090
		arg_368_1.duration_ = 11.7

		local var_368_0 = {
			zh = 4.1,
			ja = 11.7
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1105804091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_2")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_0 = 0
			local var_371_1 = 0.575

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_2 = arg_368_1:GetWordFromCfg(1105804090)
				local var_371_3 = arg_368_1:FormatText(var_371_2.content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 23 <= 0 and var_371_1 or var_371_1 * (utf8.len(var_371_3) / 23)

				if (23 <= 0 and var_371_1 or var_371_1 * (utf8.len(var_371_3) / 23)) > 0 and var_371_1 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804090", "story_v_side_new_1105804.awb") ~= 0 then
					local var_371_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804090", "story_v_side_new_1105804.awb") / 1000

					if var_371_6 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_0
					end

					if var_371_2.prefab_name ~= "" and arg_368_1.actors_[var_371_2.prefab_name] ~= nil then
						local var_371_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_2.prefab_name].transform, "story_v_side_new_1105804", "1105804090", "story_v_side_new_1105804.awb")

						arg_368_1:RecordAudio("1105804090", var_371_7)
						arg_368_1:RecordAudio("1105804090", var_371_7)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804090", "story_v_side_new_1105804.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804090", "story_v_side_new_1105804.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_8 and arg_368_1.time_ < var_371_0 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1105804091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1105804091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1105804092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1058ui_story"]) and arg_372_1.var_.characterEffect1058ui_story == nil then
				arg_372_1.var_.characterEffect1058ui_story = arg_372_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1058ui_story"]) then
				if arg_372_1.var_.characterEffect1058ui_story and not isNil(arg_372_1.actors_["1058ui_story"]) then
					arg_372_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1058ui_story"]) and arg_372_1.var_.characterEffect1058ui_story then
				arg_372_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.325

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1105804091).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 13 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 13)

				if (13 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 13)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1105804092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1105804092
		arg_376_1.duration_ = 2

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1105804093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1058ui_story = arg_376_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1058ui_story"].transform.position).z)
				arg_376_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1058ui_story"].transform.localEulerAngles = arg_376_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_376_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1058ui_story"].transform.position).z)
				arg_376_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1058ui_story"].transform.localEulerAngles = arg_376_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_379_1 = arg_376_1.actors_["1058ui_story"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1058ui_story == nil then
				arg_376_1.var_.characterEffect1058ui_story = var_379_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_2 and not isNil(var_379_1) then
				if arg_376_1.var_.characterEffect1058ui_story and not isNil(var_379_1) then
					arg_376_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_2 and arg_376_1.time_ < 0 + var_379_2 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1058ui_story then
				arg_376_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_379_4 = 0
			local var_379_5 = 0.05

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_6 = arg_376_1:GetWordFromCfg(1105804092)
				local var_379_7 = arg_376_1:FormatText(var_379_6.content)

				arg_376_1.text_.text = var_379_7

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_9 = 2 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 2)

				if (2 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 2)) > 0 and var_379_5 < var_379_9 then
					arg_376_1.talkMaxDuration = var_379_9

					if var_379_9 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_9 + var_379_4
					end
				end

				arg_376_1.text_.text = var_379_7
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804092", "story_v_side_new_1105804.awb") ~= 0 then
					local var_379_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804092", "story_v_side_new_1105804.awb") / 1000

					if var_379_10 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_4
					end

					if var_379_6.prefab_name ~= "" and arg_376_1.actors_[var_379_6.prefab_name] ~= nil then
						local var_379_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_6.prefab_name].transform, "story_v_side_new_1105804", "1105804092", "story_v_side_new_1105804.awb")

						arg_376_1:RecordAudio("1105804092", var_379_11)
						arg_376_1:RecordAudio("1105804092", var_379_11)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804092", "story_v_side_new_1105804.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804092", "story_v_side_new_1105804.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_12 = math.max(var_379_5, arg_376_1.talkMaxDuration)

			if var_379_4 <= arg_376_1.time_ and arg_376_1.time_ < var_379_4 + var_379_12 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_4) / var_379_12

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_4 + var_379_12 and arg_376_1.time_ < var_379_4 + var_379_12 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play1105804093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1105804093
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1105804094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1058ui_story"]) and arg_380_1.var_.characterEffect1058ui_story == nil then
				arg_380_1.var_.characterEffect1058ui_story = arg_380_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1058ui_story"]) then
				if arg_380_1.var_.characterEffect1058ui_story and not isNil(arg_380_1.actors_["1058ui_story"]) then
					arg_380_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1058ui_story"]) and arg_380_1.var_.characterEffect1058ui_story then
				arg_380_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.8

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(1105804093).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 32 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 32)

				if (32 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 32)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1105804094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1105804094
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1105804095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.425

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(1105804094).content)

				arg_384_1.text_.text = var_387_1

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_3 = 17 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 17)

				if (17 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 17)) > 0 and var_387_0 < var_387_3 then
					arg_384_1.talkMaxDuration = var_387_3

					if var_387_3 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_3 + 0
					end
				end

				arg_384_1.text_.text = var_387_1
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_4 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_4

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1105804095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1105804095
		arg_388_1.duration_ = 4.27

		local var_388_0 = {
			zh = 1.999999999999,
			ja = 4.266
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1105804096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1058ui_story = arg_388_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1058ui_story"].transform.position).z)
				arg_388_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1058ui_story"].transform.localEulerAngles = arg_388_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_388_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1058ui_story"].transform.position).z)
				arg_388_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1058ui_story"].transform.localEulerAngles = arg_388_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_391_1 = arg_388_1.actors_["1058ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1058ui_story == nil then
				arg_388_1.var_.characterEffect1058ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect1058ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1058ui_story then
				arg_388_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_2")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_391_4 = 0
			local var_391_5 = 0.075

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(1105804095)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 3 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 3)

				if (3 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 3)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804095", "story_v_side_new_1105804.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804095", "story_v_side_new_1105804.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_side_new_1105804", "1105804095", "story_v_side_new_1105804.awb")

						arg_388_1:RecordAudio("1105804095", var_391_11)
						arg_388_1:RecordAudio("1105804095", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804095", "story_v_side_new_1105804.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804095", "story_v_side_new_1105804.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_12 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_12 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_12

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_12 and arg_388_1.time_ < var_391_4 + var_391_12 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1105804096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1105804096
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1105804097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1058ui_story"]) and arg_392_1.var_.characterEffect1058ui_story == nil then
				arg_392_1.var_.characterEffect1058ui_story = arg_392_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1058ui_story"]) then
				if arg_392_1.var_.characterEffect1058ui_story and not isNil(arg_392_1.actors_["1058ui_story"]) then
					arg_392_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_0)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1058ui_story"]) and arg_392_1.var_.characterEffect1058ui_story then
				arg_392_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_395_1 = 0
			local var_395_2 = 0.325

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(1105804096).content)

				arg_392_1.text_.text = var_395_3

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 13 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_3) / 13)

				if (13 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_3) / 13)) > 0 and var_395_2 < var_395_5 then
					arg_392_1.talkMaxDuration = var_395_5

					if var_395_5 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_3
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_6 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_6 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_6

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_6 and arg_392_1.time_ < var_395_1 + var_395_6 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1105804097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1105804097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1105804098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_399_0 = 0
			local var_399_1 = 0.5

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_2 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(1105804097).content)

				arg_396_1.text_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 20 <= 0 and var_399_1 or var_399_1 * (utf8.len(var_399_2) / 20)

				if (20 <= 0 and var_399_1 or var_399_1 * (utf8.len(var_399_2) / 20)) > 0 and var_399_1 < var_399_4 then
					arg_396_1.talkMaxDuration = var_399_4

					if var_399_4 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_4 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_2
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_5 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_5 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_5

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_5 and arg_396_1.time_ < var_399_0 + var_399_5 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1105804098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1105804098
		arg_400_1.duration_ = 4.3

		local var_400_0 = {
			zh = 3.266,
			ja = 4.3
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1105804099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1058ui_story = arg_400_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_403_0 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 then
				arg_400_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_400_1.time_ - 0) / var_403_0)
				arg_400_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1058ui_story"].transform.position).z)
				arg_400_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1058ui_story"].transform.localEulerAngles = arg_400_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 then
				arg_400_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_400_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1058ui_story"].transform.position).z)
				arg_400_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1058ui_story"].transform.localEulerAngles = arg_400_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_403_1 = arg_400_1.actors_["1058ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect1058ui_story == nil then
				arg_400_1.var_.characterEffect1058ui_story = var_403_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_2 and not isNil(var_403_1) then
				if arg_400_1.var_.characterEffect1058ui_story and not isNil(var_403_1) then
					arg_400_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_2 and arg_400_1.time_ < 0 + var_403_2 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect1058ui_story then
				arg_400_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_403_4 = 0
			local var_403_5 = 0.35

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_6 = arg_400_1:GetWordFromCfg(1105804098)
				local var_403_7 = arg_400_1:FormatText(var_403_6.content)

				arg_400_1.text_.text = var_403_7

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 14 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 14)

				if (14 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 14)) > 0 and var_403_5 < var_403_9 then
					arg_400_1.talkMaxDuration = var_403_9

					if var_403_9 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_9 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_7
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804098", "story_v_side_new_1105804.awb") ~= 0 then
					local var_403_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804098", "story_v_side_new_1105804.awb") / 1000

					if var_403_10 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_4
					end

					if var_403_6.prefab_name ~= "" and arg_400_1.actors_[var_403_6.prefab_name] ~= nil then
						local var_403_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_6.prefab_name].transform, "story_v_side_new_1105804", "1105804098", "story_v_side_new_1105804.awb")

						arg_400_1:RecordAudio("1105804098", var_403_11)
						arg_400_1:RecordAudio("1105804098", var_403_11)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804098", "story_v_side_new_1105804.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804098", "story_v_side_new_1105804.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_12 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_12 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_12

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_12 and arg_400_1.time_ < var_403_4 + var_403_12 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1105804099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1105804099
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1105804100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1058ui_story"]) and arg_404_1.var_.characterEffect1058ui_story == nil then
				arg_404_1.var_.characterEffect1058ui_story = arg_404_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1058ui_story"]) then
				if arg_404_1.var_.characterEffect1058ui_story and not isNil(arg_404_1.actors_["1058ui_story"]) then
					arg_404_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_0)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1058ui_story"]) and arg_404_1.var_.characterEffect1058ui_story then
				arg_404_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_fireworks4", "")
			end

			local var_407_2 = arg_404_1.actors_["1058ui_story"].transform

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1058ui_story = var_407_2.localPosition
			end

			local var_407_3 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_3 then
				var_407_2.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 0) / var_407_3)
				var_407_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_2.position).x, (manager.ui.mainCamera.transform.position - var_407_2.position).y, (manager.ui.mainCamera.transform.position - var_407_2.position).z)
				var_407_2.localEulerAngles.z = 0
				var_407_2.localEulerAngles.x = 0
				var_407_2.localEulerAngles = var_407_2.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_3 and arg_404_1.time_ < 0 + var_407_3 + arg_407_0 then
				var_407_2.localPosition = Vector3.New(0, 100, 0)
				var_407_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_2.position).x, (manager.ui.mainCamera.transform.position - var_407_2.position).y, (manager.ui.mainCamera.transform.position - var_407_2.position).z)
				var_407_2.localEulerAngles.z = 0
				var_407_2.localEulerAngles.x = 0
				var_407_2.localEulerAngles = var_407_2.localEulerAngles
			end

			local var_407_4 = 0
			local var_407_5 = 0.975

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(1105804099).content)

				arg_404_1.text_.text = var_407_6

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_8 = 39 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_6) / 39)

				if (39 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_6) / 39)) > 0 and var_407_5 < var_407_8 then
					arg_404_1.talkMaxDuration = var_407_8

					if var_407_8 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_6
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_9 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_9 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_9

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_9 and arg_404_1.time_ < var_407_4 + var_407_9 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1105804100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1105804100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1105804101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.5

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1105804100).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 20 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 20)

				if (20 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 20)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1105804101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1105804101
		arg_412_1.duration_ = 5.47

		local var_412_0 = {
			zh = 3.2,
			ja = 5.466
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1105804102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1058ui_story = arg_412_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1058ui_story"].transform.position).z)
				arg_412_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1058ui_story"].transform.localEulerAngles = arg_412_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_412_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1058ui_story"].transform.position).z)
				arg_412_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1058ui_story"].transform.localEulerAngles = arg_412_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_415_1 = arg_412_1.actors_["1058ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect1058ui_story == nil then
				arg_412_1.var_.characterEffect1058ui_story = var_415_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_2 and not isNil(var_415_1) then
				if arg_412_1.var_.characterEffect1058ui_story and not isNil(var_415_1) then
					arg_412_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_2 and arg_412_1.time_ < 0 + var_415_2 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect1058ui_story then
				arg_412_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_415_4 = 0
			local var_415_5 = 0.4

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_6 = arg_412_1:GetWordFromCfg(1105804101)
				local var_415_7 = arg_412_1:FormatText(var_415_6.content)

				arg_412_1.text_.text = var_415_7

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_9 = 16 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 16)

				if (16 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 16)) > 0 and var_415_5 < var_415_9 then
					arg_412_1.talkMaxDuration = var_415_9

					if var_415_9 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_4
					end
				end

				arg_412_1.text_.text = var_415_7
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804101", "story_v_side_new_1105804.awb") ~= 0 then
					local var_415_10 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804101", "story_v_side_new_1105804.awb") / 1000

					if var_415_10 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_4
					end

					if var_415_6.prefab_name ~= "" and arg_412_1.actors_[var_415_6.prefab_name] ~= nil then
						local var_415_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_6.prefab_name].transform, "story_v_side_new_1105804", "1105804101", "story_v_side_new_1105804.awb")

						arg_412_1:RecordAudio("1105804101", var_415_11)
						arg_412_1:RecordAudio("1105804101", var_415_11)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804101", "story_v_side_new_1105804.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804101", "story_v_side_new_1105804.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_12 = math.max(var_415_5, arg_412_1.talkMaxDuration)

			if var_415_4 <= arg_412_1.time_ and arg_412_1.time_ < var_415_4 + var_415_12 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_4) / var_415_12

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_4 + var_415_12 and arg_412_1.time_ < var_415_4 + var_415_12 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play1105804102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1105804102
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1105804103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["1058ui_story"]) and arg_416_1.var_.characterEffect1058ui_story == nil then
				arg_416_1.var_.characterEffect1058ui_story = arg_416_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_0 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["1058ui_story"]) then
				if arg_416_1.var_.characterEffect1058ui_story and not isNil(arg_416_1.actors_["1058ui_story"]) then
					arg_416_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_416_1.time_ - 0) / var_419_0)
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["1058ui_story"]) and arg_416_1.var_.characterEffect1058ui_story then
				arg_416_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_419_1 = 0
			local var_419_2 = 0.3

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(1105804102).content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 12 <= 0 and var_419_2 or var_419_2 * (utf8.len(var_419_3) / 12)

				if (12 <= 0 and var_419_2 or var_419_2 * (utf8.len(var_419_3) / 12)) > 0 and var_419_2 < var_419_5 then
					arg_416_1.talkMaxDuration = var_419_5

					if var_419_5 + var_419_1 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + var_419_1
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_6 = math.max(var_419_2, arg_416_1.talkMaxDuration)

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_6 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_1) / var_419_6

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_1 + var_419_6 and arg_416_1.time_ < var_419_1 + var_419_6 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1105804103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1105804103
		arg_420_1.duration_ = 7.87

		local var_420_0 = {
			zh = 6.666,
			ja = 7.866
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1105804104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1058ui_story"]) and arg_420_1.var_.characterEffect1058ui_story == nil then
				arg_420_1.var_.characterEffect1058ui_story = arg_420_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1058ui_story"]) then
				if arg_420_1.var_.characterEffect1058ui_story and not isNil(arg_420_1.actors_["1058ui_story"]) then
					arg_420_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1058ui_story"]) and arg_420_1.var_.characterEffect1058ui_story then
				arg_420_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_423_2 = 0
			local var_423_3 = 0.725

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_4 = arg_420_1:GetWordFromCfg(1105804103)
				local var_423_5 = arg_420_1:FormatText(var_423_4.content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 29 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 29)

				if (29 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 29)) > 0 and var_423_3 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_2
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804103", "story_v_side_new_1105804.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804103", "story_v_side_new_1105804.awb") / 1000

					if var_423_8 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_2
					end

					if var_423_4.prefab_name ~= "" and arg_420_1.actors_[var_423_4.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_4.prefab_name].transform, "story_v_side_new_1105804", "1105804103", "story_v_side_new_1105804.awb")

						arg_420_1:RecordAudio("1105804103", var_423_9)
						arg_420_1:RecordAudio("1105804103", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804103", "story_v_side_new_1105804.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804103", "story_v_side_new_1105804.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_3, arg_420_1.talkMaxDuration)

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_2) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_2 + var_423_10 and arg_420_1.time_ < var_423_2 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1105804104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1105804104
		arg_424_1.duration_ = 9.77

		local var_424_0 = {
			zh = 4.4,
			ja = 9.766
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
			arg_424_1.auto_ = false
		end

		function arg_424_1.playNext_(arg_426_0)
			arg_424_1.onStoryFinished_()
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_427_0 = 0
			local var_427_1 = 0.5

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_2 = arg_424_1:GetWordFromCfg(1105804104)
				local var_427_3 = arg_424_1:FormatText(var_427_2.content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 20 <= 0 and var_427_1 or var_427_1 * (utf8.len(var_427_3) / 20)

				if (20 <= 0 and var_427_1 or var_427_1 * (utf8.len(var_427_3) / 20)) > 0 and var_427_1 < var_427_5 then
					arg_424_1.talkMaxDuration = var_427_5

					if var_427_5 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804104", "story_v_side_new_1105804.awb") ~= 0 then
					local var_427_6 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804104", "story_v_side_new_1105804.awb") / 1000

					if var_427_6 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_6 + var_427_0
					end

					if var_427_2.prefab_name ~= "" and arg_424_1.actors_[var_427_2.prefab_name] ~= nil then
						local var_427_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_2.prefab_name].transform, "story_v_side_new_1105804", "1105804104", "story_v_side_new_1105804.awb")

						arg_424_1:RecordAudio("1105804104", var_427_7)
						arg_424_1:RecordAudio("1105804104", var_427_7)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804104", "story_v_side_new_1105804.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804104", "story_v_side_new_1105804.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_8 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_8 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_8

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_8 and arg_424_1.time_ < var_427_0 + var_427_8 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1105804079 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1105804079
		arg_428_1.duration_ = 3

		local var_428_0 = {
			zh = 3,
			ja = 2.4
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1105804080(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if arg_428_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_431_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_428_1.stage_.transform)

				var_431_0.name = "1058ui_story"
				var_431_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.actors_["1058ui_story"] = var_431_0

				local var_431_1 = var_431_0:GetComponentInChildren(typeof(CharacterEffect))

				var_431_1.enabled = true

				local var_431_2 = GameObjectTools.GetOrAddComponent(var_431_0, typeof(DynamicBoneHelper))

				if var_431_2 then
					var_431_2:EnableDynamicBone(false)
				end

				arg_428_1:ShowWeapon(var_431_1.transform, false)

				arg_428_1.var_["1058ui_story" .. "Animator"] = var_431_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_428_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_428_1.var_["1058ui_story" .. "LipSync"] = var_431_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_2")
			end

			local var_431_3 = "1058ui_story"

			if arg_428_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_431_4 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_428_1.stage_.transform)

				var_431_4.name = var_431_3
				var_431_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.actors_[var_431_3] = var_431_4

				local var_431_5 = var_431_4:GetComponentInChildren(typeof(CharacterEffect))

				var_431_5.enabled = true

				local var_431_6 = GameObjectTools.GetOrAddComponent(var_431_4, typeof(DynamicBoneHelper))

				if var_431_6 then
					var_431_6:EnableDynamicBone(false)
				end

				arg_428_1:ShowWeapon(var_431_5.transform, false)

				arg_428_1.var_[var_431_3 .. "Animator"] = var_431_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_428_1.var_[var_431_3 .. "Animator"].applyRootMotion = true
				arg_428_1.var_[var_431_3 .. "LipSync"] = var_431_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_431_7 = arg_428_1.actors_["1058ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_7) and arg_428_1.var_.characterEffect1058ui_story == nil then
				arg_428_1.var_.characterEffect1058ui_story = var_431_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_8 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_8 and not isNil(var_431_7) then
				if arg_428_1.var_.characterEffect1058ui_story and not isNil(var_431_7) then
					arg_428_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_8 and arg_428_1.time_ < 0 + var_431_8 + arg_431_0 and not isNil(var_431_7) and arg_428_1.var_.characterEffect1058ui_story then
				arg_428_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_431_10 = 0
			local var_431_11 = 0.25

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_12 = arg_428_1:GetWordFromCfg(1105804079)
				local var_431_13 = arg_428_1:FormatText(var_431_12.content)

				arg_428_1.text_.text = var_431_13

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_15 = 10 <= 0 and var_431_11 or var_431_11 * (utf8.len(var_431_13) / 10)

				if (10 <= 0 and var_431_11 or var_431_11 * (utf8.len(var_431_13) / 10)) > 0 and var_431_11 < var_431_15 then
					arg_428_1.talkMaxDuration = var_431_15

					if var_431_15 + var_431_10 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_15 + var_431_10
					end
				end

				arg_428_1.text_.text = var_431_13
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804079", "story_v_side_new_1105804.awb") ~= 0 then
					local var_431_16 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804079", "story_v_side_new_1105804.awb") / 1000

					if var_431_16 + var_431_10 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_16 + var_431_10
					end

					if var_431_12.prefab_name ~= "" and arg_428_1.actors_[var_431_12.prefab_name] ~= nil then
						local var_431_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_12.prefab_name].transform, "story_v_side_new_1105804", "1105804079", "story_v_side_new_1105804.awb")

						arg_428_1:RecordAudio("1105804079", var_431_17)
						arg_428_1:RecordAudio("1105804079", var_431_17)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804079", "story_v_side_new_1105804.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804079", "story_v_side_new_1105804.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_18 = math.max(var_431_11, arg_428_1.talkMaxDuration)

			if var_431_10 <= arg_428_1.time_ and arg_428_1.time_ < var_431_10 + var_431_18 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_10) / var_431_18

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_10 + var_431_18 and arg_428_1.time_ < var_431_10 + var_431_18 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1105804080 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1105804080
		arg_432_1.duration_ = 4.1

		local var_432_0 = {
			zh = 4.1,
			ja = 4
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1105804081(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos1058ui_story = arg_432_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_435_0 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 then
				arg_432_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_432_1.time_ - 0) / var_435_0)
				arg_432_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1058ui_story"].transform.position).z)
				arg_432_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1058ui_story"].transform.localEulerAngles = arg_432_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 then
				arg_432_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_432_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1058ui_story"].transform.position).z)
				arg_432_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1058ui_story"].transform.localEulerAngles = arg_432_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_435_1 = 0
			local var_435_2 = 0.45

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_3 = arg_432_1:GetWordFromCfg(1105804080)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_6 = 18 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_4) / 18)

				if (18 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_4) / 18)) > 0 and var_435_2 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804080", "story_v_side_new_1105804.awb") ~= 0 then
					local var_435_7 = manager.audio:GetVoiceLength("story_v_side_new_1105804", "1105804080", "story_v_side_new_1105804.awb") / 1000

					if var_435_7 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_1
					end

					if var_435_3.prefab_name ~= "" and arg_432_1.actors_[var_435_3.prefab_name] ~= nil then
						local var_435_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_3.prefab_name].transform, "story_v_side_new_1105804", "1105804080", "story_v_side_new_1105804.awb")

						arg_432_1:RecordAudio("1105804080", var_435_8)
						arg_432_1:RecordAudio("1105804080", var_435_8)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1105804", "1105804080", "story_v_side_new_1105804.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1105804", "1105804080", "story_v_side_new_1105804.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_9 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_9 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_9

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_9 and arg_432_1.time_ < var_435_1 + var_435_9 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K01i",
		"TextureConfig/Background/C06b",
		"TextureConfig/Background/R5801a",
		"TextureConfig/Background/R5801"
	},
	voices = {
		"story_v_side_new_1105804.awb"
	}
}
